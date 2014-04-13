trelloClone = angular.module('trelloClone', ['ngResource', 'ngRoute', 'ui.sortable'])

trelloClone.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

trelloClone.config ($locationProvider, $routeProvider) ->
  $locationProvider.html5Mode true
  $routeProvider
    .when "/dashboard", templateUrl: "/templates/index.html", controller: 'DashboardController'
    .when '/', redirectTo: '/dashboard'
    
