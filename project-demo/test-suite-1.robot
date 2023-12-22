*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     chrome

${TITLE}    Cara Buat Kue
${CONTENT}  Ini adalah isi artikel tentang pembuatan kue
${AUTHOR}    Rama Zuliyansyah
${TITLE2}    Cara Buat Kue
${CONTENT2}  Siapkan bahan-bahan seperti telur, tepung, air, dan pewarna makanan
${AUTHOR2}    Zul
${TITLE3}    Umpan Ikan Nila Gacor
${CONTENT3}  Siapkan Pelet Ikan Nila dan Essen
${AUTHOR3}    Zuliyansyah
${popup_message}   Handle Alert
# Untuk test case "Edit Post" /edit/21. Angka tertera harus menyesuaikan dengan ID atau nomor postingan
# Untuk test case "Delete Post", postingan yang akan di hapus adalah postingan yang paling pertama pada  tabel 'All Posts'
*** Test Cases ***

# Test 1 (Create Post)
testcase-2 Open web, click insert and create post
    Open Browser    http://localhost:3000    chrome
    Click Element     xpath://a[@href='/create']
    Page Should Contain Element    xpath://input[@name='title']
    input text        name:title       ${TITLE}
    input text        name:content    ${CONTENT}
    input text        name:author    ${AUTHOR}
    Click Element     xpath://button[@type='submit']
    Sleep    1s

# Test 2 (Edit Post)
testcase-2 Open web and edit post
    Open Browser    http://localhost:3000    chrome
    Click Element     xpath://a[@href='/edit/21'] 
    Page Should Contain Element    xpath://input[@name='title']
    input text        name:title       ${TITLE2}
    input text        name:content    ${CONTENT2}
    input text        name:author    ${AUTHOR2}
    Click Element     xpath://button[@type='submit']
    Sleep    1s

#Test 3 (Delete Post)
testcase-3 Delete Post
    Open Browser    http://localhost:3000    chrome
    Click Element     xpath://a[@href='/delete/']
    Handle Alert    action=ACCEPT
    Page Should Contain    All Post
    Sleep    1s

# Test 4 (Create Post After The Web Already Have One)
testcase-4 Create Post After The Web Already Have One
    Open Browser    http://localhost:3000    chrome
    Click Element     xpath://a[@href='/create']
    Page Should Contain Element    xpath://input[@name='title']
    input text        name:title       ${TITLE3}
    input text        name:content    ${CONTENT3}
    input text        name:author    ${AUTHOR3}
    Click Element     xpath://button[@type='submit']
    Page Should Contain    All Post
    Sleep    1s

# Test 5 (View Post)
testcase-5 View Post
    Open Browser    http://localhost:3000    chrome
    Click Element     xpath://a[@href='/post/22']
    Page Should Contain    Cara Buat Kue
    Page Should Contain    Ini adalah isi artikel tentang pembuatan kue
    Sleep    1s

*** Keywords ***

Scroll Down Until End
    ${previous_height}=    Execute Javascript    return document.body.scrollHeight;
    FOR  ${i}    IN RANGE    10
        Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
        Sleep    1s
        ${current_height}=    Execute Javascript    return document.body.scrollHeight;
        Exit For Loop If    '${current_height}' == '${previous_height}'
        ${previous_height}=    Set Variable    ${current_height}
        Sleep    2s
    END

Login Success
    Open Browser    http://127.0.0.1:8000    chrome
    Click Element     xpath://a[@href='/login']
    Page Should Contain Element   xpath://input[@name='email']
    input text        name:email       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://button[@type='submit']
    Page Should Contain Element   xpath://a[@href='/listings/manage']