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

## 📊 Test reports and CI publishing

### Local reports
- HTML: `target/karate-reports/karate-summary.html`
- JSON: `target/karate-reports/karate-summary-json.txt`
- Timeline: `target/karate-reports/karate-timeline.html`

### How CI publishes reports (what the workflow does)
The GitHub Actions workflow (`.github/workflows/karate-test.yml`) performs the following steps when it runs:

1. Runs on Pull Requests to `develop`/`main` and can be triggered manually (`workflow_dispatch`).
2. Runs the test suite with Maven: `mvn test` and generates Karate HTML reports under `target/karate-reports` (and timestamped `target/karate-reports_*`).
3. Prepares a `site/` folder containing:
    - `site/reports/` with the latest `karate-reports` files
    - `site/reports/run-<timestamp>/` folders for historical runs
    - `site/index.html` (a dashboard page) that links to the reports
4. Uploads the `site/` folder as a GitHub Pages artifact using `actions/upload-pages-artifact`.
5. Deploys the artifact to GitHub Pages via `actions/deploy-pages` (the workflow configures Pages to use the `gh-pages` branch and deploys the artifact).

This means the published site is served by GitHub Pages and contains both the latest and historical report runs.

### Published URL
- The site is exposed at: `https://raulruiz89.github.io/karatePrototype` (GitHub Pages). The workflow attempts to configure Pages to serve the deployed artifact. The first deployment may take a few minutes.

### Notes and permissions
- The workflow requires Pages write permissions and the ability to upload Pages artifacts. Ensure in your repository settings (Settings → Actions → General) that **Workflow permissions** allow **Read and write** and that `GITHUB_TOKEN` can be used by Actions.
- For PRs from forks, the `GITHUB_TOKEN` has limited permissions and Pages deployment may not run for security reasons.

### When the workflow runs
- On Pull Requests targeting `develop` and `main`.
- On manual trigger (Actions → Karate Tests → Run workflow).

If you prefer the reports to be placed inside the same branch (e.g. `main/docs/`), the workflow can be changed to commit the `docs/` folder back to the branch instead of using Pages artifacts — however that requires branch push permissions and may conflict with branch protection rules.

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