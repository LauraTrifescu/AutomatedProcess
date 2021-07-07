***Settings***

Library     OperatingSystem
Library     SeleniumLibrary 
Library     String
Library     firstSheet.py
Library     secondSheet.py
Library     lastSheet.py
Library     Process
Library     InputValue39.py
Library     InputValue44.py
Library     InputValue49.py
Library     InputValue360.py
Library     Collections
Library     indici.py
Library     inspect.py

***Variables***

${DobandaING}       //*[@id="v_intrest"]
${DAE}              //*[@id="v_dae"]
${RataLunara}       //*[@id="v_rata_luna_fa"]
${RataLunara_PC}    //*[@id="v_rata_luna"]
${Ramburs}          //*[@id="v_total_amount"]
${Ramburs_PC}       //*[@id="v_total_amount_scadentar"]
${Accept}           //*[@id="onetrust-accept-btn-handler"]
${InputValoare}     //input[@id="front_valoare_proprietate"]
${Calculeaza}       //*[@id="fa-un-calcul"]
${ClearInput}       //*[@class="clearfix spgCell"]

${File}=            C:\\Users\\laura\\OneDrive\\Desktop\\ROBOT
${EuroPath}         //div[@class="currency-value"]//*[contains(text(),'1 EURO')][1] 

${AcceptRaiff}      //*[@id="cookiesAccept"]
${ProductRaiff}     //*[@id="product"]
${InputAmount}      //*[@data-tool-element-id="requestedAmmount"]
${DobandaRaiff}     //*[@id="prefferedInterestRate"]
${DAERaiff}         //*[@id="prefferedDAE"]
${RataLunaraRaiff}  //*[@id="prefferedMonthlyRate"]
${TotalRaiff}       //*[@id="prefferedTotal"]

${ROBORPath}        //*[@id="contentDiv"]//tbody//tr[1]//td[9]
@{list}

***Test Cases*** 

Extract ROBOR From BNR
    Open Browser    https://www.bnr.ro/ROBID-ROBOR-5672.aspx  Chrome
    ${ROBOR}=       Get Text    ${ROBORPath}  
    ${ROBOR}=       Convert to number  ${ROBOR}
    Set Global Variable     ${ROBOR}      ${ROBOR}
    Sleep           3s
    Close Browser

Extract IRCC from BNR
    Open Browser    https://www.bnr.ro/Indicele-de-referin%C8%9Ba-pentru-creditele-consumatorilor--19492.aspx    Chrome
    ${IRCC}=        Get Text    //*[@id="10days"]//tbody//tr[2]//td[2]
    ${IRCC}=        Replace String  ${IRCC}    ,     . 
    ${IRCC}=        Convert to number   ${IRCC}
    Set Global Variable       ${IRCC}      ${IRCC}
    Sleep           3s
    Close Browser

Extract IMO from Imobiliare
    Open Browser    https://www.imobiliare.ro/indicele-imobiliare-ro/bucuresti    Chrome
    # Click element   //*[@class="row butoane-actiune vizibil-informare"]//*[@class="btn-actiune btn-actiune--principal"]
    ${IMO}=         Get Text    //div[@class="col-lg-9 col-md-8 col-sm-8 col-xs-12"]//span[@class="pret_unitar"]
    ${IMO}=         Fetch From Left     ${IMO}   €/mp
    ${IMO}=         Convert to number   ${IMO}
    Set Global Variable       ${IMO}      ${IMO}
    Close Browser

Add Values
    Add values for indicators   ${File}\\IndiciFinanciari.xlsx    ${ROBOR}   ${IRCC}      ${IMO}
    Close Browser

ING Extract Data for Ipotecar
    
    Open Browser          https://ing.ro/persoane-fizice/credite/ipotecar     Chrome
    Maximize Browser Window
    Sleep  3s
    Click Element         ${Accept}
    Sleep   1s
    Click Element         ${InputValoare}
    Enter Value For First
    Click Element         ${Calculeaza}
    ING Enter Value for Ipotecar
    Sleep   3s
    Close Browser

ING Extract Data for Noua Casa
    Open Browser    https://ing.ro/lp/noua-casa     Chrome
    Maximize Browser Window
    Sleep  3s
    Click Element   ${Accept}
    Sleep   1s
    Click Element   ${InputValoare}
    Enter Value For First
    Sleep   1s
    Click element   ${ClearInput}
    ING Enter Value for Prima Casa
    Sleep   3s
    Close Browser

