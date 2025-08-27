#!/bin/bash
npm ci
npx playwright install --with-deps
npx playwright test --reporter=html
set PLAYWRIGHT_JUNIT_OUTPUT_NAME=results.xml
npx playwright test --reporter=junit