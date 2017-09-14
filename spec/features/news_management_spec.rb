require "rails_helper"

RSpec.feature "News management", type: :feature do
  scenario "User creates news" do
    visit "/admin"
    fill_in "Header", with: "My news"
    fill_in "Annotation", with: "My news text"
    fill_in "Expired at", with: Time.now + 10.minutes
    click_button "Create News"
    expect(page).to have_text("News item was successfully created.")

    visit "/"
    expect(page).to have_text("My news")
    expect(page).to have_text("My news text")
    expect(page).to have_text((Time.now).to_date)
  end
end
