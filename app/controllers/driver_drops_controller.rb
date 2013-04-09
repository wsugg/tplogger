class DriverDropsController < ApplicationController

 def index

 end

 def new
 	@driver_drop = Driver_Drop.new
 end
end
