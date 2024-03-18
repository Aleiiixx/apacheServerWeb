# #!/bin/bash

# read method path query <<<$(echo $REQUEST_METHOD $PATH_INFO $QUERY_STRING)
# if [ "$method" = "POST" ]; then
#     read -n $CONTENT_LENGTH post_data
#     pid=$(echo $post_data | sed 's/pid=//')
#     sudo kill $pid
# fi

# echo "Content-type: text/html"
# echo ""
# echo "<html>"
# echo "    <head>"
# echo "        <title>Mi primera pagina dinamica</title>"
# echo "    </head>"
# echo "    <body>"
# echo "        <pre>"
# ps aux
# echo "        </pre>"
# echo "        <form method='POST' action='/cgi-bin/script.sh'>"
# echo "            <label for='pid'>PID:</label>"
# echo "            <input type='text' id='pid' name='pid'>"
# echo "            <input type='submit' value='Matar'>"
# echo "        </form>"
# echo "    </body>"
# echo "</html>"

#!/bin/bash

read method path query <<<$(echo $REQUEST_METHOD $PATH_INFO $QUERY_STRING)

if [ "$method" = "POST" ]; then
    read -n $CONTENT_LENGTH post_data
    action=$(echo $post_data | sed 's/.*action=\([^&]*\).*/\1/')
    if [[ "$action" == "kill" ]]; then
        pid=$(echo $post_data | sed 's/.*pid=\([^&]*\).*/\1/')
        sudo kill $pid
    fi
fi

echo "Content-type: text/html"
echo ""

cat <<EOF
<html>
    <head>
        <title>Mi primera pagina dinamica</title>
    </head>
    <body>
        <form method='POST' action='/cgi-bin/script.sh'>
            <input type='radio' id='processes' name='action' value='processes' checked>
            <label for='processes'>Procesos</label><br>
            <input type='radio' id='monitoring' name='action' value='monitoring'>
            <label for='monitoring'>Monitorización</label><br>
            <label for='pid'>PID:</label>
            <input type='text' id='pid' name='pid'>
            <input type='submit' value='Enviar'>
        </form>
EOF

if [[ "$action" == "monitoring" ]]; then
    echo "<h2>Monitorización del Servidor</h2>"
    echo "<pre>"
    echo "Carga de CPU, memoria y disco:"
    top -bn1 | head -5
    echo ""
    echo "Tiempo que lleva el servidor encendido:"
    uptime
    echo ""
    echo "Los 10 últimos logins:"
    last -n 10
    echo "</pre>"
else
    echo "<pre>"
    ps aux
    echo "</pre>"
fi

echo "    </body>"
echo "</html>"
