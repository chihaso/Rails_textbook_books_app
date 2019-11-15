# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :limit_others, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.post_user = User.find current_user.id
    select_destination comment: @comment
    @comment.save
    redirect_back fallback_location: root_path
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = t ".success.update"
      redirect_to_comment_destination comment: @comment
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = t ".success.destroy"
    redirect_to_comment_destination comment: @comment
  end

  private
    def set_comment
      @comment = Comment.find params[:id]
    end

    def comment_params
      params.require(:comment).permit(:memo, :user_id, :book_id, :report_id)
    end

    def limit_others
      comment = Comment.find params[:id]
      unless current_user == comment.post_user
        flash[:notice] = t "errors.messages.your_own_resources_only"
        redirect_to_comment_destination comment: comment
      end
    end

    def select_destination(comment:)
      if params[:book_id]
        comment.book = Book.find params[:book_id]
      elsif params[:report_id]
        comment.report = Report.find params[:report_id]
      end
    end

    def redirect_to_comment_destination(comment:)
      if comment.book_id
        redirect_to book_path(comment.book_id)
      elsif comment.report_id
        redirect_to report_path(comment.report_id)
      else
        redirect_to root_path
      end
    end
end
