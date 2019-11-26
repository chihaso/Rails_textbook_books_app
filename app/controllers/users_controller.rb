# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page]).per(5)
  end

  def reports
    @user = User.find(params[:id])
    @reports = Kaminari.paginate_array(@user.reports).page(params[:page]).per(5)
  end
end
