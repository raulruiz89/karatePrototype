@albums @api
Feature: Albums API Testing
  This feature tests the CRUD operations for the albums endpoint
  API Endpoint: /albums

  Background: Common test configuration and setup
    # Global configuration
    * def config = { timeout: 5000, baseUrl: #(baseUrl) }
    * url config.baseUrl
    * path 'albums'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    
    # Schemas and test data
    * def albumSchema = read('classpath:schemas/album-schema.json')
    * print albumSchema
    * def albumArraySchema = '#[] #(albumSchema)'
    * print albumArraySchema
    * def testDataFile = read('classpath:testdata/albums.json')
    * def utils = read('classpath:examples/utilities.js')()

  @getall @smoke @positive
  Scenario: Get all albums and validate response
    When method GET
    Then status 200
    And match response == albumArraySchema
    And assert response.length > 0
    And assert responseTime < config.timeout

  @getbyuser @smoke @positive
  Scenario Outline: Get albums for a specific user
    Given param userId = <userId>
    When method GET
    Then status 200
    And match each response == albumSchema
    And match each response[*].userId == <userId>

    Examples:
      | userId |
      | 1     |
      | 2     |

  @create @smoke @positive
  Scenario: Create a new album
    * def timestamp = utils.getCurrentTimestamp()
    * def newAlbum = testDataFile.testData[0].createAlbum
    * print 'newAlbum =>', newAlbum

    Given request newAlbum
    And header X-Timestamp = timestamp
    When method POST
    Then status 201
    And match response.userId == newAlbum.userId
    And match response.title == newAlbum.title
    And match response.id == '#number'
    And match response == albumSchema

  @update @regression @positive
  Scenario: Update an existing album
    * def updatedData = testDataFile.testData[0].updateAlbum
    * print updatedData
    
    Given path '1'
    And request updatedData
    When method PUT
    Then status 200
    And match response contains updatedData

  @delete @regression @positive
  Scenario: Delete an album
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

  @negative @validation
  Scenario Outline: Validate album data validation
    * def invalidData = <data>
    
    Given request invalidData
    When method POST
    Then status 201
    And match response contains { id: '#number' }

    Examples:
      | data |
      | { userId: 1, title: '' } |
      | { userId: 0, title: 'Invalid User' } |
      | { userId: null, title: 'No User' } |