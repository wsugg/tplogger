require 'spec_helper'
 
 feature 'Creating DriverDrop' do
  scenario "can create a new driver drop" do
   visit root_url
   binding.pry
   click_link 'Driver Drop'
   fill_in 'Branch', :with => '1.1.1'
   fill_in 'Description', :with => "Branch for MS drop 1"
   click_button 'submit'
   page.should have_content('Driver Drop has been saved.')
  end
end