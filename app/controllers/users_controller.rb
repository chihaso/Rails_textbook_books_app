# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :limit_unfollower, { only: [:posts] }

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(5)
  end

  def following
    user = User.find(params[:id])
    following_ids = user.active_relationships.map  { |a| a.followee_id }
    @users = Kaminari.paginate_array(following_ids.map { |id| User.find(id) }).page(params[:page]).per(5)
  end

  def followers
    user = User.find(params[:id])
    follower_ids = user.passive_relationships.map  { |a| a.follower_id }
    @users = Kaminari.paginate_array(follower_ids.map { |id| User.find(id) }).page(params[:page]).per(5)
  end

  def posts
    @user = User.find(params[:id])
    @posts = Kaminari.paginate_array(@user.posts).page(params[:page]).per(5)
  end

  def limit_unfollower
    user = User.find(params[:id])
    unless current_user.following?(user) || current_user == user
      redirect_back fallback_location: root_path, notice: t("errors.messages.follower_only")
    end
  end
end
