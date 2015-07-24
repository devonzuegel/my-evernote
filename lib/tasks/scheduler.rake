desc 'This task is called by the Heroku scheduler.'

task sync_evernote: :environment do
  Rails.logger.info 'Syncing Evernote accounts...'
  User.all.each do |u|
    unless u.auth_token.nil?
      e = EvernoteClient.new(auth_token: u.auth_token, user_id: u.id)
      sync_notebooks(e)
      sync_notes(e)
    end
  end
end

def sync_notebooks(e)
  # e.notebooks.each { |n| Notebook.sync(n) }
end

def sync_notes(e)
  e.notes.each do |n|
    # TODO get en_updated_at
    Note.sync(n)
  end
end