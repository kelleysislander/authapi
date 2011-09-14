# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_authapi_session',
  :secret      => '14f30c7d2a23e28e134a3d6694994eb0a59803eac385fca6b31b048860094139ff1a8c1cdb8bc98c6332343df56ac615618581c9153bf3618f8712e6495bb858',
  :domain      => '.semaphoremobile.com'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
