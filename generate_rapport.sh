#!/bin/bash
set -e

# Installer les dépendances
npm ci
npx playwright install --with-deps

# Lancer les tests Playwright
# Les reporters configurés dans playwright.config.ts génèrent déjà :
# - JUnit (playwright-report/results.xml)
# - Allure (allure-results/)
# - HTML (playwright-report/)
npx playwright test
