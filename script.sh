#!/bin/bash

read method path query <<<$(echo $REQUEST_METHOD $PATH_INFO $QUERY_STRING)
if [ "$method" = "POST" ]; then
    read -n $CONTENT_LENGTH post_data
    pid=$(echo $post_data | sed 's/pid=//')
    sudo kill $pid
fi

echo "Content-type: text/html"
echo ""
echo "<html>"
echo "    <head>"
echo "        <title>Mi primera pagina dinamica</title>"
echo "    </head>"
echo "    <body>"
echo "        <pre>"
ps aux
echo "        </pre>"
echo "        <form method='POST' action='/cgi-bin/script.sh'>"
echo "            <label for='pid'>PID:</label>"
echo "            <input type='text' id='pid' name='pid'>"
echo "            <input type='submit' value='Matar'>"
echo "        </form>"
echo "    </body>"
echo "</html>"

