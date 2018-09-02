class LoglinesController < ApplicationController
  def create
    case logline_params[:level]
    when "debug"
      Rails.logger.debug("id:#{logline_params[:id]} - #{logline_params[:line]}")
    when "info"
      Rails.logger.info("id:#{logline_params[:id]} - #{logline_params[:line]}")
    when "warn"
      Rails.logger.warn("id:#{logline_params[:id]} - #{logline_params[:line]}")
    when "error"
      Rails.logger.error("id:#{logline_params[:id]} - #{logline_params[:line]}")
    when "fatal"
      Rails.logger.unknown("id:#{logline_params[:id]} - #{logline_params[:line]}")
    when "unknown"
      Rails.logger.debug("id:#{logline_params[:id]} - #{logline_params[:line]}")
    end

    head :created
  end

  def logline_params
    params.permit(:id, :line, :level)
  end
end
