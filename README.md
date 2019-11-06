# ansible semaphore for vagrant
[Ansible semaphore is open source ansible UI.](https://github.com/ansible-semaphore/semaphore)
- - -


## How to deploy
- - -
- [Setting vagrant](#setting_vagrant)
- [Setting semaphore](#setting_semaphore)


### Setting vagrant <a name="setting_vagrant"></a>
- - -
#### vagrant start before ansible semaphore setup
    - Add vagrant box
    mkdir -p ~/vagrant/centos7
    cd ~/vagrant/centos7
    vagrant box list
    vagrant box add centos/7
    [Enter your choice: 3]
    vagrant box list

    - Setting Vagrantfile
    git clone https://git.rakuten-it.com/scm/ops-dba/vagrant_ansible_semaphore.git
    cp -p vagrant_ansible_semaphore/Vagrantfile ./Vagrantfile
    cp -p vagrant_ansible_semaphore/install.sh ./install.sh
    cat ~/vagrant/centos7/Vagrantfile
    cat ~/vagrant/centos7/install.sh

    - Start vagrant
    vagrant up
    vagrant ssh


#### vagrant restart after ansible semaphore setup
    - Restart vagrant
    vagrant halt
    vagrant up
    vagrant ssh

    - Start mysqld
    sudo systemctl stop mysqld
    sudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables"
    sudo systemctl start mysqld

    - Start ansible semaphore
    cd /home/vagrant/ansible_semaphore
    sudo nohup ./semaphore -config /home/vagrant/ansible_semaphore/config.json &
    ps -ef | grep semaphore
    [Please check following URL.]
    http://localhost:8080


### Setting ansible semaphore <a name="setting_semaphore"></a>
- - -
#### ansible semaphore setup
    /home/vagrant/ansible_semaphore/semaphore -setup
    --------------------
    Hello! You will now be guided through a setup to:
    1. Set up configuration for a MySQL/MariaDB database
    2. Set up a path for your playbooks (auto-created)
    3. Run database Migrations
    4. Set up initial semaphore user & password
    DB Hostname (default 127.0.0.1:3306):
    WARN[0013] An input error occured:unexpected newline
    DB User (default root):
    WARN[0017] An input error occured:unexpected newline
    DB Password:
    WARN[0020] An input error occured:unexpected newline
    DB Name (default semaphore):
    WARN[0030] An input error occured:unexpected newline
    Playbook path (default /tmp/semaphore):
    Web root URL (optional, example http://localhost:8010/): http://localhost:80/
    Enable email alerts (y/n, default n): n
    Enable telegram alerts (y/n, default n): n
    Enable LDAP authentication (y/n, default n): n
    Is this correct? (yes/no): yes
    Config output directory (default /home/vagrant): /home/vagrant/ansible_semaphore
    Username: admin
    Email: {your name}@rakuten.com
    WARN[0104] sql: no rows in result set level=Warn
    Your name: {your name}
    Password: admin
    --------------------

    vi /home/vagrant/ansible_semaphore/config.json
    --------------------
    "port": "80",
    --------------------

    - Start ansible semaphore
    cd /home/vagrant/ansible_semaphore
    sudo nohup ./semaphore -config /home/vagrant/ansible_semaphore/config.json &
    ps -ef | grep semaphore
    [Please check following URL.]
    http://localhost:8080

    - Stop ansible semaphore
    ps -ef | grep semaphore
    sudo pkill -9 semaphore
    ps -ef | grep semaphore


#### ansible semaphore setting by WEB
    [step1.Key Store]
    Input RSA PRIVATE KEY
    [step2.Inventory]
    Select SSH Key
    [step3.Playbook Repositories]
    Input Repository
    [step4.Task Templates]
    Select SSH Key, Inventory, Playbook Repository
