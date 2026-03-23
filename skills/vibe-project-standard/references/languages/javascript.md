# JavaScript/TypeScript Configuration

## Project Configuration

### package.json

```json
{
  "name": "{project_name}",
  "version": "0.1.0-alpha",
  "description": "{project_description}",
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "scripts": {
    "build": "tsc",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src tests --ext .ts,.tsx,.js,.jsx",
    "lint:fix": "eslint src tests --ext .ts,.tsx,.js,.jsx --fix",
    "format": "prettier --write \"src/**/*.{ts,tsx,js,jsx,json,md}\"",
    "format:check": "prettier --check \"src/**/*.{ts,tsx,js,jsx,json,md}\"",
    "typecheck": "tsc --noEmit",
    "prepare": "husky install",
    "pre-commit": "lint-staged"
  },
  "keywords": ["project", "template"],
  "author": "{author_name}",
  "license": "MIT",
  "engines": {
    "node": ">=18.0.0"
  },
  "devDependencies": {
    "@types/jest": "^29.5.0",
    "@types/node": "^20.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.45.0",
    "eslint-config-prettier": "^9.0.0",
    "husky": "^8.0.0",
    "jest": "^29.6.0",
    "jest-environment-jsdom": "^29.6.0",
    "lint-staged": "^14.0.0",
    "prettier": "^3.0.0",
    "ts-jest": "^29.1.0",
    "typescript": "^5.0.0"
  },
  "dependencies": {}
}
```

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts"]
}
```

### jest.config.js

```javascript
/** @type {import('jest').Config} */
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src', '<rootDir>/tests'],
  testMatch: [
    '**/__tests__/**/*.ts',
    '**/?(*.)+(spec|test).ts'
  ],
  transform: {
    '^.+\\.ts$': 'ts-jest'
  },
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
    '!src/**/__tests__/**'
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 85,
      statements: 85
    }
  },
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  clearMocks: true,
  verbose: true
};
```

### .eslintrc.js

```javascript
module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: 'module',
    project: './tsconfig.json'
  },
  plugins: ['@typescript-eslint'],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'prettier'
  ],
  rules: {
    '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    '@typescript-eslint/explicit-function-return-type': 'off',
    '@typescript-eslint/no-explicit-any': 'warn',
    'no-console': ['warn', { allow: ['warn', 'error'] }]
  },
  ignorePatterns: ['dist', 'node_modules', 'coverage']
};
```

### .prettierrc

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
```

### .prettierignore

```
dist/
node_modules/
coverage/
*.lock
package.json
```

## Package Structure

### src/index.ts

```typescript
/**
 * {Project Name} - {description}
 *
 * @module {project_name}
 * @version 0.1.0-alpha
 */

export { main } from './core/main';
export * from './core/types';
```

### src/core/main.ts

```typescript
/**
 * Main entry point for the application.
 */
export function main(): void {
  console.log('Hello from {project_name}!');
}
```

### src/core/types.ts

```typescript
/**
 * Core type definitions.
 */

export interface Config {
  name: string;
  version: string;
  environment: 'development' | 'production' | 'test';
}

export type Result<T, E = Error> = 
  | { ok: true; value: T }
  | { ok: false; error: E };
```

## Test Configuration

### tests/setup.ts

```typescript
/**
 * Jest setup file - runs before each test file.
 */

beforeAll(() => {
  // Global setup
});

afterAll(() => {
  // Global cleanup
});
```

### tests/unit/example.test.ts

```typescript
/**
 * Unit tests for example module.
 */

import { main } from '../../src/core/main';

describe('main', () => {
  it('should execute without errors', () => {
    expect(() => main()).not.toThrow();
  });
});
```

## CI Configuration

### .github/workflows/ci.yml (JavaScript)

```yaml
name: JavaScript CI

on:
  push:
    branches: [ main, develop, feature/** ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    name: Node.js ${{ matrix.node-version }} Test
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 21, 22]

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test -- --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v4

  lint:
    name: Lint
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: ESLint
        run: npm run lint

      - name: Prettier check
        run: npm run format:check

      - name: TypeScript check
        run: npm run typecheck
```

## Common Patterns

### Project Initialization

```bash
# Create project structure
mkdir -p src/{core,utils,plugins}
mkdir -p tests/{unit,integration,fixtures}
mkdir -p docs
mkdir -p examples

# Initialize npm
npm init -y

# Install dependencies
npm install typescript jest ts-jest @types/jest --save-dev
npm install eslint prettier --save-dev
npm install husky lint-staged --save-dev

# Initialize TypeScript
npx tsc --init

# Initialize ESLint
npx eslint --init

# Setup Husky
npx husky install
```

### Git Hooks

### .husky/pre-commit

```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run pre-commit
```

### lint-staged.config.js

```javascript
module.exports = {
  '*.{ts,tsx,js,jsx}': ['eslint --fix', 'prettier --write'],
  '*.{json,md}': ['prettier --write']
};
```

## Testing Guidelines

### Unit Test Example

```typescript
import { calculateTotal } from '../../src/core/calculator';

describe('Calculator', () => {
  describe('calculateTotal', () => {
    it('should calculate total for valid items', () => {
      const items = [{ price: 10 }, { price: 20 }];
      expect(calculateTotal(items)).toBe(30);
    });

    it('should handle empty array', () => {
      expect(calculateTotal([])).toBe(0);
    });
  });
});
```

### Mock Example

```typescript
import { fetchData } from '../../src/utils/api';
import axios from 'axios';

jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

describe('API', () => {
  it('should fetch data successfully', async () => {
    mockedAxios.get.mockResolvedValue({ data: { id: 1 } });
    const result = await fetchData('/api/test');
    expect(result).toEqual({ id: 1 });
  });
});
```
