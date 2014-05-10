angular.module('trelloClone').factory 'List', ($resource, $http) ->

  class List

    constructor: (boardId) ->
      @request = $resource('/api/boards/:board_id/lists/:id',
        { board_id: boardId, id: '@id' },
        { update: { method: "PATCH" } }
      )

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: -> 
      new @request.query()

    find: (id) ->
      new @request.get(id: id)

    create: (params, successCallback) ->
      new @request(list: params).$save()

    update: (id, params) ->
      new @request(list: params).$update(id: id)

    destroy: (id) ->
      new @request().$delete(id: id)
