---
description: Analyze project structure to detect package managers, build tools, and testing frameworks
allowed-tools: Read(*package.json), Read(*pnpm-lock.yaml), Read(*bun.lockb), Read(*yarn.lock), Read(*package-lock.json), Read(*tsconfig.json), Read(*.config.js), Bash(which pnpm), Bash(which bun), Bash(which yarn), Bash(which npm)
---

Analyze JavaScript/TypeScript project structure for use by /build, /test, /lint, and /setup commands:

1. **Package Manager Detection**:
   - Check for lock files in priority order:
     - pnpm-lock.yaml → pnpm
     - bun.lockb → bun
     - yarn.lock → yarn
     - package-lock.json → npm
   - Verify package manager is installed
   - Check package.json for packageManager field
   - Detect workspace/monorepo configuration

2. **Build Tool Detection**:
   - Read package.json scripts section
   - Identify build tools from dependencies:
     - Webpack, Vite, Rollup, Parcel, esbuild
     - Next.js, Nuxt, Create React App
     - TypeScript compiler (tsc)
   - Check for config files (webpack.config.js, vite.config.js, etc.)

3. **Testing Framework Detection**:
   - Identify test frameworks from dependencies:
     - Jest, Vitest, Mocha, Jasmine
     - Cypress, Playwright (E2E)
   - Check for test scripts in package.json
   - Detect test config files

4. **Linting/Formatting Detection**:
   - Check for ESLint configuration (.eslintrc*, eslint.config.js)
   - Check for Prettier configuration (.prettierrc*, prettier.config.js)
   - Identify from package.json dependencies
   - Check for lint scripts

5. **TypeScript Detection**:
   - Check for tsconfig.json
   - Check for TypeScript in dependencies/devDependencies
   - Identify TypeScript version

6. **Return Structure**:
   - packageManager: { name, version, command, lockFile }
   - buildTool: { name, command, configFile }
   - testFramework: { name, command, configFile }
   - linting: { eslint, prettier, commands }
   - typescript: { enabled, version, configFile }
   - workspaces: { enabled, tool, packages }

This skill provides project analysis for all build/test/lint/setup commands to use.