Raiffeisen First
    
    Open Browser    https://www.raiffeisen.ro/persoane-fizice/instrumente-utile/calculator-rata-credite/     Chrome
    Maximize Browser Window
    Sleep  3s
    # Click Element   ${AcceptRaiff}
    # Sleep   1s
    Click Element   //*[@id="product"]//*[@label="Imobiliar Casa Ta"]
    Sleep   1s
    Click Element   ${InputAmount} 
    Enter Value for First
    Raiffeisen Enter Value for Ipotecar
    Sleep   3s

    Click Element   //*[@id="product"]//*[@label="Imobiliar Prima Casa"]
    Sleep   1s
    Click Element   ${InputAmount} 
    Enter Value for First
    Sleep   1s
    Raiffeisen Enter Value for Prima Casa
    Sleep   3s
    Close Browser

BRD First

    Open Browser   https://www.brd.ro/calculatoare/calculatoare-de-credit/calculator-de-credit?filter=imobiliare     Chrome
    Maximize Browser Window
    Sleep  3s
    Click Element   //*[@class="cookie-consent-btn-action-preview cookie-consent-block"]   
    Click Element    //*[@id="type_credit_alias"]//*[@value="lacasamea15"]
    Press inspect
    Sleep   3s
    Click Element   //*[@name="valoare_credit"]
    Clear Element Text      //*[@name="valoare_credit"]
    Press Keys      //*[@name="valoare_credit"]     390000
    Sleep   2s
    BRD Enter Value
    Sleep   3s
    Close Browser

BCR First
    Open Browser   https://calculator-rate-credit.bcr.ro/#results_div     Chrome
    Maximize Browser Window
    Sleep  2s
    Click Element       //*[@id="MainContent_tip_credit"]//*[@value="1"]
    Sleep   1s
    Click Element       //*[@id="tip_produs"]//*[@value="6"]
    Click Element       //*[@id="currency"]//*[@value="RON"]
    Sleep   1s
    Click Element       //*[@id="tip_dobanda"]//*[@value="Fixa pentru 10 ani apoi variabila"]
    Click Element       //*[@id="client_s"]//*[@value="1"]
    Sleep   1s
    Click Element       //*[@id="val_credit"]
    Enter Value for First
    Click Element       //*[@id="val_perioada"]
    Enter Period
    Sleep  3s
    BCR Enter Value
    
    Reload Page
    Click Element       //*[@id="MainContent_tip_credit"]//*[@value="1"]
    Sleep   1s
    Click Element       //*[@id="tip_produs"]//*[@value="12"]
    Click Element       //*[@id="currency"]//*[@value="RON"]
    Sleep    2s
    Click Element       //*[@id="val_credit"]
    Enter Value for First
    Click Element       //*[@id="val_perioada"]
    Enter Period
    Sleep  3s
    BCR Enter Value for PrimaCasa
    Close Browser

CEC First
    Open Browser   https://www.cec.ro/credit-ipotecar-imobiliar     Chrome
    Maximize Browser Window
    Sleep  7s
    Wait Until element is visible   //*[@id="calculator_borrowed_value"]    20s
    Scroll element into view        //*[@id="calculator_borrowed_value"]
    Drag and Drop by offset         //*[@id="calc_value"]     -177  0
    Drag and Drop by offset         //*[@id="calc_range"]     174     0
    Sleep   1s
    Click element   //*[@id="calculator-calculate-btn"]
    Wait Until Element Is Visible   //*[@id="loanVarIterest"]   10s
    CEC Enter Value
    Sleep   3s
    Close Browser

CEC First PrimaCasa
    Open Browser   https://www.cec.ro/credite-noua-casa        Chrome
    Maximize Browser Window
    Sleep  5s
    Wait Until element is visible   //*[@id="calculator_borrowed_value"]    20s
    Scroll element into view        //*[@id="calculator_borrowed_value"]
    Drag and Drop by offset       //*[@id="calc_value"]     91  0
    Drag and Drop by offset       //*[@id="calc_range"]     300    0
    Sleep   5s
    Click element   //*[@id="calculator-calculate-btn"]
    Wait Until Element Is Visible   //*[@id="loanVarIterest"]   10s
    CEC Enter Value for PrimaCasa
    Sleep   3s
    Close Browser

