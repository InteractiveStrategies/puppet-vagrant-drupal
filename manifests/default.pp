##################################################################
#####Interactive Strategies Drupal VM Bootstraping           ##### 
#####This paired with Vagrant basebox CentOS.                #####  
#####Should also work with Debian and Suse base systems.     #####  
#####                                                        ##### 
##################################################################
#####                                                        #####
#####       Enviroment/Project Configuration.                #####
##################################################################

#What's the domain you want to run on - don't use .com
$host_name = 'localhost'

#What's the project folder for the site you're using?

#Database Configuration - See Project ReadMe
$db_name = 'apwu_stage'
$db_user = 'drAst8heSwaB4swe'
$db_password = 'SwUsagE5es6==Fuv'
$db_host = 'localhost'

/*
DB filename and path relavant to project/trunk/ ie:
|-trunk
|----|`_docs
|---------|`mycoolsite.sql
$db_file = '/vagrant/_docs/mycoolsite.sql'


$db_file = '/vagrant/_docs/apwu/apwu_stage.sql'
*/
/*
Bootstrap PHP enviroment beyond typcial installs for better Drupal support.
*/
  package { php-gd: }
  package { php-mysql: }
  package { php-mbstring: }
  package { php-pear: }
  package { php-xml: }
  Package {
    ensure => installed }
/*
  Pear currently causing a fail, after initial install.
*/
  exec { "pear install Console_Table":
    unless => "/usr/bin/pear install Console_Table",
    command => Package['php-pear']
  }

/*
  Pulls in all puppet manifests within the classes folder, within root dir

  TODO Refactor this section into the class files - just pass all variable here
*/  
  import "classes/*"
  class {'drupal::drush':}
  #Create Database
  import "classes/*"
  mysql::db { $db_name:
    user => $db_user,
    password => $db_password,
    charset => 'utf8',
    host => $db_host,
    grant => ['all'],
  }

/* Uncomment this section to load a databse: currently over writes everything.
  exec { "restore database":
    command => "mysql -u root -ptester $db_name < $db_file",
    path => '/usr/bin/',
  }
  */

/* 
  Create Apache Vhost
*/

  apache::vhost { $host_name :
    vhost_name => $host_name,
    port => '80',
    docroot => '/vagrant/drupal',
    serveradmin => 'support@interactivestrategies.com',
  }  
