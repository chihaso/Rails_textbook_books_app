# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :limit_others, only: [:edit, :update, :destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back fallback_location: root_path
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = t ".success.update"
      redirect_to @comment.commentable
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = t ".success.destroy"
    redirect_to @comment.commentable
  end

  private
    def set_comment
      @comment = Comment.find params[:id]
    end

    def comment_params
      params.require(:comment).permit(:memo, :user_id)
    end

    def limit_others
      comment = Comment.find params[:id]
      unless current_user == comment.user
        flash[:notice] = t "errors.messages.your_own_resources_only"
        redirect_to @commentable
      end
    end
end