Append Values in Excel for First

    Add value for first      ${File}\\IndiciFinanciari.xlsx     ${DobandaPA_ING}    ${DAE_PA_ING}     ${PrimaRata_ING}     ${RambursTotal_ING}    ${PC_DobandaPA_ING}    ${PC_DAE_PA_ING}     ${PC_PrimaRata_ING}     ${PC_RambursTotal_ING}      ${DobandaPA}    ${DAE_PA}     ${PrimaRata}     ${RambursTotal}    ${PC_DobandaPA}    ${PC_DAE_PA}     ${PC_PrimaRata}     ${PC_RambursTotal}    ${Dobanda_BRD}   ${DAE_BRD}      ${PrimaRata_BRD}    ${Total_BRD}    ${Dobanda_BCR}      ${DAE_BCR}      ${Rata_BCR}     ${Total_BCR}    ${DobandaPrima_BCR}      ${DAEPrima_BCR}      ${RataPrima_BCR}     ${TotalPrima_BCR}      ${Dobanda_CEC}    ${DAE_CEC}    ${Rata_CEC}     ${Total_CEC}    ${DobandaPrima_CEC}   ${DAEPrima_CEC}   ${RataPrima_CEC}   ${TotalPrima_CEC} 
    Close Browser

***Keywords***

Raiffeisen Enter Value for Ipotecar

    Sleep  1s
    ${DobandaPA}=   Get Text    ${DobandaRaiff}
    ${DobandaPA}=   Replace String  ${DobandaPA}    ,   .
    ${DobandaPA}=    Fetch From Left     ${DobandaPA}   %   
    ${DobandaPA}=   Convert to number   ${DobandaPA}
    Set Global Variable     ${DobandaPA}    ${DobandaPA}

    
    ${DAE_PA}=   Get Text    ${DAERaiff}
    ${DAE_PA}=   Replace String  ${DAE_PA}    ,   .
    ${DAE_PA}=    Fetch From Left     ${DAE_PA}   % 
    ${DAE_PA}=   Convert to number   ${DAE_PA}
    Set Global Variable      ${DAE_PA}     ${DAE_PA}

    ${PrimaRata}=   Get Text    ${RataLunaraRaiff}
    ${PrimaRata}=   Replace String  ${PrimaRata}    .   ${EMPTY}
    ${PrimaRata}=    Fetch From Left     ${PrimaRata}   Lei 
    ${PrimaRata}=   Convert to number   ${PrimaRata}
    Set Global Variable     ${PrimaRata}    ${PrimaRata}

    ${RambursTotal}=   Get Text    ${TotalRaiff}
    ${RambursTotal}=   Replace String  ${RambursTotal}    .   ${EMPTY}
    ${RambursTotal}=    Fetch From Left     ${RambursTotal}   Lei
    ${RambursTotal}=   Convert to number   ${RambursTotal}
    Set Global Variable     ${RambursTotal}     ${RambursTotal}

Raiffeisen Enter Value for Prima Casa

    ${PC_DobandaPA}=   Get Text    //*[@id="pannel-to-show-rent"]/*[@class="row full"]//h2[contains(text(),'%')]
    ${PC_DobandaPA}=   Replace String  ${PC_DobandaPA}    ,   .
    ${PC_DobandaPA}=    Fetch From Left     ${PC_DobandaPA}   %   
    ${PC_DobandaPA}=   Convert to number   ${PC_DobandaPA}
    Set Global Variable     ${PC_DobandaPA}      ${PC_DobandaPA}

    ${PC_DAE_PA}=   Get Text    //*[@id="pannel-to-show-rent"]/*[@class="row full"]//div[contains(text(),'%')]
    ${PC_DAE_PA}=   Replace String  ${PC_DAE_PA}    ,   .
    ${PC_DAE_PA}=    Fetch From Left     ${PC_DAE_PA}   % 
    ${PC_DAE_PA}=   Convert to number   ${PC_DAE_PA}
    Set Global Variable     ${PC_DAE_PA}      ${PC_DAE_PA}

    ${PC_PrimaRata}=   Get Text    //*[@id="pannel-to-show-rent"]/*[@class="row full"]//div[contains(text(),'Lei')][1]
    ${PC_PrimaRata}=   Replace String  ${PC_PrimaRata}    .   ${EMPTY}
    ${PC_PrimaRata}=    Fetch From Left     ${PC_PrimaRata}   Lei
    ${PC_PrimaRata}=   Convert to number   ${PC_PrimaRata}
    Set Global Variable    ${PC_PrimaRata}      ${PC_PrimaRata}

    ${PC_RambursTotal}=   Get Text    //*[contains(text(), 'Valoarea totala de plata')]/../following-sibling::div//div[contains(text(),'Lei')]
    ${PC_RambursTotal}=   Replace String  ${PC_RambursTotal}    .   ${EMPTY}
    ${PC_RambursTotal}=    Fetch From Left     ${PC_RambursTotal}   Lei
    ${PC_RambursTotal}=   Convert to number   ${PC_RambursTotal}
    Set Global Variable     ${PC_RambursTotal}      ${PC_RambursTotal}

