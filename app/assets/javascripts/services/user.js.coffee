App.factory 'User', ['$resource', ($resource) ->
  $resource "#{ENV['RAILS_RELATIVE_ROOT_URL']}/user"
]
