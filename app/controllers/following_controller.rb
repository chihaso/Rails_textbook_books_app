# frozen_string_literal: true

class FollowingController < ApplicationController
  def index
    user = User.find(params[:id])
    following_ids = user.active_relationships.map  { |a| a.followee_id }
    @users = Kaminari.paginate_array(following_ids.map { |id| User.find(id) }).page(params[:page]).per(5)
  end
end
