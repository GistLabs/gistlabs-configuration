server {
      listen 80;
        server_name *.agileroadmapping.com;
              rewrite ^/(.*) http://agileroadmapping.com/$1 redirect;
}

server {
	listen   80;
	server_name  agileroadmapping.com;

	location / {
		root   /var/www/agileroadmapping.com/public_html;
		index  index.html index.htm;

	}
	 location ~ /\. { deny  all; }
}


