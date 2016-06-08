class DemoController < ApplicationController
  layout false

  def index

  end

  def hello
    @hello = "Ohai!"
    @array = [1,2,3,4,5]
    @id = params['id']
    @page = params[:page].to_i
  end

  def other_hello
    redirect_to(controller: 'demo', action: 'hello')
  end

  def text_helpers
  end

  def escape_helpers
  end
end
