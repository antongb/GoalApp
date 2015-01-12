require 'rails_helper'

feature "the signup process" do

  scenario "has new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      @user = FactoryGirl.build(:user)
      fill_in 'username', with: @user.username
      fill_in 'password', with: 'password'
      click_button "Create User"
    end

    scenario "redirects to user index after signup" do
      expect(page).to have_content "#{@user.username.capitalize}"
    end

    scenario "shows username on homepage after signup" do
      visit users_url
      expect(page).to have_content "Logged in as: #{@user.username}"
    end
  end

  feature "Logging in" do
    before(:each) do
      visit new_session_url
      @user = FactoryGirl.build(:user)
      fill_in 'username', with: "user"
      fill_in 'password', with: ''
      click_button "Login User"
    end

    scenario "shows invalid credentials error" do
      expect(page).to have_content "Invalid credentials"
    end
  end

  feature "logout" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "user"
      fill_in 'Password', with: "password"
      click_button "Create User"
    end

    scenario "logs out" do
      visit new_session_url
      fill_in 'Username', with: "user"
      fill_in 'Password', with: "password"
      click_button "Login User"
      click_button "Logout User"
      expect(page).to have_content "Login User"
    end
  end

end
