App.factory 'Repo', ['$resource', ($resource) ->
  $resource "#{ENV['RAILS_RELATIVE_ROOT_URL']}/repos/:id", {id: '@id'},
    activate:
      method: 'POST', url: 'repos/:id/activation'
    deactivate:
      method: 'POST', url: 'repos/:id/deactivation'
]
