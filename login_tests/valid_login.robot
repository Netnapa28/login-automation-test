*** Settings ***
Resource          resource.robot
Test Teardown     Close Browser

*** Test Cases ***
Login success
    Open Browser To Login Page
    Input Username    ${VALID_USER}
    Input Password    ${VALID_PASSWORD}
    Click Login
    Login Success Should Be Shown
    Click Logout
    Logout Success Should Be Shown