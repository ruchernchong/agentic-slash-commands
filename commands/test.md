---
description: Smart test runner that detects and runs tests
model: sonnet
allowed-tools: Bash(npm test), Bash(npm run test), Bash(yarn test), Bash(pytest), Bash(cargo test), Bash(go test), Bash(mvn test), Bash(gradle test), Read(*package.json), Read(*Cargo.toml), Read(*go.mod), Read(*pom.xml)
---

Run tests with smart framework detection:

1. Check project files to detect test framework:
   - package.json for npm/yarn projects  
   - Cargo.toml for Rust projects
   - go.mod for Go projects
   - pom.xml/build.gradle for Java projects
   - pytest.ini or requirements.txt for Python

2. Run appropriate test command based on detection
3. Show clear pass/fail results with summary
4. If tests fail, highlight the failing tests

Run all tests by default. If user mentions specific test patterns or files in their request, focus on those areas.