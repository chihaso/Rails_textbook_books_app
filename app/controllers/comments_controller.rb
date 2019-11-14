# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :limit_others, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.post_user = User.find current_user.id
    if params[:book_id]
      @comment.book = Book.find params[:book_id]
    elsif params[:report_id]
      @comment.report = Report.find params[:report_id]
    end
    @comment.save
    redirect_back fallback_location: root_path
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      if @comment.book_id
        redirect_to book_path(@comment.book_id), notice: t(".success.update")
      elsif @comment.report_id
        redirect_to report_path(@comment.report_id), notice: t(".success.update")
      else
        redirect_to root_path
      end
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    if @comment.book_id
      redirect_to book_path(@comment.book_id), notice: t(".success.destroy")
    elsif @comment.report_id
      redirect_to report_path(@comment.report_id), notice: t(".success.destroy")
    else
      redirect_to root_path
    end
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
        if @comment.book_id
          redirect_to book_path(@comment.book_id), notice: t("errors.messages.your_own_resources_only")
        elsif @comment.report_id
          redirect_to report_path(@comment.report_id), notice: t("errors.messages.your_own_resources_only")
        else
          redirect_to root_path
        end
      end
    end
end
