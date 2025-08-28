#!/bin/bash
npm ci
npx playwright install --with-deps

# Exécution des tests avec Allure
npx playwright test --reporter=line,allure-playwright