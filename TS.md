# Test Section

## 1. Overview

This section defines the testing strategy for the NMEA GNSS Adapter. The objective is to ensure the system meets functional requirements, validates NMEA data processing, and guarantees reliable communication across supported interfaces (Serial, TCP, UDP).

The testing approach is divided into:

- Unit Testing
- Automated Testing (BDD-based)
- Manual Testing

---

## 2. Test Strategy

| Test Type       | Scope |
|----------------|------|
| Unit Tests      | Validate internal logic and components |
| Automated Tests | Validate E2E behavior, regression, functional flows |
| Manual Tests    | Validate hardware interaction, logs, and real-world scenarios |

---

## 3. Unit Test Section

### 3.1 Objectives

- Validate core logic of NMEA parsing and processing.
- Ensure checksum validation correctness.
- Validate configuration handling through JSON files.
- Ensure proper transformation and formatting of output data.
- Validate GPS fix state interpretation.
- Validate stale message and timeout detection logic.

---

### 3.2 Unit Test Cases

#### UT-01: Validate NMEA Checksum
- Description: Verify checksum validation logic.
- Expected Result: Valid accepted, invalid rejected.

---

#### UT-02: Parse NMEA Sentences
- Description: Validate parsing of GGA and RMC.
- Expected Result: Correct extraction of GNSS data.

---

#### UT-03: JSON Configuration Parsing
- Description: Validate JSON config loading.
- Expected Result: Valid loads, invalid fails.

---

#### UT-04: Communication Mode Validation
- Description: Only one mode allowed.
- Expected Result: Multi-mode rejected.

---

#### UT-05: Data Formatting
- Description: Validate output transformation.
- Expected Result: Correct structure and values.

---

#### UT-06: Logging Trigger Logic
- Description: Validate log events.
- Expected Result: Correct logs generated.

---

#### UT-07: GPS Fix Status Interpretation
- Description: Validate GPS fix logic.
- Expected Result:
  - Valid fix detected
  - Invalid/no fix detected
  - Correct output state

---

#### UT-08: Stale Message Detection
- Description: Validate stale/timeout logic.
- Expected Result:
  - Messages flagged as stale after timeout
  - No-data condition detected
  - No false positives

## 4. Automated Test Section (BDD - Gherkin)

### Feature: Serial Communication

```gherkin
Feature: Serial Communication

  Scenario: Receive NMEA data via serial port
    Given the adapter is configured for serial communication
    And a valid NMEA stream is received
    When the adapter processes the data
    Then the system should parse and output valid GNSS data

  Scenario: Invalid checksum in serial data
    Given the adapter is configured for serial communication
    And an invalid NMEA sentence is received
    When the adapter processes the data
    Then the sentence should be rejected
```

---

### Feature: TCP Communication

```gherkin
Feature: TCP Communication

  Scenario: Receive NMEA data via TCP
    Given the adapter is configured for TCP
    And a TCP connection is established
    When NMEA data is received
    Then the adapter should process and output formatted data

  Scenario: TCP connection failure
    Given the adapter is configured for TCP
    When connection fails
    Then an error log should be generated
```

---

### Feature: UDP Communication

```gherkin
Feature: UDP Communication

  Scenario: Receive NMEA data via UDP
    Given the adapter is configured for UDP
    When UDP packets are received
    Then the adapter should process the data correctly
```

---

### Feature: Logging

```gherkin
Feature: Logging

  Scenario: Log connection events
    Given the adapter starts
    When a connection is established
    Then a log entry should be created

  Scenario: Log missing NMEA data
    Given the adapter is running
    When no NMEA data is received for a configured time
    Then a timeout log should be generated
```

---

### Feature: Data Output

```gherkin
Feature: Data Output

  Scenario: Output GNSS data
    Given valid NMEA input
    When data is processed
    Then latitude, longitude, altitude and timestamp should be available

  Scenario: Output speed and heading
    Given valid NMEA input
    When data is processed
    Then speed and heading should be available
```

---

## 5. Manual Test Section

### 5.1 Objectives

- Validate real-world interaction scenarios
- Verify logs and system behavior
- Validate integration with external systems (Second Agent)

---

### 5.2 Manual Test Cases

#### MT-01: Verify Serial Connection Setup

- Steps:
  1. Configure serial parameters
  2. Start adapter
- Expected Result: Connection established successfully

---

#### MT-02: Verify TCP Connection

- Steps:
  1. Configure TCP IP and port
  2. Start adapter
- Expected Result: Connection established and logged

---

#### MT-03: Verify UDP Data Reception

- Steps:
  1. Configure UDP port
  2. Send NMEA packets
- Expected Result: Data received and processed

---

#### MT-04: Validate Logs Content

- Steps:
  1. Execute scenarios
  2. Inspect logs
- Expected Result: Logs contain:
  - Timestamps
  - Connection details
  - NMEA strings

---

#### MT-05: Validate Timeout Behavior

- Steps:
  1. Stop sending NMEA data
  2. Wait configured timeout
- Expected Result: Timeout log generated

---

#### MT-06: Validate Integration with Second Agent

- Steps:
  1. Run both containers
  2. Send NMEA data
- Expected Result: Data forwarded correctly

---

#### MT-07: Validate Configuration Changes

- Steps:
  1. Modify JSON config
  2. Restart system
- Expected Result: New configuration applied correctly

---

## 6. Test Data

- Predefined NMEA log files
- JSON configuration files
- Simulated inputs via gpsfake

---

## 7. Test Environment

- Docker containers:
  - Container A: NMEA Simulator + Test Agent
  - Container B: Adapter + Second Agent
- Communication:
  - Serial (virtual)
  - TCP
  - UDP
- Shared volumes for logs and test data

---

## 8. Entry & Exit Criteria

### Entry Criteria

- Build available
- Configuration defined
- Test environment ready

### Exit Criteria

- All critical tests passed
- No blocking defects
- Logs validated

