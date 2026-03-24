*** Settings ***
Documentation     Resource file for The Internet Login Page
Library           SeleniumLibrary

*** Variables ***
${BROWSER}                     Chrome
${LOGIN_URL}                   https://the-internet.herokuapp.com/login
${SECURE_URL}                  https://the-internet.herokuapp.com/secure
${TITLE}                       The Internet

# datas
${VALID_USER}                  tomsmith
${VALID_PASSWORD}              SuperSecretPassword!
${INVALID_USER}                tomholland
${INVALID_PASSWORD}            Password!

# locators
${TXT_USERNAME}                id:username
${TXT_PASSWORD}                id:password
${BTN_LOGIN}                   css:button[type="submit"]
${BTN_LOGOUT}                  css:a[href="/logout"]
${FLASH}                       id:flash

# messages
${MSG_LOGIN_SUCCESS}           You logged into a secure area!
${MSG_LOGOUT_SUCCESS}          You logged out of the secure area!
${MSG_INVALID_PASSWORD}        Your password is invalid!
${MSG_INVALID_USERNAME}        Your username is invalid!


*** Keywords ***
#Open Browser To Login Page
    #Open Browser    ${LOGIN_URL}    ${BROWSER}
    #Maximize Browser Window
    #Title Should Be    ${TITLE}

Open Browser To Login Page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    @{args}=    Create List
    ...    --headless
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --window-size=1920,1080

    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome_options}    add_argument    ${arg}
    END

    Open Browser    ${LOGIN_URL}    chrome    options=${chrome_options}
    Title Should Be    ${TITLE}

Input Username
    [Arguments]    ${username}
    Input Text    ${TXT_USERNAME}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${TXT_PASSWORD}    ${password}

Click Login
    Click Button    ${BTN_LOGIN}

Click Logout
    Click Element      ${BTN_LOGOUT}

Login Success Should Be Shown
    Location Should Be    ${SECURE_URL}
    Element Should Contain    ${FLASH}    ${MSG_LOGIN_SUCCESS}

Logout Success Should Be Shown
    Location Should Be    ${LOGIN_URL}
    Element Should Contain    ${FLASH}    ${MSG_LOGOUT_SUCCESS}

Login Failed Should Be Shown
    [Arguments]    ${message}
    Location Should Be    ${LOGIN_URL}
    Element Should Contain    ${FLASH}    ${message}