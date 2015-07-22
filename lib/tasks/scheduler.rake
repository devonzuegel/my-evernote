desc 'This task is called by the Heroku scheduler.'

task sync_evernote: :environment do
  puts
  puts 'Syncing Evernote accounts...'.black
  User.all.each do |u|
    unless u.auth_token.nil?
      puts '-------------------------------------'.black
      puts "#{u.name || 'nil'.red} -- #{u.email || 'nil'.red}"
      e = EvernoteClient.new(auth_token: u.auth_token)
      update_notebooks(e)
      # update_notes(e)
      ap Notebook.all
    end
  end
  puts '-------------------------------------'.black
  puts 'Done.'.black
  puts
end

def update_notebooks(e)
  e.notebooks.each do |n|
    # ap n.as_json
    en_created_at = Time.at(n.serviceCreated)
    puts "n.serviceCreated = #{n.serviceCreated}"
    puts "en_created_at    = #{en_created_at}"
    Notebook.create(en_created_at: en_created_at)
  end
end

def update_notes(e)
  ap e.notes.as_json
end