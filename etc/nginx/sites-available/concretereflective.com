server {
        listen 80;
        server_name *.concretereflective.com;
              rewrite ^/(.*) http://concretereflective.com/$1 redirect;
}
server {
	listen   80;
	server_name  concretereflective.com;

	
	location / {
     	 proxy_set_header X-Real-IP $remote_addr;
      	 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	 proxy_set_header Host $http_host;
         proxy_set_header X-NginX-Proxy true;
         proxy_pass http://127.0.0.1:8881/;
         proxy_redirect off;
  	}

	 location ~ /\. { deny  all; }
}


