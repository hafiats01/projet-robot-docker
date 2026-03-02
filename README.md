# Projet Robot Framework avec Docker

Lien du projet : https://github.com/hafiats01/projet-robot-docker

## Description

Ce projet contient des tests automatisés avec **Robot Framework** et **SeleniumLibrary**, exécutés dans un conteneur **Docker** avec Chrome en mode headless.

## Structure

```
.
├── Dockerfile           # Image Docker avec Chrome + ChromeDriver + Robot Framework
├── docker-compose.yml   # Configuration pour lancer les tests avec Pabot
├── tests/               # Fichiers de tests Robot Framework
│   └── login_test.robot
└── results/             # Rapports générés après exécution
```

## Lancer les tests

```bash
docker compose up --build
```

Les rapports HTML seront disponibles dans le dossier `results/`.
