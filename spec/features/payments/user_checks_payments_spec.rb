require 'spec_helper'

feature 'User checks teacher details' do
  background do
    3.times { create(:student, with_payments: 2) }

    sign_in
    expect(page).to have_content 'Logout'
    visit payments_path
  end

  scenario do
    within('.breadcrumbs') do
      expect(page).to have_content 'RoR Workhops » Payments'
    end
  end

  scenario 'list contains student name', js: true do
    expect(page).to have_content(Student.all.sample.first_name)
  end

  scenario 'only when sign in' do
    logout
    visit payments_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
