# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    @user = User.find(params[:followee_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user.id) }
      format.js
    end
  end

  def destroy
    @user = Follow.find(params[:id]).followee
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to user_path(@user.id) }
      format.js
    end
  end
end
