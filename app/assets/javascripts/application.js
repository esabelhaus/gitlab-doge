//= require angular
//= require angular-resource
//= require_self
//= require_tree .

App = angular.module('Doge', ['ngResource']);

App.config(['$httpProvider', '$provide',
  function($httpProvider, $provide) {
    $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

    var elem = angular.element(document.querySelector('#rails_root'));

    $provide.value("rails_root", elem.attr("href"));
  }
]);
