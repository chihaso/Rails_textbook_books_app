# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    user = User.find(params[:followee_id])
    current_user.follow(user)
    redirect_to user_path(user.id)
  end

  def destroy
    user = Follow.find(params[:id]).followee
    current_user.unfollow(user)
    redirect_to user_path(user.id)
  end
end
