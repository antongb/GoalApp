feature "comment on everything" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @public_goal = FactoryGirl.create(:goal, private: 'false', user_id: @user.id)
    FactoryGirl.create(:comment, commentable_type: 'User', commentable_id: @user.id)
    
  end
end
