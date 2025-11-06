function fn() {
  var utils = {};
  utils.getCurrentTimestamp = function() {
    return new Date().toISOString();
  };
  utils.generateRandomEmail = function() {
    var randomString = Math.random().toString(36).substring(7);
    return 'test.' + randomString + '@example.com';
  };
  return utils;
}