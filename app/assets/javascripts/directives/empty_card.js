angular.module('trelloClone').directive('emptycard', function() {
  return {
    restrict: 'E',
    replace: true,
    template: "<p>No cards</p>"
  }
});