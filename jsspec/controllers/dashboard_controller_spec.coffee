describe "DashboardController", ->

  class Board
    constructor:  ->
    all: -> []
    find: (id) -> id
    create: (params) -> params
    update: (id, params) -> params
    destroy: (id) ->


  beforeEach ->
    module("trelloClone")

  beforeEach ->
    inject ($rootScope, $controller, $injector, Board) =>
      @Board = Board
      @scope = $rootScope.$new()
      @controller = $controller "DashboardController", $scope: @scope, Board: Board
      @scope.init()

  it "has empty boards list", ->
    # expect(@scope.boards).toEqual([])

  describe "adding new board", ->

    beforeEach ->
      @scope.boardName = "name"
      spyOn(@Board.prototype, 'create')
      @scope.createBoard()

    it "creates new board", ->
      expect(@scope.boards.length).toEqual(1)

    it "clears board's name", ->
      expect(@scope.boardName).toEqual("")

    it "tells service to create new board", ->
      expect(@Board.prototype.create).toHaveBeenCalledWith({name: "name"})
      

  describe "deleting board", ->
      
    it "removes board", ->
      @scope.boards = [
        {name: "name", id: 1},
        {name: "name", id: 2},
        {name: "name", id: 3}
      ]
      @scope.destroyBoard(1)
      expect(@scope.boards.length).toEqual(2)
      expect(@scope.boards[0].id).toEqual(2)

    it "tells service to remove board", ->
      spyOn(@Board.prototype, 'destroy')
      id = 1
      @scope.destroyBoard(id)
      expect(@Board.prototype.destroy).toHaveBeenCalledWith(id)

  describe "updating board's name", ->

    it "calls service to update board", ->
      data = "data"
      id = 1
      board = { id: id }
      spyOn(@Board.prototype, 'update')
      @scope.updateBoardName(board, data)
      expect(@Board.prototype.update).toHaveBeenCalledWith(id, {name: "data"})



