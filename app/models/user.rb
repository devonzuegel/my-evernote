class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def sync
    unless auth_token.nil?
      e = EvernoteClient.new(auth_token: auth_token, user_id: id)
      e.notebooks.each { |n| Notebook.sync(n) }
      e.notes.each { |n| Note.sync(n) }
    end
  end
end