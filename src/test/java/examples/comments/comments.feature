@comments @api
Feature: Comments API Testing
  This feature tests the CRUD operations for the comments endpoint
  API Endpoint: /comments

  Background: Common test configuration and setup
    # Global configuration
    * def config = { timeout: 5000, baseUrl: #(baseUrl) }
    * url config.baseUrl
    * path 'comments'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def token = call read('classpath:examples/Reusable.feature')
    * header Authorization = 'Bearer ' + token.response.title
    
    # Schemas and test data
    * def commentSchema = read('classpath:schemas/comment-schema.json')
    * print commentSchema
    * def commentArraySchema = '#[] #(commentSchema)'
    * print commentArraySchema
    * def testData = read('classpath:testdata/comments.json')
    * def utils = read('classpath:examples/utilities.js')()

  @getall @smoke @positive
  Scenario: Get all comments and validate response
    When method GET
    Then status 200
    And match response == commentArraySchema
    And assert response.length > 0
    And assert responseTime < config.timeout

  @getbypost @smoke @positive
  Scenario Outline: Get comments for a specific post
    Given param postId = <postId>
    When method GET
    Then status 200
    And match each response == commentSchema

    Examples:
      | postId |
      | 1      |
      | 2      |

  @create @smoke @positive
  Scenario: Create a new comment
    * def timestamp = utils.getCurrentTimestamp()
    * def newComment = testData[0].createComment
    * print newComment
    * set newComment.email = utils.generateRandomEmail()

    Given request newComment
    And header X-Timestamp = timestamp
    When method POST
    Then status 201
    And match response contains newComment
    And match response.id == '#number'
    And match response.email == newComment.email
    And match response == commentSchema

  @update @regression @positive
  Scenario: Update an existing comment
    * def updatedData = testData[0].updateComment
    * print updatedData
    * set updatedData.email = utils.generateRandomEmail()
    
    Given path '1'
    And request updatedData
    When method PUT
    Then status 200
    And match response contains updatedData

  @delete @regression @positive
  Scenario: Delete a comment
    Given path '1'
    When method DELETE
    Then status 200

  @negative
  Scenario Outline: Validate error handling for invalid requests
    * def errorData = <data>
    
    Given path <path>
    And request errorData
    When method <method>
    Then status <expectedStatus>
    And match response == {}

    Examples:
      | path      | method | data | expectedStatus |
      | '999999'  | GET    | null | 404           |
      | '999999'  | DELETE | null | 200           |

  @negative @email
  Scenario Outline: Validate email format in requests
    * def invalidData = { postId: 1, name: 'Test', email: <email>, body: 'Test content' }
    
    Given request invalidData
    When method POST
    Then status 201
    And match response contains { id: '#number' }
    And match response.email == <email>

    Examples:
      | email          |
      | 'invalid'      |
      | 'not-an-email' |
      | ''            |
      | null          |