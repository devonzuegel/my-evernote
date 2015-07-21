# encoding: utf-8
describe UsersController, :omniauth do
  describe '#show' do
    it '...' do
      @user = create(:user)
      sign_in(@user)
      get :show, id: @user.id
      puts 'finish me'.yellow
    end
  end
end