desc 'This task is called by the Heroku scheduler.'

task sync_evernote: :environment do
  puts
  puts 'Syncing Evernote accounts...'.black
  User.all.each do |u|
    unless u.auth_token.nil?
      puts '-------------------------------------'.black
      puts "#{u.name || 'nil'.red} -- #{u.auth_token || 'nil'.red}"
    end
  end
  puts '-------------------------------------'.black
  puts 'Done.'.black
  puts
end