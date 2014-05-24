angular.module('trelloClone').controller "BoardsController", ($scope, $routeParams, $timeout,
 $route, $q, Board, List) ->

  $scope.boardService = new Board()
  $scope.newList = {
    name: ""
  }

  $scope.sortableOptions = 
    update: (event, ui) ->
      $scope.setPriorities()

  $scope.createList = ->
    $scope.listService.create(name: $scope.newList.name).then (list) ->
      list.priority = 0
      $scope.lists.push(list)
      $scope.newList.name = ""
      incrementPriorities()
      $scope.listForm.$setPristine()
  
  $scope.init = ->
    $scope.$on '$routeChangeSuccess', (event, current, previous) ->
      $scope.board = $scope.boardService.find($routeParams.boardId)
      listService = new List($routeParams.boardId)
      $scope.listService = listService
      $scope.lists = listService.all()


  $scope.setPriorities = ->
    $timeout ->
      $scope.lists.forEach (list, idx) ->
        setPriority(list, idx + 1)
    
  incrementPriorities = ->
    $timeout ->
      $scope.lists.forEach (list) ->
        list.priority += 1
        updateList(list.id, priority: list.priority)

  setPriority = (list, value) ->
    updateList(list.id, {priority: value}).then ->
      list.priority = value
  
  updateList = (id, params) ->
    $scope.listService.update(id, params)  

    