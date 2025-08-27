#!/bin/bash
npm ci
npx playwright install --with-deps
npx playwright test 
npx allure generate ./allure-results --clean -o ./allure-report