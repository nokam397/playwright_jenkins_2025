#!/bin/bash
npm ci
npx playwright install --with-deps
npx playwright test --reporter=line,allure-playwright
npx allure-commandline generate allure-results -c -o allure-report
