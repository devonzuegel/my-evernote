# Load libraries required by the Evernote OAuth
require 'oauth'
require 'oauth/consumer'

# Load Thrift & Evernote Ruby libraries
require "evernote_oauth"

site = ENV['EN_SANDBOX'] ? 'https://sandbox.evernote.com' : 'https://www.evernote.com'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :evernote, ENV['EN_CONSUMER_KEY'], ENV['EN_SECRET_KEY'], client_options: { site: site }
end

OmniAuth.config.on_failure = EvernoteLoginController.action(:oauth_failure)
