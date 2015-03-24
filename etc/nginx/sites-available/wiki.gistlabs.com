server {
	listen   80;
	server_name  wiki.gistlabs.com;

	
	location / {
     	 proxy_set_header X-Real-IP $remote_addr;
      	 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	 proxy_set_header Host $http_host;
         proxy_set_header X-NginX-Proxy true;
         proxy_pass http://127.0.0.1:4567/;
         proxy_redirect off;
  	}

	 location ~ /\. { deny  all; }
}

server {
        listen   80;
        server_name  editwiki.gistlabs.com;
	return 301 https://$host$request_uri;
}


server {
	listen   443;
	server_name  editwiki.gistlabs.com;

	ssl on;
   	ssl_certificate /home/common/unmanaged/editwiki.gistlabs.com/ssl/editwiki-gistlabs.cert.pem;
    	ssl_certificate_key /home/common/unmanaged/editwiki.gistlabs.com/ssl/editwiki-gistlabs.key.pem;

	    # side note: only use TLS since SSLv2 and SSLv3 have had recent vulnerabilities
    	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;


	location / {
	auth_basic "Restricted";
    	auth_basic_user_file /home/common/unmanaged/editwiki.gistlabs.com/htpasswd;
     	 proxy_set_header X-Real-IP $remote_addr;
      	 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	 proxy_set_header Host $http_host;
         proxy_set_header X-NginX-Proxy true;
         proxy_pass http://127.0.0.1:4568/;
         proxy_redirect http://127.0.0.1:4568 https://editwiki.gistlabs.com;
  	}

	 location ~ /\. { deny  all; }
}