ING Enter Value for Ipotecar

    ${DobandaPA}=   Get Text    ${DobandaING}
    ${DobandaPA}=   Replace String  ${DobandaPA}    ,   .
    ${DobandaPA_ING}=   Convert to number   ${DobandaPA}
    Set Global Variable     ${DobandaPA_ING}        ${DobandaPA_ING}

    ${DAE_PA}=   Get Text    ${DAE}
    ${DAE_PA}=   Replace String  ${DAE_PA}    ,   .
    ${DAE_PA_ING}=   Convert to number   ${DAE_PA}
    Set Global Variable     ${DAE_PA_ING}       ${DAE_PA_ING}

    ${PrimaRata}=   Get Text    ${RataLunara}
    ${PrimaRata}=   Replace String  ${PrimaRata}    .   ${EMPTY}
    ${PrimaRata}=   Replace String  ${PrimaRata}    ,   .
    ${PrimaRata_ING}=   Convert to number   ${PrimaRata}
    Set Global Variable         ${PrimaRata_ING}        ${PrimaRata_ING}

    ${RambursTotal}=   Get Text    ${Ramburs}
    ${RambursTotal}=   Replace String  ${RambursTotal}    .   ${EMPTY}
    ${RambursTotal}=   Replace String  ${RambursTotal}    ,   .
    ${RambursTotal_ING}=   Convert to number   ${RambursTotal}
    Set Global Variable            ${RambursTotal_ING}      ${RambursTotal_ING}

ING Enter Value for Prima Casa
    ${PC_DobandaPA}=   Get Text    ${DobandaING}
    ${PC_DobandaPA}=   Replace String  ${PC_DobandaPA}    ,   .
    ${PC_DobandaPA_ING}=   Convert to number   ${PC_DobandaPA}
    Set Global Variable     ${PC_DobandaPA_ING}     ${PC_DobandaPA_ING}

    ${PC_DAE_PA}=   Get Text    ${DAE}
    ${PC_DAE_PA}=   Replace String  ${PC_DAE_PA}    ,   .
    ${PC_DAE_PA_ING}=   Convert to number   ${PC_DAE_PA}
    Set Global Variable     ${PC_DAE_PA_ING}        ${PC_DAE_PA_ING}

    ${PC_PrimaRata}=   Get Text    ${RataLunara_PC}
    ${PC_PrimaRata}=   Replace String  ${PC_PrimaRata}    .   ${EMPTY}
    ${PC_PrimaRata}=   Replace String  ${PC_PrimaRata}    ,   .
    ${PC_PrimaRata_ING}=   Convert to number   ${PC_PrimaRata}
    Set Global Variable        ${PC_PrimaRata_ING}      ${PC_PrimaRata_ING}

    ${PC_RambursTotal}=   Get Text    ${Ramburs_PC}
    ${PC_RambursTotal}=   Replace String  ${PC_RambursTotal}    .   ${EMPTY}
    ${PC_RambursTotal}=   Replace String  ${PC_RambursTotal}    ,   .
    ${PC_RambursTotal_ING}=   Convert to number   ${PC_RambursTotal}
    Set Global Variable         ${PC_RambursTotal_ING}

