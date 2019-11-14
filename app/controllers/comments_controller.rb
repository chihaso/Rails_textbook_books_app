# frozen_string_literal: true

class CommentsController < ApplicationController
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
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:memo, :user_id, :book_id, :report_id)
    end
end
