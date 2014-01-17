###################################################################
##### Interactive Strategies Drupal VM Bootstraping           ##### 
##### This paired with Vagrant basebox CentOS.                #####  
##### Should also work with Debian and Suse base systems.     #####  
#####                                                         ##### 
###################################################################
#####                                                         #####
#####        Enviroment/Project Configuration.                #####
###################################################################

#What's the domain you want to run on - don't use .com
$host_name = 'localhost'

#What's the project folder for the site you're using?

#Database Configuration - See Project ReadMe
$db_name = 'chocolate_factory_db'
$db_user = 'willy'
$db_user_password = 'wonka'

  import "classes/*"
  class {'drupal_php': }
  class {'drupal_db':
	  drupal_user          => $db_user,
	  drupal_user_password => $db_user_password,
	  drupal_database      => $db_name,
  }
  class {'drupal_apache': }