BRD Enter Value
    ${Dobanda_BRD}=   Get Text    //*[@class="f-wrap-center sp-between"]//*[@style="font-size:14px"]
    ${Dobanda_BRD}=    Fetch From Right     ${Dobanda_BRD}   : 
    ${Dobanda_BRD}=    Fetch From Left     ${Dobanda_BRD}   %   
    ${Dobanda_BRD}=   Convert to number   ${Dobanda_BRD}
    Set Global Variable     ${Dobanda_BRD}    ${Dobanda_BRD}

    ${DAE_BRD}=   Get Text      //*[contains(text(),'DAE')]/following-sibling::div
    ${DAE_BRD}=    Fetch From Left     ${DAE_BRD}   % 
    ${DAE_BRD}=   Replace String  ${DAE_BRD}    ,   .  
    ${DAE_BRD}=   Convert to number   ${DAE_BRD}
    Set Global Variable     ${DAE_BRD}    ${DAE_BRD}

    ${PrimaRata_BRD}=   Get Text    //*[@class="first-rate-value"]
    ${PrimaRata_BRD}=   Replace String  ${PrimaRata_BRD}    .   ${EMPTY}
    ${PrimaRata_BRD}=   Replace String  ${PrimaRata_BRD}    ,   .
    ${PrimaRata_BRD}=    Fetch From Left     ${PrimaRata_BRD}   LEI
    ${PrimaRata_BRD}=   Convert to number       ${PrimaRata_BRD}
    Set Global Variable     ${PrimaRata_BRD}    ${PrimaRata_BRD}

    ${Total_BRD}=   Get Text    //*[contains(text(),'Valoare totală')]/following-sibling::div
    ${Total_BRD}=   Replace String  ${Total_BRD}    .   ${EMPTY}
    ${Total_BRD}=   Replace String  ${Total_BRD}    ,   .
    ${Total_BRD}=    Fetch From Left     ${Total_BRD}   LEI
    ${Total_BRD}=    Convert to number          ${Total_BRD}
    Set Global Variable     ${Total_BRD}        ${Total_BRD}

BCR Enter Value

    ${Rata_BCR}=     Get Text   //*[@id="rata_preview"]
    ${Rata_BCR}=   Replace String  ${Rata_BCR}    .   ${EMPTY}
    ${Rata_BCR}=   Replace String  ${Rata_BCR}    ,   .
    ${Rata_BCR}=    Fetch From Right    ${Rata_BCR}     :
    ${Rata_BCR}=   Convert to number    ${Rata_BCR}
    Set Global Variable     ${Rata_BCR}     ${Rata_BCR}
    ${DAE_BCR}=     Get Text   //*[@id="dae_preview"]
    ${DAE_BCR}=    Fetch From Left     ${DAE_BCR}       %
    ${DAE_BCR}=    Fetch From Right    ${DAE_BCR}     :
    ${DAE_BCR}=   Replace String  ${DAE_BCR}    ,   .
    ${DAE_BCR}=   Convert to number   ${DAE_BCR}
    Set Global Variable     ${DAE_BCR}      ${DAE_BCR}
    Click Element       //*[@id="MainContent_calculeaza"]
    Sleep    2s
    ${Dobanda_BCR}=     Get Text    //*[@class="r_dobanda_anuala"]
    ${Dobanda_BCR}=    Fetch From Left     ${Dobanda_BCR}       %
    ${Dobanda_BCR}=   Replace String  ${Dobanda_BCR}    ,   .
    ${Dobanda_BCR}=   Convert to number   ${Dobanda_BCR}
    Set Global Variable     ${Dobanda_BCR}  ${Dobanda_BCR}
    Sleep   2s
    Scroll Element into view        //*[@class="scadentar"]//*[@class="par-row"][181]//td[6]
    Drag and Drop by offset       //*[@class="jspDrag"]   100     400
    Sleep   1s
    ${Total_BCR}=   Get Text    //*[@class="scadentar"]//*[@class="par-row"][181]//td[6]
    ${Total_BCR}=   Replace String  ${Total_BCR}    .   ${EMPTY}
    ${Total_BCR}=   Replace String  ${Total_BCR}    ,   .
    ${Total_BCR}=   Convert to number   ${Total_BCR}
    Set Global Variable     ${Total_BCR}    ${Total_BCR}

