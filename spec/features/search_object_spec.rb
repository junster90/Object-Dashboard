require 'rails_helper'

feature 'Search Object', type: :feature do
  let(:good_file) { "#{TEST_FILES_PATH}/correct_objects.csv" }
  let(:bad_header_file) { "#{TEST_FILES_PATH}/wrong_headers.csv" }
  let(:blank_records_file) { "#{TEST_FILES_PATH}/blank_objects.csv" }
  let(:duplicate_records_file) { "#{TEST_FILES_PATH}/duplicate_objects.csv" }

  before do
    FactoryGirl.create(:first_record)
    FactoryGirl.create(:second_record)
    FactoryGirl.create(:last_record)
  end

  scenario 'User queries for an existing record', js: true do
    visit '/'

    fill_in 'search_object_id', with: "1"
    fill_in 'search_object_type', with: "ObjectA"
    click_button 'Search'

    expect(page).to have_text('property1: 2nd value')
    expect(page).to have_text('property2: 2nd value')
    expect(page).to have_text('property3: 1st value')
  end

  scenario 'User queries for an existing record with a specific timestamp', js: true do
    visit '/'

    fill_in 'search_object_id', with: "1"
    fill_in 'search_object_type', with: "ObjectA"
    fill_in 'search_timestamp', with: 3.weeks.ago.to_s

    click_button 'Search'

    expect(page).to have_text('property1: 1st value')
    expect(page).to have_text('property2: 2nd value')
  end

  scenario 'User queries for a non existing record', js: true do
    visit '/'

    fill_in 'search_object_id', with: "3"
    fill_in 'search_object_type', with: "ObjectD"
    click_button 'Search'

    expect(page).to have_text('No objects found with these parameters!')
  end

end