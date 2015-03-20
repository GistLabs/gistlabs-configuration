server {
        listen 80;
        server_name *.agileroadmapping.com;
              rewrite ^/(.*) http://agileroadmapping.com/$1 redirect;
}
server {
	listen   80;
	server_name  agileroadmapping.com;

	
	location / {
     	 proxy_set_header X-Real-IP $remote_addr;
      	 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	 proxy_set_header Host $http_host;
         proxy_set_header X-NginX-Proxy true;
         proxy_pass http://127.0.0.1:8889/;
         proxy_redirect off;
  	}

	 location ~ /\. { deny  all; }
}


