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
      $httpBackend, Board, List, _) =>
        @_ = _
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
      @listForm = {
        $setPristine: ->
      }
      @scope.listForm = @listForm
      @httpBackend.whenGET("/templates/index.html").respond()
      @httpBackend.whenPATCH("/api/boards/1/lists/2").respond()
      @httpBackend.whenPATCH("/api/boards/1/lists/3").respond()
      @scope.init()
      @rootScope.$broadcast('$routeChangeSuccess', {});
      @scope.newList.name = "name"      
      spyOn(@listForm, "$setPristine")
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

      it 'set form to be pristine', ->
        expect(@listForm.$setPristine).toHaveBeenCalled()

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

  describe "setPriorities", ->

    beforeEach ->
      @deferred = @q.defer()
      @board = { id: 10, name: "name" }
      @list = { id: 1, name: "name", priority: 0 }
      @lists = [@list]
      @httpBackend.whenGET("/templates/index.html").respond()
      spyOn(@Board.prototype, 'find').andReturn(@board)
      spyOn(@List.prototype, 'all').andReturn(@lists)
      @deferred.resolve(@list)
      @scope.init()
      @rootScope.$broadcast('$routeChangeSuccess', {});
      spyOn(@List.prototype, "update").andReturn(@deferred.promise)
      @scope.setPriorities()
      @timeout.flush()

    it "sets value of priority based on index", ->
      expect(@list.priority).toEqual(1)

    it "calls service to update list with priority based on index", ->
      expect(@List.prototype.update).toHaveBeenCalledWith(1, { priority: 1 })

  describe "destroyList", ->

    beforeEach -> 
      @deferred = @q.defer()
      @deferredUpdate = @q.defer()
      @board = { id: 10, name: "name" }
      @list = { id: 1, name: "name", priority: 0 }
      @otherList = { id: 2, name: "name", priority: 10 }
      @lists = [@list, @otherList]
      spyOn(@Board.prototype, 'find').andReturn(@board)
      spyOn(@List.prototype, 'all').andReturn(@lists)
      @httpBackend.whenGET("/templates/index.html").respond()
      @deferred.resolve()
      @deferredUpdate.resolve(@otherList)
      spyOn(@List.prototype, 'destroy').andReturn(@deferred.promise)
      spyOn(@List.prototype, 'update').andReturn(@deferredUpdate.promise)
      @scope.init()
      @rootScope.$broadcast('$routeChangeSuccess', {});
      @scope.destroyList(@list.id)
      @scope.$digest()


    it "calls service to destroy list", ->
      expect(@List.prototype.destroy).toHaveBeenCalledWith(@list.id)

    it "removes list from lists array", ->
      expect(@scope.lists.length).toEqual(1)

    it "sets priority for other lists", ->
      @timeout.flush()
      expect(@List.prototype.update).toHaveBeenCalledWith(2, { priority: 1 })
