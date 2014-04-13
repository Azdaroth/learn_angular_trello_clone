angular.module('trelloClone').controller "DashboardCtrl", ($scope) ->

  $scope.init = ->

  $scope.boards = [
    {"name": "name"},
    {"name": "dmsdfd"},
    {"name": "dmsdfddfdfdf"}
  ]

  $scope.createBoard = ->
    $scope.boards.push({"name": $scope.boardName })
    $scope.boardName = ""
    




  