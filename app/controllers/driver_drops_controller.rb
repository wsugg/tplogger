class DriverDropsController < ApplicationController

 def index

 end

 def new
 	@driver_drop = DriverDrop.new
 end
end
