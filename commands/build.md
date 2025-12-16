---
description: Smart build command that detects and runs project builds
model: sonnet
allowed-tools: Bash(npm run build), Bash(yarn build), Bash(cargo build), Bash(go build), Bash(mvn compile), Bash(gradle build), Bash(make), Read(*package.json), Read(*Cargo.toml), Read(*go.mod), Read(*pom.xml), Read(*Makefile)
---

Build the project with smart detection:

1. Detect build system by checking project files:
   - package.json for npm/yarn builds
   - Cargo.toml for Rust builds  
   - go.mod for Go builds
   - pom.xml/build.gradle for Java builds
   - Makefile for make builds

2. Run appropriate build command
3. Handle different environments (dev, prod, staging) if specified
4. Show build progress and handle any errors
5. Report build time and output location

Ask the user if they want to specify:
- Environment flag (prod, dev, staging)
- Specific build target
- Build options

If no specific preferences are given, use default build settings.