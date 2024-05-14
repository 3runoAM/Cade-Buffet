require "rails_helper"

describe "User visits root path" do
  it "and sees register link" do
    visit root_path

    within('#nav') do
      expect(page).to have_content "Cadê Buffet?"
      expect(page).to have_link "Inscrever-se"
      expect(page).to have_link "Login"
    end

    expect(page).to have_content "Boas-vindas ao Cadê Buffet!"
  end
end