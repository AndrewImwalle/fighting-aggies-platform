# frozen_string_literal: true

module Api
  module V1
    class AnalysesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        analyses = Analysis.all.order(created_at: :desc)
        render json: analyses
      end

      def create
        p analysis_params

        unless analysis_params[:id]
          render status: :bad_request, json: { errormessage: 'No ID was provided' }.to_json and return
        end

        begin
          analysis = Analysis.create!(analysis_params[:id])
        rescue StandardError => e
          render status: :bad_request, json: { errormessage: e }.to_json and return
        end

        if analysis_params.key?(:include_raw_data) && analysis_params[:include_raw_data]
          vision = Vision.find_by(video_id: analysis_params[:id])
          if vision.nil?
            render status: :internal_server_error,
                   json: { errormessage: 'Vision for video not found in db' }.to_json and return
          end

          analysis.report = {
            'frontend_report' => JSON.parse(analysis.report),
            'raw_data' => JSON.parse(vision.report)
          }.to_json
        end

        render status: :created, json: analysis
      end

      def show
        unless analysis_params[:id]
          render status: :bad_request, json: { errormessage: 'No ID was provided' }.to_json and return
        end

        begin
          analysis ||= Analysis.find(analysis_params[:id])
        rescue StandardError
          render status: :bad_request,
                 json: { errormessage: 'Analysis for Video with requested ID not found in DB' }.to_json and return
        end

        if analysis_params.key?(:include_raw_data) && analysis_params[:include_raw_data]
          vision = Vision.find_by(video_id: analysis_params[:id])
          if vision.nil?
            render status: :internal_server_error,
                   json: { errormessage: 'Vision for video not found in db' }.to_json and return
          end

          analysis.report = {
            'frontend_report' => JSON.parse(analysis.report),
            'raw_data' => JSON.parse(vision.report)
          }.to_json
        end

        render status: :ok, json: analysis
      end

      def destroy
        unless analysis_params[:id]
          render status: :bad_request, json: { errormessage: 'No ID was provided' }.to_json and return
        end

        begin
          analysis ||= Analysis.find(analysis_params[:id])
        rescue StandardError
          render status: :bad_request,
                 json: { errormessage: 'Analysis for Video with requested ID not found in DB' }.to_json and return
        end

        analysis&.destroy
        render status: :ok, json: analysis and return
      end

      private

      def analysis_params
        params.permit(:id, :include_raw_data)
      end
    end
  end
end
