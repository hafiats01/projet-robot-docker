*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Ouvrir Chrome Pour Docker
    [Documentation]    Configure et ouvre Chrome en mode Headless pour Docker
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    # --- Options Indispensables pour Docker ---
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    # ----------------------------------------------------------------------

    Create Webdriver    Chrome    options=${options}

*** Test Cases ***
Connexion Reussie a The-Internet
    [Documentation]    Test de connexion complet compatible Docker.   
    # 1. Ouverture du navigateur
    Ouvrir Chrome Pour Docker
    Go To    https://the-internet.herokuapp.com/login
    
    # 2. Remplissage du formulaire (avec les bons identifiants)
    Input Text      id=username    tomsmith
    Input Text      id=password    SuperSecretPassword!

    # Capture après la saisie des identifiants
    Capture Page Screenshot    capture_apres_click.png
    
    # 3. Validation
    Click Button    css:button[type="submit"]

    # Capture d'écran après le clic
    Capture Page Screenshot    capture_apres_click.png
    
    # 4. Vérification du succès (Assertion)
    # On cherche le message vert qui confirme la connexion
    Page Should Contain    You logged into a secure area!
    
    [Teardown]    Close Browser