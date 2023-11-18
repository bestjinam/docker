
Folder=/home/$USER/data/self_cert_ssl_files
mkdir -p $Folder 
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout $Folder/jinam.42.fr.key \
        -out $Folder/jinam.42.fr.crt \
        -subj "/C=KR/L=Seoul/O=42Seoul/CN=jinam.42.fr" \
        > /dev/null 2>&1
