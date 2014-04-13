describe "DashboardController", ->

  beforeEach ->
    module("trelloClone")

  beforeEach ->
    inject ($rootScope, $controller, $injector) =>
      @scope = $rootScope.$new()
      @controller = $controller "DashboardController", $scope: @scope

  it "has empty boards list", ->
    expect(@scope.boards).toEqual([])

  describe "adding new task", ->

    beforeEach ->
      @scope.boardName = "name"
      @scope.createBoard()

    it "creates new task", ->
      expect(@scope.boards.length).toEqual(1)

    it "clears task's name", ->
      expect(@scope.boardName).toEqual("")


  describe "deleting task", ->
      
    it "removes task", ->
      @scope.boards = [
        {name: "name", id: 1},
        {name: "name", id: 2}
      ]
      @scope.destroyBoard(1)
      expect(@scope.boards.length).toEqual(1)
      expect(@scope.boards[0].id).toEqual(2)

  