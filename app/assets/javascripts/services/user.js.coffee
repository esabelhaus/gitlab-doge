App.factory 'User', ['$resource', "rails_root", ($resource, rails_root) ->
  $resource rails_root + "/user"
]
