class LoglinesController < ApplicationController
  def create
    missing_fields = ["source", "id", "level", "line"] - logline_params.keys

    if missing_fields.empty?
      case logline_params[:level]
      when "debug"
        Rails.logger.debug("source:#{logline_params[:source]} id:#{logline_params[:id]} - #{logline_params[:line]}")
      when "info"
        Rails.logger.info("source:#{logline_params[:source]} id:#{logline_params[:id]} - #{logline_params[:line]}")
      when "warn"
        Rails.logger.warn("source:#{logline_params[:source]} id:#{logline_params[:id]} - #{logline_params[:line]}")
      when "error"
        Rails.logger.error("source:#{logline_params[:source]} id:#{logline_params[:id]} - #{logline_params[:line]}")
      when "fatal"
        Rails.logger.unknown("source:#{logline_params[:source]} id:#{logline_params[:id]} - #{logline_params[:line]}")
      when "unknown"
        Rails.logger.debug("source:#{logline_params[:source]} id:#{logline_params[:id]} - #{logline_params[:line]}")
      end

      head :created
    else
      render :json, { data: { error: "missing required fields: #{missing_fields.join(', ')}" }, status: :unprocessable_entity }
    end
  end

  def logline_params
    params.permit(:source, :id, :level, :line)
  end
end
