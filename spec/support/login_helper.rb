def login(email, password)
  visit root_path
  fill_in :email, with: email
  fill_in :password, with: password
  click_button "Зайти"
end
