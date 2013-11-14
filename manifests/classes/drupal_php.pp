class php_drupal {
	/*
	*Class for initililzing minimal Drupal PHP requirements needed to run drupal.
	*TODO add logic for coniditionally installing drush...
	*TODO add php.inc
	*/

	
	include pear
	#OS Specific PHP installation packages
	$apt_php_packages = ["php-xml-parser", "php5-mysql",
	                    "drush"]
	$rpm_php_packages = ["php-gd", "php-mysql", "php-mbstring", 
	                    "php-xml"]

        #We use Pear Module since RPM doesn't have a drush package.		    
	pear::package {"PEAR": }
	pear::package {"Console_Table": }
	
	case $operatingsystem {
		centos, redhat: {
			package { $rpm_php_packages:
				ensure => installed }
	
			pear::package { "drush":
				repository => "pear.drush.org",
			}
	        }
	} 

	case $operatingsystem {
		debian, ubunutu:  {
			package { $apt_php_packages:
				ensure => installed }
                }
	}
}
