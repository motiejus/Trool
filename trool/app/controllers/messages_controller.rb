require 'ruby-debug'
require 'json'

class MessagesController < ApplicationController
  respond_to :html, :json

  def update
    @msg = Message.find params[:id]

    # If fuzzy-id passed in request - change it
    fuzzy_arr = params.keys.grep /fuzzy-\d+/
    if not fuzzy_arr.empty?
      params[:msg] ||= {}
      params[:msg][:fuzzy] = params[fuzzy_arr.first] == "1"
    end

    # Handle all other message parameters
    @msg.update_attributes params[:msg]

    # Check for errors
    if @msg.valid?
      render :json => "Saved.".to_json,
    else
      # Return error message
      render :json => @msg.errors.to_json,
          :status => :unprocessable_entity
    end
  end
end
