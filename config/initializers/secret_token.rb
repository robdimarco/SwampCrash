# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Swampcrash::Application.config.secret_token = ENV['SWAMPCRASH_SECRET_TOKEN'] || '1a46d4c846645381f668fad519a7381b3c155b0f1e4d4a3f9723d7743aee71874ab083f56b8021e819a644bb459cd4ec94ca20a3c79a4d255c8be9cc3555f1b5'
