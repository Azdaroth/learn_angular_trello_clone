angular.module('trelloClone').controller('CardsController', function($scope, $routeParams, 
    $timeout, $route, $q, Card) {

  var self = this;

  this.newCard = {
    name: ""
  };

  this.sortableOptions = {
    update: function(event, ui) {
      return self.setPriorities();
    }
  };

  this.initWithService = function(boardId, listId) {
    var cardService;
    cardService = new Card(boardId, listId);
    this.cardService = cardService;
    return this.cards = cardService.all();
  };

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