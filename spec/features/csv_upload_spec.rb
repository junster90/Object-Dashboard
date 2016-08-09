require 'rails_helper'

feature 'CSV Upload', type: :feature do
  let(:good_file) { "#{TEST_FILES_PATH}/correct_objects.csv" }
  let(:bad_header_file) { "#{TEST_FILES_PATH}/wrong_headers.csv" }
  let(:blank_records_file) { "#{TEST_FILES_PATH}/blank_objects.csv" }
  let(:duplicate_records_file) { "#{TEST_FILES_PATH}/duplicate_objects.csv" }

  scenario 'User uploads a good csv' do
    visit '/'

    page.attach_file('object_batch_file', good_file)
    click_button 'Import'

    expect(page).to have_text('Successfully imported from CSV!')
  end

  scenario 'User uploads a csv with bad headers' do
    visit '/'

    page.attach_file('object_batch_file', bad_header_file)
    click_button 'Import'

    expect(page).to have_text("Invalid CSV headers provided. Please check that your headers include ['object_id', 'object_type', 'timestamp', 'object_changes'] and try again.")
  end

  scenario 'User uploads a csv with duplicate records' do
    visit '/'

    page.attach_file('object_batch_file', duplicate_records_file)
    click_button 'Import'

    expect(page).to have_text("There are duplicates in your CSV file. Please ensure there are no duplicates before uploading.")
  end

  scenario 'User uploads a csv with blanks' do
    visit '/'

    page.attach_file('object_batch_file', blank_records_file)
    click_button 'Import'

    expect(page).to have_text("There are invalid records in your CSV file. Please ensure there are no blanks or existing saved records in your file.")
  end

  scenario 'User uploads a good csv with records existing in db' do
    ObjectRecordCsvImporter.new(good_file).import

    visit '/'

    page.attach_file('object_batch_file', good_file)
    click_button 'Import'

    expect(page).to have_text("There are invalid records in your CSV file. Please ensure there are no blanks or existing saved records in your file.")
  end
end