class MessagesController < ApplicationController
  def update
    @msg = Message.find params[:id]
    @msg.update_attributes params[:msg]
    render :nothing => true
  end
end
