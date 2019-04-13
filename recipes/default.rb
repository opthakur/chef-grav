#
# Cookbook:: chef-grav
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package "php-mbstring" do
        action :install
end

remote_file "Downloading Grav" do
        source 'https://github.com/getgrav/grav/releases/download/1.5.10/grav-admin-v1.5.10.zip'
        path '/tmp/grav-admin.zip'
        not_if{File.exists?("/tmp/grav-admin.zip")}
end

execute "Extracting grav-admin.zip" do
        command 'sudo unzip /tmp/grav-admin.zip -d /var/www/html/'
        not_if{File.exists?("/var/www/html/grav-admin")}
end

execute "Setting permission of grav-admin" do
        command 'sudo chmod -R 775 /var/www/html/grav-admin'
end

execute "Changing ownership of grav-admin folder" do
        command 'sudo chown -R www-data:www-data /var/www/html/grav-admin'
end

execute "Restarting apache2" do
        command 'service apache2 restart'
end
