require 'rails_helper'


feature "users show page shows goals" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @public_goal = FactoryGirl.create(:goal, private: 'false', user_id: @user.id)
    @private_goal = FactoryGirl.create(:goal, title: "Private", user_id: @user.id)
  end

  scenario "user can see all own goals" do
    login! @user

    expect(page).to have_content("Public")
    expect(page).to have_content("Private")
  end

  scenario "user can't see other user's private goals" do

    new_user = FactoryGirl.create(:user, :username => 'username1')
    login!(new_user)

    visit user_url(@user)
    expect(page).to have_content("Public")
    expect(page).to have_no_content("Private")
  end

  scenario "shows completed goals" do
    @private_goal.update!(:completed => 't')
    login!(@user)
    visit user_url(@user)
    expect(page).to have_content("Completed!")
  end


end
