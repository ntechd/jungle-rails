class Admin::DashboardController < Admin::BaseController
  http_basic_authenticate_with :name => ENV["HTTP_AUTH_NAME"], :password => ENV["HTTP_AUTH_PASSWORD"]
  def show 
    
  end
end
