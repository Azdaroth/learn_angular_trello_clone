describe "List", ->
  
  beforeEach ->
    module("trelloClone")

  beforeEach ->
    inject ($injector, List) =>
      @boardId = 1
      @listService = new List(@boardId)
      @id = 2
      @newId = 3
      @list = {name: "board", id: @id, board_id: @listId}
      @lists = [@list]
      @baseURL = "/api/boards/" + @boardId + "/lists"
      @listURL = @baseURL + "/" + @id
      @httpBackend = $injector.get('$httpBackend')
      @httpBackend.whenGET(@baseURL).respond(@lists)
      @httpBackend.whenGET(@listURL).respond(@list)
      @httpBackend.whenPOST(@baseURL).respond({
        id: @newId, name: "name", board_id: @board_id
      })
      @httpBackend.whenPATCH(@listURL).respond({})
      @httpBackend.whenDELETE(@listURL).respond({})


  describe "all", ->

    it "returns all lists", ->
      result = @listService.all()
      @httpBackend.flush()
      expect(result.length).toEqual(1)
      expect(result[0].name).toEqual(@list.name)

  describe "find", ->

    it "finds list with specified id", ->
      result = @listService.find(@id)
      @httpBackend.flush()
      expect(result.name).toEqual(@list.name)
  
  describe "create", ->

    beforeEach ->
      @postParams = { name: "name" }

    it "creates list request", ->
      @httpBackend.expectPOST(@baseURL, list: @postParams)
      @listService.create(@postParams)
      @httpBackend.flush()

    it "returns params with id of assgined list", ->
      result = @listService.create(@postParams)
      @httpBackend.flush()
      expect(result.id).toEqual(@newId)

  describe "update", ->

    beforeEach ->
      @updateParams = { name: "name" }

    it "updates list with specified id", ->
      @httpBackend.expectPATCH(@listUrl, list: @updateParams)
      @listService.update(@id, @updateParams)
      @httpBackend.flush()



  describe "destroy", ->

    it "destroys board", ->
      @httpBackend.expectDELETE(@listURL)
      @listService.destroy(@id)
      @httpBackend.flush()      

