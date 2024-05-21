
class ApplicationsController < ApplicationController
      def create
        @application = Application.new(application_params)
        if @application.save
          render json: @application.slice(:name, :token), status: :created
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end
  
      def update
        @application = Application.find_by(token: params[:token])
        if @application.update(application_params)
          render json: @application.slice(:name, :token)
        else
          render json: @application.errors, status: :unprocessable_entity
        end
      end
  
      def show
        @application = Application.find_by(token: params[:token])
  
        if @application
          render json: @application.slice(:name, :token)
        else
          render json: { error: 'Application not found' }, status: :not_found
        end
      end
  
      private
  
      def application_params
        params.require(:application).permit(:name)
      end
end