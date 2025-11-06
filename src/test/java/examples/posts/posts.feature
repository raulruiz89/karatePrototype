@posts @api
Feature: Posts API Testing
  This feature tests the CRUD operations for the posts endpoint
  API Endpoint: /posts

  Background: Common test configuration and setup
    # Global configuration
    * def config = { timeout: 5000, baseUrl: #(baseUrl) }
    * url config.baseUrl
    * path 'posts'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    
    # Schemas and test data
    * def postSchema = read('classpath:schemas/post-schema.json')
    * def postArraySchema = '#[] postSchema'
    * def testData = read('classpath:testdata/posts.json')

  @getall @smoke @positive
  Scenario: Get all posts and validate response
    When method get
    Then status 200
    And match response == postArraySchema
    And assert response.length > 0
    And assert responseTime < config.timeout

  @getone @smoke @positive
  Scenario Outline: Get a specific post by ID
    Given path '<id>'
    When method get
    Then status 200
    And match response == postSchema

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |

  @create @smoke @positive
  Scenario: Create a new post and verify
    * def newPost = testData[0].createPost
    
    Given request newPost
    When method post
    Then status 201
    And match response contains newPost
    And match response.id == '#number'

  @update @regression @positive
  Scenario: Update an existing post
    * def updatedData = testData[0].updatePost
    
    Given path '1'
    And request updatedData
    When method put
    Then status 200
    And match response contains updatedData

  @delete @regression @positive
  Scenario: Delete a post
    Given path '1'
    When method delete
    Then status 200

  @negative
  Scenario Outline: Validate error handling for invalid requests
    * def errorData = <data>
    
    Given path <path>
    And request errorData
    When method <method>
    Then status <expectedStatus>

    Examples:
      | path    | method | data                    | expectedStatus |
      | '999999'| get  | null                    | 404           |
      | '999999'| delete| null                   | 200           |