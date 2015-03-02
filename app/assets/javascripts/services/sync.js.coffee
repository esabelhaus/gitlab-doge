App.factory 'Sync', ['$resource', "rails_root", ($resource, rails_root) ->
  $resource rails_root + "/repo_syncs/:id", {id: '@id'}
]
