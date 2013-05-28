require 'nokogiri'
class DriverDropsController < ApplicationController
  def index
   @driver_drops = DriverDrop.all
   data_table = GoogleVisualr::DataTable.new
   
   data_table.new_column('string', 'Branch' )
   data_table.new_column('number', 'x86 Failures')
   data_table.new_column('number', 'x64 Failures')
   
    @driver_drops.each do |drop|
     data_table.add_rows([[drop.branch , 
                          Log.where(:driver_drop_id => drop.id, :platform => "x86", :passfail => "failed").count, 
                          Log.where(:driver_drop_id => drop.id, :platform => "AMD64", :passfail => "failed").count,
                          ]])
    end
  
   option = { width: 700, height: 500,   
              vAxis: {title: 'Driver Branch', titleTextStyle: {color: 'green'}},
              hAxis: {title: 'Failures', titleTextStyle: {color: 'red'}}
            }


   @chart = GoogleVisualr::Interactive::BarChart.new(data_table, option)
   #@chart.add_listener('ready', "window.readyHandler")
   @chart.add_listener('select', "window.selectHandler")
   #binding.pry

  end

  def new
   @driver_drop = DriverDrop.new
  end

  def create 
   @driver_drop = DriverDrop.new(params[:driver_drop])

   if @driver_drop.save
    flash[:success] = "The Driver Drop has been added."
    redirect_to root_url
   else
    flash[:error] = "The Driver Drop has not been Added."
    render :action => "new"
   end
  end

  def edit
    @driver_drop = DriverDrop.find(params[:id])
    flash[:info] = "This is a info flash message"
  end

  def update
    @driver_drop = DriverDrop.find(params[:id])

    if @driver_drop.update_attributes(params[:driver_drop])
      flash[:success] = "Driver Drop was changed."
      redirect_to driver_drop_path
    else
      flash[:error] = "Driver Drop was not changed."
      render action: "edit"
    end
    path = [params[:driver_drop][:logpath],params[:driver_drop][:x64logpath]]
    get_log_file_collection(path)
  end

  def show
    @driver_drop = DriverDrop.find(params[:id])
    @log = Log.where(:driver_drop_id => params[:id])
    @x86log = @log.where(:driver_drop_id => params[:id], 
                        :passfail => "failed",
                        :platform => "x86")

    @x64log = @log.where(:driver_drop_id => params[:id], 
                        :passfail => "failed",
                        :platform => "AMD64")
    @unknown = @log.where(:driver_drop_id => params[:id], 
                        :passfail => "failed",
                        :platform => nil )

    @log_count = @log.where(:driver_drop_id => params[:id]).count
    @log_nill_count = @log.where(:platform => nil).count

    @log_group = @log.where(:driver_drop_id => params[:id], 
                           :passfail => "failed").group_by(&:platform)
  end

  def send_mail
    @driver_drop = DriverDrop.find(params[:id])
    binding.pry
    email = DropMailer.send_drop_mail(@driver_drop).deliver
    if !email.empty?
     flash[:success] = "Drop mail was successfully created."
     redirect_to root_url
    else
      flash[:error] = "Drop mail was NOT successfully created."
      redirect_to root_url
    end
  end

  def get_log_file_collection(path)
    if path == nil 
      flash[:error] = "Path is: #{path}."
    else
      path.each do |p|
       f = File.expand_path(p)
       d = File.directory?(f)
        if d == false 
         flash[:error] = "Check your spelling: #{p}."
        else
         files = Dir.entries(f)
         files.delete(".")
         files.delete("..")
         files.delete_if{|file| file.include?(".trace") | file.include?(".xsl") |
                                file.include?(".xslt")  | file.include?(".txt") |
                                file.include?(".log")   | file.include?(".ini") |
                                file.include?("ShellRunner.wtl") }
#binding.pry
          files.each do |file|
           parse_log("#{f}/#{file}",file)
          end
        end
      end 
    end
  end

  def parse_log(logf,fname)
      logfile = nil
      logfile = Nokogiri::XML(File.open(logf))
      
      @log = Log.new
      #@log.testlog = logf

      @log.name = fname
      #logfile.xpath("//TestFileName").attribute("UserText").to_s
      @log.driver_drop_id = @driver_drop.id
      #binding.pry
      #res = logfile.xpath("//Machine").attribute("Platform").to_s
      #puts res
      #puts logfile
      platform = logfile.xpath("//Machine")
      #binding.
      if platform.empty?
       @log.platform = nil
      else 
       @log.platform = logfile.xpath("//Machine").attribute("Platform").to_s 
      end
      #logfile.xpath("//PFRollup").attribute("Failed").to_s != "0"

     grollup = logfile.xpath("//GroupRollup")
     pfrollup = logfile.xpath("//PFRollup")
     
     if grollup.empty? && pfrollup.empty?
      flash[:error] = "#{logfile} has no rollup section. Might be corrupt."
     end

      if pfrollup.attribute("Failed").to_s != "0"
        @log.passfail = "failed"
        tcl = logfile.xpath("//TestCommandLine")
        if tcl.empty?
        else
          @log.cmdline = logfile.xpath("//TestCommandLine").attribute("UserText").to_s
        end
        @log.save
        flash[:warning] = "Failures found in #{@log.default_name} and were processed."
      end
  end
end
