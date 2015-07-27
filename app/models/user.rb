class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notebooks

  def notes
    notebooks.collect(&:notes).flatten.uniq
  end

  def sync
    unless auth_token.nil?
      en_client = EvernoteClient.new(auth_token: auth_token, user_id: id)
      en_client.notebooks.each { |notebook| Notebook.sync(notebook) }
      en_client.notes.each { |note| Note.sync(note) }
    end
  end

  def has_valid_token?
    return false if auth_token.nil?
    begin
      en_client = EvernoteClient.new(auth_token: auth_token, user_id: self)
    rescue Evernote::EDAM::Error::EDAMUserException => e
      return false
    end
    true
  end

  def token_status
    case
    when auth_token.nil?  then :connect
    when has_valid_token? then :valid_token
    else :reconnect
    end
  end
end
