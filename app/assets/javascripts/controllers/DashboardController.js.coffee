angular.module('trelloClone').controller "DashboardController", ($scope, $timeout, Board) ->

  $scope.boardService = new Board()

  $scope.sortableOptions = 
    update: (event, ui) ->
      $scope.setPriorities()
    
  $scope.init = ->
    $scope.boards = $scope.boardService.all()

  $scope.createBoard = ->
    name = $scope.boardName
    board = $scope.boardService.create(name: name)
    $scope.boards.push(board)
    board.priority = 0
    $scope.boardName = ""
    $scope.incrementPriorities()

  $scope.destroyBoard = (id) ->
    $scope.boardService.destroy(id)
    $scope.boards = $scope.boards.filter (board) ->
      board.id isnt id
    
  $scope.updateBoardName = (board, data) ->
    $scope._updateBoard(board.id, "name": data)

  $scope.setPriorities = ->
    $timeout ->
      $scope.boards.forEach (board, idx) ->
        $scope.setPriority(board, idx + 1)

  $scope.setPriority = (board, priority) ->
    $scope._updateBoard(board.id, priority: priority)
    board.priority = priority

  $scope.incrementPriorities = ->
    $timeout ->
      $scope.boards.forEach (board) ->
        board.priority += 1
        $scope._updateBoard(board.id, priority: board.priority)

  $scope._updateBoard = (id, params) ->
    $scope.boardService.update(id, params)    
