# Installs a Nginx server with custom HTTP header

exec {'install':
  provider => shell,
  command  => '
  sudo apt-get -y update;
  sudo apt -y upgrade;
  sudo apt-get -y install nginx;
  sudo chown -R ubuntu:ubuntu /var/www;
  echo "Hello World!" > /var/www/html/index.html;
  echo "Ceci n'est pas une page" > /var/www/html/404.html;
  sudo sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;/" /etc/nginx/sites-enabled/default;
  sudo sed -i "s/listen 80 default_server;/listen 80 default_server;\n\terror_page 404 \/404.html;\n\tlocation = \/404.html {\n\t\troot \/var\/www\/html;\n\t\tinternal;\n\t}/" /etc/nginx/sites-enabled/default;
  sudo sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\tadd_header X-Served-By \"$HOSTNAME\";/" /etc/nginx/nginx.conf;
  sudo service nginx stop;
  sudo service nginx start',
}
