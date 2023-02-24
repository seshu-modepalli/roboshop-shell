source common.sh

print_head "installing nginx" 
yum install nginx -y &>>${log_file}
status_check $?


print_head "Removing the old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check $?

print_head "Downloading the frontend source"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
status_check $?

print_head "Extracting downloaded frontend"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>${log_file}
status_check $?

print_head "Copying Nginx config for roboshop"
cp ${code_dir}/config/nginx_roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
status_check $?

print_head "Enabling nginx"
systemctl enable nginx &>>${log_file}
status_check $?

print_head "Starting nginx"
systemctl start nginx &>>${log_file}
status_check $?