class PackagesController < ApplicationController
 
 def new
 	@package = Package.new
 end

 def create
 	 flash[:success] = "TESTING:   The Driver Package has been started."
 	 redirect_to root_url
 end

end
