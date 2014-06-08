angular.module('trelloClone').filter('cardFilter', function() {
  return function(cards, phrase) {

    var priority, name;
    var term = phrase.toString();

    return cards.filter(function(card) {
      priority  = card.priority.toString();
      name = card.name.toString();
      return (priority.indexOf(term) !== -1 || name.indexOf(term) !== -1);
    });

  };
});