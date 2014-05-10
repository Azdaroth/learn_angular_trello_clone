angular.module('trelloClone').controller "BoardsController", ($scope, $routeParams, $timeout,
 $route, $q, Board, List) ->

  $scope.boardService = new Board()
  $scope.newList = {
    name: ""
  }

  $scope.createList = ->
    $scope.listService.create(name: $scope.newList.name).then (list) ->
      list.priority = 0
      $scope.lists.push(list)
      $scope.newList.name = ""
      $scope.incrementPriorities()

  
  $scope.init = ->
    $scope.$on '$routeChangeSuccess', (event, current, previous) ->
      $scope.board = $scope.boardService.find($routeParams.boardId)
      listService = new List($routeParams.boardId)
      $scope.listService = listService
      $scope.lists = listService.all()


  $scope.incrementPriorities = ->
    $timeout ->
      $scope.lists.forEach (list) ->
        list.priority += 1
        $scope.updateList(list.id, priority: list.priority)
  
  $scope.updateList = (id, params) ->
    $scope.listService.update(id, params)  

    