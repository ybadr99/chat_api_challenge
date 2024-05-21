class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: [:show, :destroy]

  def create
    @chat = @application.chats.new
    if @chat.save
      render json: @chat.slice(:number, :messages_count), status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @chat.slice(:number, :messages_count)
  end

  def index
    @chats = @application.chats.select(:number, :messages_count)
    render json: @chats.map { |chat| { number: chat.number, messages_count: chat.messages_count } }
  end

  def destroy
    if @chat.destroy
      render json: { message: 'Chat successfully deleted' }, status: :ok
    else
      render json: { error: 'Failed to delete the chat' }, status: :unprocessable_entity
    end
  end

  private

  def set_application
    @application = Application.find_by(token: params[:application_token])
    render json: { error: 'Application not found' }, status: :not_found unless @application
  end

  def set_chat
    @chat = @application.chats.find_by(number: params[:number])
    render json: { error: 'Chat not found' }, status: :not_found unless @chat
  end

  def chat_params
    params.require(:chat).permit(:number, :messages_count)
  end
end
