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

  task sync_fix: :environment do
    User.where(refreshing_repos: true).map{|u| u.update_attribute(:refreshing_repos, false)}
  end
end