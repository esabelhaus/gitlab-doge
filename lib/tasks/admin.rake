namespace :admin do
  desc 'set admin for user, requires args of user="user"'
  task add: :environment do
    thisUser = User.where(gitlab_username: "#{ENV['user']}").first
    thisUser.admin = true
    thisUser.save
  end

  desc 'remove admin for user, requires args of user="user"'
  task remove: :environment do
    thisUser = User.where(gitlab_username: "#{ENV['user']}").first
    thisUser.admin = false
    thisUser.save
  end
end