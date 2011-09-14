class ApiController < ApplicationController
  def access
    if request.post?
      render :nothing => true, :status => Dictator.access(params)
    else
      render :nothing => true, :status => 400
    end
  end
end
