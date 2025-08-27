#!/bin/bash
npm ci
npx playwright install --with-deps
npx playwright test 
allure generate ./allure-results -o ./allure-report --clean
