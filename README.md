# API Testing Project with Karate Framework

[![Karate Tests](https://github.com/raulruiz89/karatePrototype/actions/workflows/karate-test.yml/badge.svg)](https://github.com/raulruiz89/karatePrototype/actions/workflows/karate-test.yml)

## Overview
This project demonstrates automated API testing using Karate Framework. It includes comprehensive test suites for various endpoints of a RESTful API, implementing CRUD operations and validation scenarios.

## 🛠 Tech Stack
- **Java:** Version 21
- **Karate Framework:** Version 1.5.0
- **JUnit 5:** For test execution
- **Maven:** For project management and test execution

## 📁 Project Structure
```
myproject/
├── src/
│   └── test/
│       └── java/
│           ├── examples/
│           │   ├── albums/
│           │   │   ├── albums.feature
│           │   │   └── AlbumsRunner.java
│           │   ├── comments/
│           │   │   ├── comments.feature
│           │   │   └── CommentsRunner.java
│           │   ├── posts/
│           │   │   ├── posts.feature
│           │   │   └── PostsRunner.java
│           │   ├── users/
│           │   │   ├── users.feature
│           │   │   └── UsersRunner.java
│           │   └── utilities.js
│           ├── schemas/
│           │   ├── album-schema.json
│           │   ├── comment-schema.json
│           │   ├── post-schema.json
│           │   └── user-schema.json
│           └── testdata/
│               ├── albums.json
│               ├── comments.json
│               ├── posts.json
│               └── users.json
└── pom.xml
```

## 🚀 Features
- CRUD operations testing for multiple endpoints:
  - Users
  - Posts
  - Comments
  - Albums
- Schema validation
- Data-driven testing
- Positive and negative test scenarios
- Response validation
- Performance validation (response time checks)

## 🏗 Prerequisites
- Java JDK 17+
- Maven 3.11.0 or higher
- Git

## ⚙️ Setup and Installation

1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd myproject
   ```

2. **Install dependencies**
   ```bash
   mvn clean install
   ```

## 🧪 Running Tests

### Run all tests
```bash
mvn test
```

### Run specific test suite
```bash
# Run Users tests
mvn test -Dtest=UsersRunner

# Run Posts tests
mvn test -Dtest=PostsRunner

# Run Comments tests
mvn test -Dtest=CommentsRunner

# Run Albums tests
mvn test -Dtest=AlbumsRunner
```

### Run tests with tags
```bash
mvn test -Dkarate.options="--tags @smoke"
```

Available tags:
- @smoke
- @regression
- @positive
- @negative
- @getall
- @create
- @update
- @delete

## 📊 Test Reports
After test execution, reports can be found in:

### Local Reports
- HTML reports: `target/karate-reports/karate-summary.html`
- JSON reports: `target/karate-reports/karate-summary-json.txt`
- Timeline view: `target/karate-reports/karate-timeline.html`

### GitHub Pages Reports
Los reportes de pruebas automáticas se publican en GitHub Pages después de cada ejecución exitosa en la rama main:
- 🌐 [Ver Reportes en GitHub Pages](https://raulruiz89.github.io/karatePrototype)

### GitHub Actions
Los tests se ejecutan automáticamente en los siguientes casos:
1. Al crear un Pull Request hacia las ramas `main` o `develop`
2. Al hacer push directo a las ramas `main` o `develop`
3. Manualmente desde la sección Actions de GitHub

## 📝 Test Structure

### Feature Files
Each API endpoint has its own feature file containing:
- Background configuration
- Schema validation
- Test data setup
- Multiple test scenarios
- Data-driven tests
- Error handling scenarios

### Schemas
JSON schemas are stored in the `schemas` directory and used for response validation.

### Test Data
Test data is maintained in JSON files in the `testdata` directory.

## 🔍 Test Categories

1. **Smoke Tests** (@smoke)
   - Basic CRUD operations
   - Essential functionality verification

2. **Regression Tests** (@regression)
   - Comprehensive test scenarios
   - Edge cases
   - Error handling

3. **Validation Tests**
   - Schema validation
   - Data format validation
   - Response structure verification

## 👥 Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## 📄 License
This project is licensed under the MIT License - see the LICENSE.md file for details

## 📮 Contact
For any queries or suggestions, please open an issue in the repository.

---
*This project uses Karate Framework for API testing. For more information about Karate, visit [their official documentation](https://github.com/karatelabs/karate).*