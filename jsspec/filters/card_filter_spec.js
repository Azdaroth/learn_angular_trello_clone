describe('cardFilter', function() {

  var filter;

  beforeEach(function() {
    module('trelloClone');
  });

  beforeEach(inject(function($filter) {
    filter = $filter('cardFilter');
  }));

  var card1 = { priority: 1, name: "name" };
  var card2 = { priority: 2, name: "stuff" };

  var cards = [card1, card2]

  it("returns results matched by priorities", function() {
    var result = filter(cards, 1);
    expect(result).toEqual([card1]);
  });

  it("returns results matched by name", function() {
     var result = filter(cards, "tuf"); 
     expect(result).toEqual([card2]);
  });

});