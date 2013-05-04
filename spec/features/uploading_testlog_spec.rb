require 'spec_helper'
 
 feature 'Uploading Test Log File' do
  scenario "can upload a test log" do
   visit '/'
   click_link 'Upload Logs'
   fill_in 'Path to Logs', :with => "\\"
   click_button 'submit'
   page.should have_content('Test Logs have been saved.')
  end
end
