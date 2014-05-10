angular.module('trelloClone').factory 'Board', ($resource, $http) ->

  class Board

    constructor: ->
      @request = $resource("/api/boards/:id",
        { id: '@id' },
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
      new @request(board: params).$save()

    update: (id, params) ->
      new @request(board: params).$update(id: id)

    destroy: (id) ->
      new @request().$delete(id: id)
