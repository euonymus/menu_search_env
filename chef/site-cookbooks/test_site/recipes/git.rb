deploy_user = node[:test_site][:deploy_user]

# group 'git' do
#   group_name 'git'
#   gid        403
#   action     [:create]
# end

user deploy_user do
  supports :manage_home => true
  comment "Random User"
  gid "users"
  home "/home/#{deploy_user}"
  shell "/bin/bash"
  password "$1$JJsvHslV$szsCjVEroftprNn4JHtDi."
end

file "/etc/sudoers.d/root_ssh_agent" do
  mode 0440
  owner 'root'
  group 'root'
  content "Defaults\tenv_keep += \"SSH_AUTH_SOCK\""
end

git "/home/#{deploy_user}/deploy/" do
  repository "git@bitbucket.org:euonymus/data_bag_key_test.git"
  reference "master"
  user deploy_user
  group "users"
  action :sync
end
