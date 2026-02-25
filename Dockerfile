# 1. Image de base (celle que tu as choisie)
FROM python:3.9-slim

# Evite les fichiers temporaires Python et les buffers de sortie
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 2. Installation des outils système (wget, unzip + curl/gnupg pour le driver)
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation de Google Chrome (Ta méthode)
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get update \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# 4. Installation de ChromeDriver (Le script auto-adaptatif)
# Cette commande récupère la version de Chrome installée et télécharge le bon driver
RUN CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}') \
    && CHROMEDRIVER_VERSION=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_$CHROME_VERSION") \
    && wget -q "https://storage.googleapis.com/chrome-for-testing-public/$CHROMEDRIVER_VERSION/linux64/chromedriver-linux64.zip" \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && rm chromedriver-linux64.zip

# 5. Installation de Robot Framework, Selenium et Pabot (Ta commande pip)
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary \
    robotframework-pabot

# Création du dossier de travail
WORKDIR /tests

# Par défaut, on affiche juste la version pour vérifier que ça marche
CMD ["pabot", "--help"]
