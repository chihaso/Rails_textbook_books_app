# frozen_string_literal: true

class FollowersController < ApplicationController
  def index
    user = User.find(params[:id])
    follower_ids = user.passive_relationships.map  { |a| a.follower_id }
    @users = Kaminari.paginate_array(follower_ids.map { |id| User.find(id) }).page(params[:page]).per(5)
  end
end
