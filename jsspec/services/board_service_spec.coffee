describe "Board", ->
  
  beforeEach ->
    module("trelloClone") 

  beforeEach ->
    inject ($injector, Board) =>
      @boardService = new Board()
      @id = 1
      @newId = 2
      @baseURL = "/api/boards"
      @boardURL = @baseURL + "/" + @id
      @board = {name: "board", id: @id}
      @boards = [@board]
      @httpBackend = $injector.get('$httpBackend')
      @httpBackend.whenGET(@baseURL).respond(@boards)
      @httpBackend.whenGET(@boardURL).respond(@board)
      @httpBackend.whenPATCH(@boardURL).respond({})
      @httpBackend.whenPOST(@baseURL).respond({id: @newId, name: "name"})
      @httpBackend.whenDELETE(@boardURL).respond({})


  describe "all", ->

    it "returns all boards", -> 
      result = @boardService.all()
      @httpBackend.flush();      
      expect(result.length).toEqual(1)
      expect(result[0].name).toEqual(@board.name)

  describe "find", ->

    it "finds board with specified id", ->
      result = @boardService.find(@id)
      @httpBackend.flush();
      expect(result.name).toEqual(@board.name)
      

  describe "create", ->

    beforeEach ->
      @postParams = {name: "name"}

    it "creates board request", ->
      @httpBackend.expectPOST(@baseURL, board: @postParams)
      @boardService.create(@postParams)
      @httpBackend.flush()

    it "returns params with id of assigned board", ->
      result = @boardService.create(@postParams)
      @httpBackend.flush()
      expect(result.id).toEqual(@newId)
      
  describe "update", ->

    beforeEach ->
      @updateParams = {name: "name"}

    it "updates board with specified id", ->
      @httpBackend.expectPATCH(@boardURL, board: @updateParams)
      @boardService.update(@id, @updateParams)
      @httpBackend.flush()

  describe "destroy", ->

    it "destroys board", ->
      @httpBackend.expectDELETE(@boardURL)
      @boardService.destroy(@id)
      @httpBackend.flush()      

