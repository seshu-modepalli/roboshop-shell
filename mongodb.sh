source common.sh

print_head("Setting up the mongodb repository")
cp ${code_dir}/config/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
status_check $?

print_head("Installing mongodb")
yum install mongodb-org -y &>>${log_file}
status_check $?

print_head "Update MongoDB Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}
status_check $?

print_head("Enabling mongodb")
systemctl enable mongod 
status_check $?

print_head("Starting mongodb")
systemctl start mongod 
status_check $?