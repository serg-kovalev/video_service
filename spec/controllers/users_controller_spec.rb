require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    allow_any_instance_of(Authorization).to receive(:fetch_details_from_facebook)
    allow_any_instance_of(Authorization).to receive(:fetch_details_from_google_oauth2) 
    @user.authorizations << FactoryGirl.create(:facebook_auth)
    @user.authorizations << FactoryGirl.create(:google_oauth2)
    sign_in @user
  end

  it 'should have a current_user' do
    expect(subject.current_user).to_not be_nil
  end 

  it 'should be able to update his details' do
    put :update, id: @user.id, user: { name: 'New Name', about: 'Something' }
    expect(response).to be_redirect
    expect(subject).to redirect_to(user_url(@user))
    @user.reload
    expect(@user.name).to eq('New Name') 
    expect(@user.about).to eq('Something')
  end

  it 'should NOT be able to update not own details' do
    user = FactoryGirl.create(:user)
    put :update, id: user.id, user: { name: 'New Name', about: 'Something' }
    expect(response).to be_redirect
    expect(subject).to redirect_to(root_url)
    user.reload
    expect(user.name).to_not eq('New Name') 
    expect(user.about).to_not eq('Something')
  end

  it 'should be able to edit his details' do
    get :edit, id: @user.id
    expect(response).to be_success
  end
end
