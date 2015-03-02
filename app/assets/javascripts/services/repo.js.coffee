App.factory 'Repo', ['$resource', "rails_root", ($resource, rails_root) ->
  $resource rails_root + "/repos/:id", {id: '@id'},
    activate:
      method: 'POST', url: 'repos/:id/activation'
    deactivate:
      method: 'POST', url: 'repos/:id/deactivation'
]
