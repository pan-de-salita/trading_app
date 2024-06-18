class ApplicationController < ActionController::Base
  def say_hello
    render html: 'hello.'
  end
end
