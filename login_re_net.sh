#!/bin/bash

RESULT_FILE=/tmp/login_re_net_result.html
COOKIE_FILE=/tmp/login_re_net_cookie

curl 'https://account.capcom.com/oauth2014/login.post' -H 'Origin: https://account.capcom.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: ja,en-US;q=0.8,en;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://account.capcom.com/oauth2014/authorize.html?lang=ja&response_type=code&mobileFlg=&client_id=oauth-residentevilnet-service&redirect_uri=https%3A%2F%2Fwww.residentevil.net%2Fja%2F%2Fsignin-callback.html&scope=basic_info_w%20basic_info_r%20gaming_account%20account_list&state=&css_uri=https%3A%2F%2Fwww.residentevil.net%2F%2Fpc%2Fcss%2Fchange.css&tos_uri=https%3A%2F%2Fwww.residentevil.net%2F%5Blang%5D%2Fagreement.html&enable_register_link=true&allow_temporary=false' -H 'Connection: keep-alive' -H 'DNT: 1' --data "id=${MAIL}&pass=${PASSWORD}&lang=ja&response_type=code&client_id=oauth-residentevilnet-service&redirect_uri=https%3A%2F%2Fwww.residentevil.net%2Fja%2F%2Fsignin-callback.html&scope=basic_info_w+basic_info_r+gaming_account+account_list&state=&css_uri=https%3A%2F%2Fwww.residentevil.net%2F%2Fpc%2Fcss%2Fchange.css&tos_uri=https%3A%2F%2Fwww.residentevil.net%2F%5Blang%5D%2Fagreement.html&enable_register_link=true&allow_temporary=false" --compressed -b ${COOKIE_FILE} -c ${COOKIE_FILE} -L --verbose >${RESULT_FILE} 2>/dev/null
rm -rf ${COOKIE_FILE}

cat ${RESULT_FILE} 2>/dev/null | grep "ログインボーナス" >/dev/null 2>&1
if [ $? -ne 0 ]; then
    cat ${RESULT_FILE} 2>/dev/null | grep "ログアウト" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "{\"result\":false}"
        exit 1
    fi
fi

echo "{\"result\":true}"
exit 0
