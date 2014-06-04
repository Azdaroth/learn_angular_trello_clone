angular.module('trelloClone').factory 'Card', ($resource, $http) ->

  class Card
  
    constructor: (boardId, listId) ->
      @request = $resource('/api/boards/:board_id/lists/:list_id/cards/:id',
        { board_id: boardId, list_id: listId, id: '@id' },
        { update: { method: "PATCH" } }
      )

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      new @request.query()

    find: (id) ->
      new @request.get(id: id)

    create: (params) ->
      new @request(card: params).$save()

    update: (id, params) ->
      new @request(card: params).$update(id: id)

    destroy: (id) ->
      new @request().$delete(id: id)