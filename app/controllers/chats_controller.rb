class ChatsController < ApplicationController
      before_action :set_application

      def create
        @chat = @application.chats.new
        if @chat.save
          render json: @chat.slice(:number, :messages_count), status: :created
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      def show
        @chat = @application.chats.find_by(number: params[:number])
        if @chat
          render json: @chat.slice(:number, :messages_count)
        else
          render json: { error: 'Chat not found' }, status: :not_found
        end
      end

      def index
        @chats = @application.chats.select(:number, :messages_count)
        render json: @chats.map { |chat| { number: chat.number, messages_count: chat.messages_count } }
      end

      private

      def set_application
        @application = Application.find_by(token: params[:application_token])
        render json: { error: 'Application not found' }, status: :not_found unless @application
      end
end