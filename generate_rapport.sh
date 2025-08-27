#!/bin/bash
set -e  # Arrête le script si une commande échoue

# Installer les dépendances
npm ci
npx playwright install --with-deps

# Lancer les tests Playwright
# Les reporters configurés dans playwright.config.ts génèrent déjà :
# - JUnit (playwright-report/results.xml)
# - Allure (allure-results/)
# - HTML Playwright (playwright-report/)
npx playwright test

