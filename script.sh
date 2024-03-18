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
# ps aux | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
# echo "        </pre>"
# echo "        <form method='POST' action='/cgi-bin/script.sh'>"
# echo "            <label for='pid'>PID:</label>"
# echo "            <input type='text' id='pid' name='pid'>"
# echo "            <input type='submit' value='Matar'>"
# echo "        </form>"
# echo "        <h2>Estado del servidor:</h2>"
# echo "        <h3>Recursos del servidor:</h3>"
# echo "        <pre>"
# echo "Carga de la CPU:"
# uptime | cut -d ":" -f 5
# echo "Memoria:"
# free -h
# echo "Espacio en disco:"
# df -h
# echo "        </pre>"
# echo "        <h3>Tiempo encendido (uptime):</h3>"
# echo "        <pre>"
# uptime
# echo "        </pre>"
# echo "        <h3>Ultimos 10 logins:</h3>"
# echo "        <pre>"
# last -n 10
# echo "        </pre>"
# echo "    </body>"
# echo "</html>"


#!/bin/bash

read method path query <<<$(echo $REQUEST_METHOD $PATH_INFO $QUERY_STRING)
if [ "$method" = "POST" ]; then
    read -n $CONTENT_LENGTH post_data
    pid=$(echo $post_data | sed 's/pid=//')
    sudo kill $pid
    # Ejecutar comando para reiniciar servidor Apache
    if [ "$path" = "/cgi-bin/reiniciar.sh" ]; then
        sudo systemctl restart apache2
    fi
    # Ejecutar comando para apagar servidor Apache
    if [ "$path" = "/cgi-bin/apagar.sh" ]; then
        sudo systemctl stop apache2
    fi
fi

echo "Content-type: text/html"
echo ""
echo "<html>"
echo "    <head>"
echo "        <title>Mi primera pagina dinamica</title>"
echo "    </head>"
echo "    <body>"
echo "        <pre>"
ps aux | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
echo "        </pre>"
echo "        <form method='POST' action='/cgi-bin/script.sh'>"
echo "            <label for='pid'>PID:</label>"
echo "            <input type='text' id='pid' name='pid'>"
echo "            <input type='submit' value='Matar'>"
echo "        </form>"
echo "        <h2>Estado del servidor:</h2>"
echo "        <h3>Recursos del servidor:</h3>"
echo "        <pre>"
echo "Carga de la CPU:"
uptime | cut -d ":" -f 5
echo "Memoria:"
free -h
echo "Espacio en disco:"
df -h
echo "        </pre>"
echo "        <h3>Tiempo encendido (uptime):</h3>"
echo "        <pre>"
uptime
echo "        </pre>"
echo "        <h3>Ultimos 10 logins:</h3>"
echo "        <pre>"
last -n 10
echo "        </pre>"
echo "        <form method='POST' action='/cgi-bin/reiniciar.sh'>"
echo "            <input type='submit' value='Reiniciar servidor Apache'>"
echo "        </form>"
echo "        <form method='POST' action='/cgi-bin/apagar.sh'>"
echo "            <input type='submit' value='Apagar servidor Apache'>"
echo "        </form>"
echo "    </body>"
echo "</html>"
