---
description: Initial project setup and dependency installation
model: sonnet
allowed-tools: Bash(npm install), Bash(yarn install), Bash(pip install), Bash(cargo build), Bash(go mod tidy), Bash(mvn install), Read(*package.json), Read(*requirements.txt), Read(*Cargo.toml), Read(*go.mod), Read(*pom.xml), Read(*README.md)
---

Set up the project for development:

1. Detect project type by checking configuration files
2. Install dependencies using appropriate package manager:
   - npm/yarn for Node.js projects
   - pip for Python projects  
   - cargo for Rust projects
   - go mod for Go projects
   - maven/gradle for Java projects

3. Check for setup instructions in README.md
4. Install development dependencies if in dev mode
5. Run any post-install scripts or setup commands
6. Verify setup by checking for required tools/dependencies

Automatically determine setup mode based on context:
- Default to full setup including dev dependencies
- Infer production setup if deployment context is detected
- Install all necessary tools and dependencies for the detected project type