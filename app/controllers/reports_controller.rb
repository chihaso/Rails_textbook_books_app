# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :limit_others, only: [:edit, :update, :destroy]

  # GET /reports
  def index
    @reports = Report.page(params[:page]).per(5)
  end

  # GET /reports/1
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  def create
    @report = Report.new(report_params)
    @report.post_user = User.find current_user.id
    if @report.save
      redirect_to @report, notice: t(".success.create")
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      redirect_to @report, notice: t(".success.update")
    else
      render :edit
    end
  end

  # DELETE /reports/1
  def destroy
    @report.destroy
    redirect_to reports_url, notice: t(".success.destroy")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :memo, :user_id)
    end

    def limit_others
      report = Report.find(params[:id])
      unless current_user == report.post_user
        redirect_back fallback_location: reports_path, notice: t("errors.messages.your_own_resources_only")
      end
    end
end
