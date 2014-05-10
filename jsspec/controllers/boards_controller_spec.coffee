describe 'BoardsController', ->

  class Board
    constructor:  ->
    all: -> []
    find: (id) -> id
    create: (params) -> params
    update: (id, params) -> params
    destroy: (id) ->

  class List
    constructor: (boardId) ->
    all: -> []
    find: (id) -> id
    create: (params) -> params
    update: (id, params) -> params
    destroy: (id) ->

  beforeEach ->
    module('trelloClone')

  beforeEach ->
    inject ($rootScope, $q, $controller, $injector,
      $location, $route,$routeParams, $timeout,
      $httpBackend, Board, List) =>
        @q = $q
        @Board = Board
        @List = List
        @rootScope = $rootScope
        @httpBackend = $httpBackend
        @scope = @rootScope.$new()
        @timeout = $injector.get('$timeout');
        @controller = $controller 'BoardsController', $scope: @scope,
          Board: Board, List: List

  describe "init", ->

    beforeEach ->
      @id = 1
      @board = { id: @id, name: "name" }
      spyOn(@Board.prototype, 'find').andReturn(@board)
      @scope.init()
      @rootScope.$broadcast('$routeChangeSuccess', {});

    it "assigns boards with current ID", ->
      expect(@scope.board).toEqual(@board)

    it "assign listService", ->
      expect(@scope.listService).not.toEqual(undefined)

  describe "adding new list", ->

    beforeEach ->
      @deferred = @q.defer()
      @id = 1
      @board = { id: @id, name: "name" }
      @oldList =  { id: 2, "oldName", priority: 1 }
      @lists = [@oldList]
      @list = { id: 3, name: "newName", board_id: @id }
      @deferred.resolve(@list)
      spyOn(@Board.prototype, 'find').andReturn(@board)
      spyOn(@List.prototype, 'all').andReturn(@lists)
      spyOn(@List.prototype, 'create').andReturn(@deferred.promise)
      spyOn(@List.prototype, 'update')
      @httpBackend.whenGET("/templates/index.html").respond()
      @httpBackend.whenPATCH("/api/boards/1/lists/2").respond()
      @httpBackend.whenPATCH("/api/boards/1/lists/3").respond()
      @scope.init()
      @rootScope.$broadcast('$routeChangeSuccess', {});
      @scope.newList.name = "name"
      @scope.createList()
      @scope.$digest()
      @timeout.flush()

    describe "creation", ->

      it "makes newList's name empty", ->
        expect(@scope.newList.name).toEqual("")

      it "adds list to  lists' list", ->
        expect(@scope.lists.length).toEqual(2)  

      it "calls service to create list", ->
        expect(@List.prototype.create).toHaveBeenCalledWith({name: "name"})

    describe "priorities", ->        

      it "sets priority 1 to new list", ->
        newList = @scope.lists[1]
        expect(newList).toEqual(@list)
        expect(newList.priority).toEqual(1)

      it "resets priorities for other lists", ->
        old = @scope.lists[0]
        expect(old).toEqual(@oldList)
        expect(old.priority).toEqual(2)

      it "tells service to update priorities on server", ->
        expect(@List.prototype.update.callCount).toEqual(2)
        expect(@List.prototype.update).toHaveBeenCalledWith(3, { priority: 1 })
        expect(@List.prototype.update).toHaveBeenCalledWith(2, { priority: 2 })
