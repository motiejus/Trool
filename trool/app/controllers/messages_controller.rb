require 'ruby-debug'
class MessagesController < ApplicationController
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

    render :nothing => true
  end
end
