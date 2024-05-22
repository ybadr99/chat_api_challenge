class MessagesController < ApplicationController
      before_action :set_chat
      before_action :set_message, only: [:show, :update, :destroy]
        
      def search
        if params[:query].present?
          @messages = Message.search(params[:query], @chat.id)
          render json: @messages.records.map { |message| { chat_id: message.chat_id, number: message.number, body: message.body } }
        else
          render json: { error: 'Query parameter cannot be blank' }, status: :unprocessable_entity
        end
      end
      

      def index
        @messages = @chat.messages
        render json: @messages.map { |message| { number: message.number, body: message.body } }
      end
    
      def show
            if @message
              render json: @message.slice(:number, :body, :chat_id)
            else
              render json: { error: 'Message not found' }, status: :not_found
            end
      end

      def create
        if message_params[:body].blank?
          render json: { error: 'Message body cannot be blank' }, status: :unprocessable_entity
        else
          CreateMessageJob.perform_later(@chat.id, message_params[:body])
          render json: { message: 'Message creation initiated' }, status: :accepted
        end
      end
      
      def update
            if @message.update(message_params)
              render json: @message.slice(:number, :body, :chat_id)
            else
              render json: @message.errors, status: :unprocessable_entity
            end
      end

      def destroy
            if @message.destroy
              render json: { message: 'Message successfully deleted' }, status: :ok
            else
              render json: { error: 'Failed to delete the message' }, status: :unprocessable_entity
            end
      end

      private
    
      def set_chat
        application = Application.find_by(token: params[:application_token])
        if application
          @chat = application.chats.find_by(number: params[:chat_number])
          render json: { error: 'Chat not found' }, status: :not_found unless @chat
        else
          render json: { error: 'Application not found' }, status: :not_found
        end
      end

      def set_message
            @message = @chat.messages.find_by(number: params[:number])
            render json: { error: 'Message not found' }, status: :not_found unless @message
      end
    
      def message_params
        params.require(:message).permit(:body)
      end
end