class TemplatesController < ApplicationController

  before_filter :authenticate_user!

  def index
    
  end

  def board
    
  end

  def template
    render "/templates/#{params[:template]}", layout: nil
  end
  
end