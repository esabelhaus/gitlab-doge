App.factory 'Sync', ['$resource', ($resource) ->
  $resource "#{ENV['RAILS_RELATIVE_ROOT_URL']}/repo_syncs/:id", {id: '@id'}
]
