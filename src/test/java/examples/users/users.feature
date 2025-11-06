@users @api
Feature: Users API Testing
  This feature tests the CRUD operations for the users endpoint
  API Endpoint: /users

  Background: Common test configuration and setup
    # Global configuration
    * def config = { timeout: 5000, baseUrl: #(baseUrl), expectedContentType: 'application/json' }
    * url config.baseUrl
    * path 'users'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header X-User-Agent = userAgent
    
    # Common schema definitions
    * def userSchema = read('classpath:schemas/user-schema.json')
    * def userArraySchema = '#[] userSchema'

    @getall @smoke @positive
  Scenario: Get all users and verify specific user details by ID
    # Test description: Retrieves all users, verifies the response format and then gets a specific user
    
    # Get all users
    When method get
    And status 200
    And match response == userArraySchema
    And assert response.length > 0

    # Get specific user by ID
    * def first = response[0]
    Given path 'users'
    And path first.id
    When method get
    Then status 200
    And match response == userSchema


  @create @smoke @positive
  Scenario Outline: Create a new user and verify the created resource
    # Test description: Creates a new user and verifies the user was created correctly
    
    # Setup test data
    * def testData = read('classpath:testdata/users.json')
    * print testData
    * def usuario = testData.newUser
    * def timestamp = java.lang.System.currentTimeMillis()
    * set usuario.email = 'test' + timestamp + '@example.com'
    * set usuario.name = '<name>'

    # Create new user
    Given request usuario
    When method post
    Then status 201
    And match response == userSchema
    And match response contains usuario
    
    Examples:
      | karate.jsonPath(read('payload.users.create.json'), "$[0].createUser") |

  @delete @regression @positive
  Scenario Outline: Delete a user and verify the deletion
    # Test description: Creates a user, deletes it, and verifies it was deleted
    
    # Create test user
    * def usuario = <userData>
    * def timestamp = java.lang.System.currentTimeMillis()
    * set usuario.email = 'delete' + timestamp + '@example.com'
    Given request usuario
    When method post
    Then status 201
    And match response contains { id: '#number' }
    * def id = response.id

    # Delete user
    Given path 'users'
    And path id
    When method delete
    Then status 200

    # Verify user no longer exists
    Given path 'users'
    And path id
    When method get
    Then status 404

    Examples:
      | userData |
      | read('classpath:testdata/users.json').newUser |