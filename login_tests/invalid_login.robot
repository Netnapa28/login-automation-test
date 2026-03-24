*** Settings ***
Resource          resource.robot
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup    Go To   ${LOGIN_URL}

*** Test Cases ***
Login failed - Password incorrect
    Input Username    ${VALID_USER}
    Input Password    ${INVALID_PASSWORD}
    Click Login
    Login Failed Should Be Shown    ${MSG_INVALID_PASSWORD} 

Login failed - Username not found
    Input Username    ${INVALID_USER}
    Input Password    ${INVALID_PASSWORD}
    Click Login
    Login Failed Should Be Shown    ${MSG_INVALID_USERNAME}