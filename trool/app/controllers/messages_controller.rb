require 'ruby-debug'
class MessagesController < ApplicationController
  def update
    @msg = Message.find params[:id]

    # TODO: learn ruby
    fuzzy_arr = (params.keys.grep /fuzzy-\d+/) or []
    fuzzy_bool = params[fuzzy_arr.first] == "1"

    params[:msg] ||= {}
    params[:msg].merge!( { :fuzzy => fuzzy_bool } )
    @msg.update_attributes params[:msg]
    render :nothing => true
  end
end
