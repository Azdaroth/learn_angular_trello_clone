trelloClone = angular.module('trelloClone', ['ngResource', 'ngRoute'])

trelloClone.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

trelloClone.config ($locationProvider, $routeProvider) ->
  $locationProvider.html5Mode true
  $routeProvider
    .when '/', redirectTo: '/dashboard'
    .when "/dashboard", templateUrl: "/templates/dashboard.html", controller: 'DashboardCtrl'
