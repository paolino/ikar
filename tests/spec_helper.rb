require 'capybara/rspec'

def connect
  visit "/"
  click_button "Connect"
  expect(page).to have_css("img[src*='usb-connected']")
end

def create_byron_wallet(style, options = {})
  visit "/byron-wallets-create"
  find("#style option[value='#{style}']").select_option

  if style == "icarus"
    words = BipMnemonic.to_mnemonic(bits: 164, language: 'english')
    find("#mnemonics").set words
  end

  if options[:mnemonics]
    find("#mnemonics").set options[:mnemonics].join ","
  end

  click_button "Create"
end

def create_shelley_wallet
  visit "/wallets-create"
  click_button "Create"
end

def delete_all
  visit "/byron-wallets-delete-all"
  click_button "Delete all Byron wallets?"
  expect(page).to have_text("Byron wallets: 0")

  visit "/wallets-delete-all"
  click_button "Delete all Shelley wallets?"
  expect(page).to have_text("Shelley wallets: 0")

end

require_relative '../app'  # <-- your sinatra app
require_relative '../helpers/app_helpers'
require_relative '../helpers/discovery_helpers'
