angular.module('trelloClone').controller "DashboardController", ($scope) ->

  $scope.boards = []
  $scope.currentId = 0
    
  $scope.createBoard = ->
    $scope.currentId += 1
    $scope.boards.push({"name": $scope.boardName, "id": $scope.currentId})
    $scope.boardName = ""
    
  $scope.destroyBoard = (id) ->
    boardToBeDelayed = undefined
    $scope.boards.forEach (board) ->
      boardToBeDelayed = board if board.id is id
    $scope.boards.splice($scope.boards.indexOf(boardToBeDelayed), 1)





