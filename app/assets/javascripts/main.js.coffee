trelloClone = angular.module('trelloClone', ['ngResource', 'ngRoute',
 'ui.sortable', 'xeditable', 'underscore', 'ui.bootstrap'])

trelloClone.run (editableOptions) ->
  editableOptions.theme = 'bs3'

trelloClone.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

trelloClone.config ($locationProvider, $routeProvider) ->
  $locationProvider.html5Mode true
  $routeProvider
    .when "/dashboard", templateUrl: "/templates/index.html", controller: 'DashboardController'
    .when "/boards/:boardId", templateUrl: "/templates/board.html", controller: 'BoardsController'
    .when "/boards/:boardId/lists/:listId/cards/:cardId", templateUrl: "/templates/card.html", controller: 'CardController'
    .otherwise redirectTo: "/dashboard"
    