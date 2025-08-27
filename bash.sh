#!/bin/bash

# Fichier de test ciblé
TEST_FILE="tests/panier.spec.ts"

# Tag ciblé
TAG="@menu"

# Lancement du test avec grep
npx playwright test "$TEST_FILE" --grep "$TAG"
