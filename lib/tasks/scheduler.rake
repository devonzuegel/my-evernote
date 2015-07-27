desc 'This task is called by the Heroku scheduler.'

task sync_evernote: :environment do
  Rails.logger.info 'Syncing Evernote accounts...'
  User.all.each(&:sync)
end
