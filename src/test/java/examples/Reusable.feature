@ignore
Feature: get authentication token
  This feature gets authentication token for further API calls
  API Endpoint: /auth/token

Scenario:
#Getting a token
Given url baseUrl
And path 'posts',6
And header Content-Type = 'application/json'
When method GET
Then status 200