BCR Enter Value for PrimaCasa

    ${RataPrima_BCR}=     Get Text   //*[@id="rata_preview"]
    ${RataPrima_BCR}=   Replace String  ${RataPrima_BCR}    .   ${EMPTY}
    ${RataPrima_BCR}=   Replace String  ${RataPrima_BCR}    ,   .
    ${RataPrima_BCR}=    Fetch From Right    ${RataPrima_BCR}     :
    ${RataPrima_BCR}=   Convert to number    ${RataPrima_BCR}
    Set Global Variable     ${RataPrima_BCR}     ${RataPrima_BCR}
    ${DAEPrima_BCR}=     Get Text   //*[@id="dae_preview"]
    ${DAEPrima_BCR}=    Fetch From Left     ${DAEPrima_BCR}       %
    ${DAEPrima_BCR}=    Fetch From Right    ${DAEPrima_BCR}     :
    ${DAEPrima_BCR}=   Replace String  ${DAEPrima_BCR}    ,   .
    ${DAEPrima_BCR}=   Convert to number   ${DAEPrima_BCR}
    Set Global Variable     ${DAEPrima_BCR}      ${DAEPrima_BCR}
    Click Element       //*[@id="MainContent_calculeaza"]
    Sleep    2s
    ${DobandaPrima_BCR}=     Get Text    //*[@class="r_dobanda_anuala"]
    ${DobandaPrima_BCR}=    Fetch From Left     ${DobandaPrima_BCR}       %
    ${DobandaPrima_BCR}=   Replace String  ${DobandaPrima_BCR}    ,   .
    ${DobandaPrima_BCR}=   Convert to number   ${DobandaPrima_BCR}
    Set Global Variable     ${DobandaPrima_BCR}  ${DobandaPrima_BCR}
    Sleep   2s
    Scroll Element into view        //*[@class="scadentar"]//*[@class="par-row"][181]//td[6]
    Drag and Drop by offset       //*[@class="jspDrag"]   100     400
    Sleep   1s
    ${TotalPrima_BCR}=   Get Text    //*[@class="scadentar"]//*[@class="par-row"][181]//td[6]
    ${TotalPrima_BCR}=   Replace String  ${TotalPrima_BCR}    .   ${EMPTY}
    ${TotalPrima_BCR}=   Replace String  ${TotalPrima_BCR}    ,   .
    ${TotalPrima_BCR}=   Convert to number   ${TotalPrima_BCR}
    Set Global Variable     ${TotalPrima_BCR}    ${TotalPrima_BCR}


CEC Enter Value
    ${Dobanda_CEC}=   Get Text    //*[@id="loanVarIterest"]
    ${Dobanda_CEC}=    Fetch From Left     ${Dobanda_CEC}   %   
    ${Dobanda_CEC}=   Convert to number   ${Dobanda_CEC}
    Set Global Variable     ${Dobanda_CEC}    ${Dobanda_CEC}

    ${DAE_CEC}=   Get Text    //*[@id="loanVarDae"]
    ${DAE_CEC}=    Fetch From Left     ${DAE_CEC}   %   
    ${DAE_CEC}=   Convert to number   ${DAE_CEC}
    Set Global Variable     ${DAE_CEC}    ${DAE_CEC}

    ${Rata_CEC}=   Get Text    //*[@id="loanVarFirstInstallment"]
    ${Rata_CEC}=    Fetch From Left     ${Rata_CEC}   Lei
    ${Rata_CEC}=   Convert to number   ${Rata_CEC}
    Set Global Variable     ${Rata_CEC}    ${Rata_CEC}
    
    ${Total_CEC}=   Get Text    //*[@id="loanVarTotal"]
    ${Total_CEC}=    Fetch From Left     ${Total_CEC}   Lei
    ${Total_CEC}=   Convert to number   ${Total_CEC}
    Set Global Variable     ${Total_CEC}    ${Total_CEC}

CEC Enter Value for PrimaCasa
    ${DobandaPrima_CEC}=   Get Text    //*[@id="loanVarIterest"]
    ${DobandaPrima_CEC}=    Fetch From Left     ${DobandaPrima_CEC}   %   
    ${DobandaPrima_CEC}=   Convert to number   ${DobandaPrima_CEC}
    Set Global Variable     ${DobandaPrima_CEC}    ${DobandaPrima_CEC}

    ${DAEPrima_CEC}=   Get Text    //*[@id="loanVarDae"]
    ${DAEPrima_CEC}=    Fetch From Left     ${DAEPrima_CEC}   %   
    ${DAEPrima_CEC}=   Convert to number   ${DAEPrima_CEC}
    Set Global Variable     ${DAEPrima_CEC}    ${DAEPrima_CEC}

    ${RataPrima_CEC}=   Get Text    //*[@id="loanVarFirstInstallment"]
    ${RataPrima_CEC}=    Fetch From Left     ${RataPrima_CEC}   Lei
    ${RataPrima_CEC}=   Convert to number   ${RataPrima_CEC}
    Set Global Variable     ${RataPrima_CEC}    ${RataPrima_CEC}
    
    ${TotalPrima_CEC}=   Get Text    //*[@id="loanVarTotal"]
    ${TotalPrima_CEC}=    Fetch From Left     ${TotalPrima_CEC}   Lei
    ${TotalPrima_CEC}=   Convert to number   ${TotalPrima_CEC}
    Set Global Variable     ${TotalPrima_CEC}    ${TotalPrima_CEC}