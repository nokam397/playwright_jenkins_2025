#!/bin/bash
npm ci
npx playwright install --with-deps
npx playwright test --reporter=line,allure-playwright
npx allure generate allure-results -c -o allure-report
