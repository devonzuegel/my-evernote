class EvernoteSync

  def sync
    User.all.each do |u|
      unless u.auth_token.nil?
        e = EvernoteClient.new(auth_token: u.auth_token, user_id: u.id)
        e.notebooks.each { |n| Notebook.sync(n) }
        e.notes.each { |n| Note.sync(n) }
      end
    end
  end

end