describe EvernoteClient do
  describe 'initialization' do
    it 'should fail if client doesn\'t pass it an auth_token' do
      expect { EvernoteClient.new }.to raise_error KeyError
    end

    it 'should succeed with a valid provided auth_token'
    it 'should fail with an invalid auth_token' do
      expect { EvernoteClient.new(auth_token: 'invalid_token') }.to raise_error
    end
  end
end
