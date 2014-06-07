angular.module('trelloClone').controller('CardsController', function($scope, $routeParams, 
    $timeout, $route, $q, Card, $modal) {

  var self = this;

  this.newCard = {
    name: ""
  };

  this.sortableOptions = {
    connectWith: '.cards-list',
    placeholder: 'placeholder',
    update: function(event, ui) {      
      return self.setPriorities();
    },
    beforeStop: function(event, ui) {
      var cardId = ui.helper[0].getAttribute("data-card-id")
      if (!cardId) {
        return;
      }
      var newListId = ui.helper.parent()[0].getAttribute("data-list-id");
      var boardId = ui.helper.parent()[0].getAttribute("data-board-id");
      new Card(boardId, newListId).update(cardId, {list_id: newListId});
    }
  };

  this.initWithService = function(boardId, listId) {
    var cardService;
    cardService = new Card(boardId, listId);
    this.cardService = cardService;
    return this.cards = cardService.all();
  };

  this.showCard = function(card) {
    $modal.open({
      templateUrl: "/templates/card.html",
      controller: function($scope, card) {
        $scope.card = card;
      },
      resolve: {
        card: function() {
          return card;
        }
      }
    });
  }

  this.createCard = function() {
    return this.cardService.create({name: this.newCard.name}).then(function(card) {
      card.priority = 0;
      self.cards.push(card);
      self.incrementPriorities();
      return self.newCard.name = "";
    });
  };

  this.destroyCard = function(id) {
    return this.cardService.destroy(id).then(function() {
      self.cards = self.cards.filter(function(card) {
        return card.id !== id;
      });
      return self.setPriorities();
    });
  };

  this.setPriorities = function() {
    return $timeout(function() {
      return self.cards.forEach(function(card, idx) {
        return self.updatePriority(card, idx + 1);
      });
    });
  };

  this.updatePriority = function(card, value) {
    return self.updateCard(card.id, {priority: value}).then(function() {
      return card.priority = value;
    });
  };

  this.updateCard = function(id, params) {
    return this.cardService.update(id, params);
  };

  this.incrementPriorities = function() {
    return $timeout(function() {
      return self.cards.forEach(function(card) {
        card.priority += 1;
        return self.updatePriority(card, card.priority);
      });
    });
  };
});