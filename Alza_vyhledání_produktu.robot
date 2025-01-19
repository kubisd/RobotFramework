*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://alza.cz
${Product}    Steam Deck
${Add_basket}    xpath=//span[contains(text(), 'Do košíku')]
${Homepage}    xpath=//a[@data-testid='headerLogo']
${Show_basket}    xpath=//a[@data-testid='headerBasketIcon']
${Available}    xpath=//span[@class="AlzaText availability-alz-50 availability-alz-59 availability-alz-22 availability-alz-61"]


*** Keywords ***
Setting up a browser
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains    Alza.cz
Closing a browser
    Close Browser



*** Test Cases ***
Nákup produktu
    [Setup]    Setting Up A Browser
    [Teardown]    Closing A Browser
    [Documentation]
    Click Element    css:[data-action-type-value="13"]
    Input Text    css:input[placeholder="Co hledáte? Např. kabel AlzaPower..."]    ${Product}
    Press Keys    css:input[placeholder="Co hledáte? Např. kabel AlzaPower..."]    ENTER
    Wait Until Page Contains    Vyhledáno: ${Product}
    Scroll Element Into View    id=img7742430
    Click Element    id=img7742430

    Wait Until Page Contains    Valve Steam Deck Console 256GB

    ${IS_PRESENT1}=    Run Keyword And Return Status    Element Should Contain    ${Available}    Skladem
    IF    ${IS_PRESENT1}
        Log    Produkt je skladem
        Click Element    ${Add_basket}
    ELSE
        Log    Produkt není skladem
        Go Back
    END
    
    Scroll Element Into View    id=img8070872
    Click Element    id=img8070872
    Wait Until Page Contains    Valve Steam Deck OLED Console 512GB

    ${IS_PRESENT2}=    Run Keyword And Return Status    Element Should Contain    ${Available}    Skladem
    IF    ${IS_PRESENT2}
        Log    Produkt je skladem
        Click Element    ${Add_basket}
        Click Element    xpath=//span[contains(text(), 'Pokračovat do košíku')]
        Click Element    ${Homepage}
        Mouse Over    ${Show_basket}
        ${IS_PRESENT3}=    Run Keyword And Return Status    Current Frame Should Contain    Herní konzole Valve Steam Deck OLED Console 512GB
        IF     '$IS_PRESENT3='
            Click Element    ${Show_basket}
            Click Element    xpath=//div[@class="countMinus"]
            Sleep    1s
            Click Element    xpath=//span[@class="btnx normal green ok" and text()="Odebrat zboží"]
            Sleep    1s
            Click Element    ${Homepage}
        ELSE
           Go Back
        END

    ELSE
        Log    Produkt není Skladem
        Go Back
    END
   Click Element    ${Show_basket}
   Wait Until Page Contains    Jsem tak prázdný...
   Log    Košík je prázdný
   Click Element    ${Homepage}





