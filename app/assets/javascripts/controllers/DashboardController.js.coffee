angular.module('trelloClone').controller "DashboardController", ($scope, Board) ->

  $scope.boardService = new Board()

  $scope.init = ->
    $scope.boards = $scope.boardService.all()
    $scope.currentId = 0  

  $scope.createBoard = ->
    $scope.currentId += 1
    name = $scope.boardName
    board = $scope.boardService.create(name: name)
    $scope.boards.push(board)
    $scope.boardName = ""

  $scope.destroyBoard = (id) ->
    $scope.boardService.destroy(id)
    $scope.boards = $scope.boards.filter (board) ->
      board.id isnt id
    
  $scope.updateBoardName = (board, data) ->
    $scope._updateBoard(board.id, "name": data)

  $scope._updateBoard = (id, params) ->
    $scope.boardService.update(id, params)    
