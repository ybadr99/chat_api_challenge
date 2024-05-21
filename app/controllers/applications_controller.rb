class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

  def create
    @application = Application.new(application_params)
    if @application.save
      render json: @application.slice(:name, :token), status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def update
    if @application.update(application_params)
      render json: @application.slice(:name, :token)
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @application.slice(:name, :token)
  end

  def destroy
    if @application.destroy
      render json: { message: 'Application successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete the application' }, status: :unprocessable_entity
    end
  end

  private

  def set_application
    @application = Application.find_by(token: params[:token])
    render json: { error: 'Application not found' }, status: :not_found unless @application
  end

  def application_params
    params.require(:application).permit(:name)
  end
end
