puts '*** Преднаполнение таблицы users ***'
users = [
  { email: 'user1@example.com', password: ::User::DEFAULT_PASSWORD },
  { email: 'user2@example.com', password: ::User::DEFAULT_PASSWORD },
  { email: 'user3@example.com', password: ::User::DEFAULT_PASSWORD }
]

users.each do |user|
  find_user = User.find_or_initialize_by(email: user[:email])
  if find_user.new_record?
    find_user.assign_attributes(password: user[:password])
    find_user.save!
  end
end
