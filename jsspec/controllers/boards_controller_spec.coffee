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
    inject ($rootScope, $controller, $injector,
      $location, $route,$routeParams,
      $httpBackend, Board, List) =>
        @Board = Board
        @List = List
        @rootScope = $rootScope
        @scope = @rootScope.$new()
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

  describe "createList", ->

    beforeEach ->
      @id = 1
      @board = { id: @id, name: "name" }
      @list = { id: 2, name: "name", board_id: @id }
      spyOn(@Board.prototype, 'find').andReturn(@board)
      spyOn(@List.prototype, 'create').andReturn(@list)
      @scope.init()
      @rootScope.$broadcast('$routeChangeSuccess', {});
      @scope.newList.name = "name"
      @scope.createList()

    it "makes newList's name empty", ->
      expect(@scope.newList.name).toEqual("")

    it "adds list to  lists' list", ->
      expect(@scope.lists.length).toEqual(1)  

    it "calls service to create list", ->
      expect(@List.prototype.create).toHaveBeenCalledWith({name: "name"})




