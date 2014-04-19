describe 'BoardsController', ->

  class Board
    constructor:  ->
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
      $httpBackend, Board) =>
        @Board = Board
        @rootScope = $rootScope
        @scope = @rootScope.$new()
        @controller = $controller 'BoardsController', $scope: @scope, Boards: Board

  describe "init", ->

    beforeEach ->
      @id = 1
      @board = { id: @id, name: "name" }
      spyOn(@Board.prototype, 'find').andReturn(@board)
      @scope.init()

    it "assigns boards with current ID", ->
      @rootScope.$broadcast('$routeChangeSuccess', {});
      expect(@scope.board).toEqual(@board)