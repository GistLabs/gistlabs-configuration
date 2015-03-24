server {
        listen 80;
        server_name *.concordinate.com;
              rewrite ^/(.*) http://concordinate.com/$1 redirect;
}

server {
	listen   80;
	server_name  concordinate.com;

	location / {
		root   /var/www/concordinate.com/public_html;
		index  index.html index.htm;

	}
	 location ~ /\. { deny  all; }
}


