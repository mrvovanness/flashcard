def login(email, password)
  visit root_path
  fill_in :email, with: email
  fill_in :password, with: password
  click_button I18n.t(:login)
end
