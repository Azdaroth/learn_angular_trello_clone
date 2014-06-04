angular.module('trelloClone').controller 'CardsController', ($scope, $routeParams, 
  $timeout, $route, $q, Card) ->

  $scope.newCard = {
    name: ""
  }

  $scope.sortableOptions = 
    update: (event, ui) ->
      $scope.setPriorities()

  $scope.initWithService = (boardId, listId) ->
    cardService = new Card(boardId, listId)
    $scope.cardService = cardService
    $scope.cards = cardService.all()

  $scope.createCard = ->
    $scope.cardService.create(name: $scope.newCard.name).then (card) ->
      card.priority = 0
      $scope.cards.push(card)
      incrementPriorities()
      $scope.newCard.name = ""

  $scope.setPriorities = ->
    $timeout ->
      $scope.cards.forEach (card, idx) ->
        $scope.updatePriority(card, idx + 1)

  $scope.updatePriority = (card, value) ->
    $scope.cardService.update(card.id, {priority: value}).then ->
      card.priority = value

  incrementPriorities = ->
    $timeout ->
      $scope.cards.forEach (card) ->
        card.priority += 1
        $scope.updatePriority(card, card.priority)



