    server {
        listen       8003;
        server_name  www.capture.com;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            autoindex   on;
            root   /Users/lvchengbin/Projects/Grouple/public;
            index  index.php index.html index.htm;
            if (!-e $request_filename) {
                rewrite ^/(.*)  /index.php?$1 last;
            }
        }
        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        location ~* \.(html|gif|jpg|jpeg|png|bmp|swf|mp4|js|css|svg|otf|eot|ttf|woff)$ {
            root /Users/lvchengbin/Projects/Grouple;
            expires 10d;
        }



        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        location ~ \.php$ {
            root           html;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  /Users/lvchengbin/Projects/Grouple/public$fastcgi_script_name;
            include        fastcgi_params;
        }

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }

