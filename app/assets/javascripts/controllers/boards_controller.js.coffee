angular.module('trelloClone').controller "BoardsController", ($scope, $routeParams, $timeout,
 $route, $q, Board, List, _) ->

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

  $scope.destroyList = (id) ->    
    $scope.listService.destroy(id).then ->      
      $scope.lists = $scope.lists.filter (list) ->
        list.id isnt id      
      $scope.setPriorities()

  $scope.setPriorities = ->
    $timeout ->
      $scope.lists.forEach (list, idx) ->
        setPriority(list, idx + 1)
    
  incrementPriorities = ->
    $timeout ->
      $scope.lists.forEach (list) ->
        list.priority += 1
        $scope.updateList(list.id, priority: list.priority)

  setPriority = (list, value) ->
    $scope.updateList(list.id, {priority: value}).then ->
      list.priority = value
  
  $scope.updateList = (id, params) ->
    $scope.listService.update(id, params)  

    