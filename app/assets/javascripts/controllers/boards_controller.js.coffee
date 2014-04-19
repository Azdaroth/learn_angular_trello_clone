angular.module('trelloClone').controller "BoardsController", ($scope, $routeParams, $route, Board) ->

  $scope.boardService = new Board()
  
  $scope.init = ->
    $scope.$on '$routeChangeSuccess', (event, current, previous) ->
      $scope.board = $scope.boardService.find($routeParams.boardId)
    
  
    

    


  