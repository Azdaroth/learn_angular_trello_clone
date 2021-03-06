describe "DashboardController", ->

  class Board
    constructor:  ->
    all: -> []
    create: (params) -> params
    find: (id) -> id
    update: (id, params) -> params
    destroy: (id) ->


  beforeEach ->
    module("trelloClone")

  beforeEach ->
    inject ($rootScope, $q, $controller, $injector, $timeout, $httpBackend, Board) =>      
      @Board = Board
      @q = $q
      @scope = $rootScope.$new()
      @timeout = $injector.get('$timeout');
      @httpBackend = $httpBackend
      @controller = $controller "DashboardController", $scope: @scope,
        $timeout: @timeout, Board: @Board
      @scope.init()

  describe "adding new board", ->

    describe "board creation", ->

      beforeEach ->
        @deferred = @q.defer()
        @scope.boardName = "name"
        @newBoard = {name: "name", id: 10, priority: 1}
        @deferred.resolve(@newBoard)
        @httpBackend.whenGET("/api/boards").respond([])
        spyOn(@Board.prototype, 'create').andReturn(@deferred.promise)
        @scope.createBoard()
        @scope.$apply()

      it "creates new board", ->
        expect(@scope.boards.length).toEqual(1)

      it "clears board's name", ->
        expect(@scope.boardName).toEqual("")

      it "tells service to create new board", ->        
        expect(@Board.prototype.create).toHaveBeenCalledWith({name: "name"})


    describe "priorities", ->

      beforeEach ->
        @deferred = @q.defer()
        @oldBoard = {name: "old", id: 9, priority: 1}
        @newBoard = {name: "name", id: 10, priority: 1}
        @scope.boards = [@oldBoard]
        @scope.boardName = "name"
        @httpBackend.whenGET("/api/boards").respond([@orderBoard])
        @httpBackend.whenPATCH("/api/boards/9").respond()
        @httpBackend.whenPATCH("/api/boards/10").respond()
        @newBoard = {name: "name", id: 10, priority: 1}
        @deferred.resolve(@newBoard)
        spyOn(@Board.prototype, 'create').andReturn(@deferred.promise)
        spyOn(@Board.prototype, 'update')
        @scope.createBoard()
        @scope.$apply()
        @timeout.flush()

      it "sets priority 1 to new board", ->        
        expect(@scope.boards.length).toEqual(2)
        expect(@scope.boards[1]).toEqual(@newBoard)
        expect(@scope.boards[1].priority).toEqual(1)

      it "increment priorities of other boards", ->
        expect(@scope.boards[0]).toEqual(@oldBoard)
        expect(@scope.boards[0].priority).toEqual(2)

      it "calls service to update priorities", ->        
        expect(@Board.prototype.update.callCount).toEqual(2)
        expect(@Board.prototype.update).toHaveBeenCalledWith(9, { priority: 2 })
        expect(@Board.prototype.update).toHaveBeenCalledWith(10, { priority: 1 })

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

    it "resets priorities", ->
      @httpBackend.whenGET("/api/boards").respond([@orderBoard])
      spyOn(@Board.prototype, 'destroy')
      spyOn(@Board.prototype, 'update')
      @scope.boards = [
        {name: "name", id: 1, priority: 1},
        {name: "name", id: 2, priority: 2},
        {name: "name", id: 3, priority: 3}
      ]
      @scope.destroyBoard(1)
      @timeout.flush()
      expect(@scope.boards[0].priority).toEqual(1)
      expect(@scope.boards[1].priority).toEqual(2)


  describe "updating board's name", ->

    it "calls service to update board", ->
      data = "data"
      id = 1
      board = { id: id }
      spyOn(@Board.prototype, 'update')
      @scope.updateBoardName(board, data)
      expect(@Board.prototype.update).toHaveBeenCalledWith(id, {name: "data"})

  describe "ordering boards", ->

    beforeEach ->
      @orderBoardId = 2
      @orderBoard =  { id: @orderBoardId, priority: 9 }
      @scope.boards = [@orderBoard]
      @httpBackend.whenGET("/api/boards").respond([@orderBoard])
      spyOn(@Board.prototype, 'update')


    it "assigns priority based on index value", ->
      @scope.setPriorities()
      @timeout.flush()
      expect(@orderBoard.priority).toEqual(1)

    it "calls update on service to perform priority update", ->
      @scope.setPriorities()
      @timeout.flush()
      expect(@Board.prototype.update).toHaveBeenCalledWith(@orderBoardId, {priority: 1})

