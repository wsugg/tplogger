require 'spec_helper'
 
 feature 'Uploading Test Log File' do
  scenario "can upload a test log" do
   visit '/'
   click_link 'Upload Logs'
   fill_in 'Name', :with => 'TextMate 2'
   fill_in 'Description', :with => "A text-editor for OS X"
   click_button 'submit'
   page.should have_content('Test Logs have been saved.')
  end
end
