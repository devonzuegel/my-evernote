describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe 'has_valid_token?' do
    it 'should return true' do
      allow_any_instance_of(EvernoteClient).to receive(:ping_evernote)
      @user = create(:user, auth_token: Faker::Lorem.characters(20))
      expect(@user.has_valid_token?).to eq true
    end

    it "should return false when we don't have a token" do
      @user = create(:user, auth_token: nil)
      expect(@user.has_valid_token?).to eq false
    end

    it 'should return false when we have an invalid token' do
      allow_any_instance_of(EvernoteClient).to receive(:ping_evernote) {
        raise Evernote::EDAM::Error::EDAMUserException, 'Invalid authentication token.'
      }
      @user = create(:user, auth_token: Faker::Lorem.characters(20))
      expect(@user.has_valid_token?).to eq false
    end
  end

  describe 'token_status' do
    it 'should return :connect' do
      @user = build(:user, auth_token: nil)
      expect(@user.token_status).to eq :connect
    end

    it 'should return :valid_token' do
      allow_any_instance_of(User).to receive(:has_valid_token?) { true }
      @user = build(:user, auth_token: Faker::Lorem.characters(20))
      expect(@user.token_status).to eq :valid_token
    end

    it 'should return :reconnect' do
      allow_any_instance_of(User).to receive(:has_valid_token?) { false }
      @user = build(:user, auth_token: Faker::Lorem.characters(20))
      expect(@user.token_status).to eq :reconnect
    end
  end

end
