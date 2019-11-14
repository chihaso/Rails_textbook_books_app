# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :limit_unfollower

  def index
    @user = User.find(params[:id])
    @posts = Kaminari.paginate_array(@user.posts).page(params[:page]).per(5)
  end

  private
    def limit_unfollower
      user = User.find(params[:id])
      unless current_user.following?(user) || current_user == user
        redirect_back fallback_location: root_path, notice: t("errors.messages.follower_only")
      end
    end
end
