*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://alza.cz
${Produkt}    Steam Deck

*** Keywords ***
Otevření prohlížeče
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains    Alza.cz
Zavření prohlížeče
    Close Browser

*** Test Cases ***
Nákup produktu
    [Setup]    Otevření prohlížeče
    [Teardown]    Zavření prohlížeče
    Click Element    css:[data-action-type-value="13"]
    Input Text    css:input[placeholder="Co hledáte? Např. kabel AlzaPower..."]    ${Produkt}
    Press Keys    css:input[placeholder="Co hledáte? Např. kabel AlzaPower..."]    ENTER
    Sleep    2s
    Scroll Element Into View    id=img7742430
    Click Element    id=img7742430

    Wait Until Page Contains    Valve Steam Deck Console 256GB

    ${IS_PRESENT}=    Run Keyword And Return Status    Element Should Contain    xpath=//span[@class="AlzaText availability-alz-50 availability-alz-59 availability-alz-22 availability-alz-61"]    Skladem
    IF    ${IS_PRESENT}
        Log    Produkt je skladem
        Click Element    xpath=//span[contains(text(), 'Do košíku')]
    ELSE
        Log    Produkt není skladem
        Go Back
    END
    
    Scroll Element Into View    id=img8070872
    Click Element    id=img8070872
    Wait Until Page Contains    Valve Steam Deck OLED Console 512GB

    ${IS_PRESENT}=    Run Keyword And Return Status    Element Should Contain    xpath=//span[@class="AlzaText availability-alz-50 availability-alz-59 availability-alz-22 availability-alz-61"]    Skladem
    IF    ${IS_PRESENT}
        Log    Produkt je skladem
        Click Element    xpath=//span[contains(text(), 'Do košíku')]
        Click Element    xpath=//span[contains(text(), 'Pokračovat do košíku')]
        Click Element    xpath=//a[@data-testid='headerLogo']
        Mouse Over    xpath=//a[@data-testid='headerBasketIcon']
        ${IS_PRESENT}=    Run Keyword And Return Status    Current Frame Should Contain    Herní konzole Valve Steam Deck OLED Console 512GB
        IF     '$IS_PRESENT='
            Click Element    xpath=//a[@data-testid='headerBasketIcon']
            Sleep    2s
            Click Element    xpath=//div[@class="countMinus"]
            Sleep    1s
            Click Element    xpath=//span[@class="btnx normal green ok" and text()="Odebrat zboží"]
            Sleep    2s
            Click Element    xpath=//a[@data-testid='headerLogo']
        ELSE
           Go Back
        END

    ELSE
        Log    Produkt není Skladem
        Go Back
    END
   Click Element    xpath=//a[@data-testid='headerBasketIcon']
   Wait Until Page Contains    Jsem tak prázdný...
   Log    Košík je prázdný





