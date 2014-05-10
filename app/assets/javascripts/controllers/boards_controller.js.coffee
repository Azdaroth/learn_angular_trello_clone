angular.module('trelloClone').controller "BoardsController", ($scope, $routeParams
 $route, Board, List) ->

  $scope.boardService = new Board()
  $scope.newList = {
    name: ""
  }

  $scope.createList = ->
    list = $scope.listService.create(name: $scope.newList.name)
    $scope.lists.push(list)
    $scope.newList.name = ""
    

  
  $scope.init = ->
    $scope.$on '$routeChangeSuccess', (event, current, previous) ->
      $scope.board = $scope.boardService.find($routeParams.boardId)
      listService = new List($routeParams.boardId)
      $scope.listService = listService
      $scope.lists = listService.all()
    
  
    

    


  