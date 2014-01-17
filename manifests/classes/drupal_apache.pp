class drupal_apache {
    #TODO Complete SuPHP setup
    $apt_php_apache = ["suphp_common"]
    $rpm_php_apache = ["mod_suphp"]
    #
    class { '::apache':
	    user  => 'vagrant',
	    group => 'vagrant',
    }
    

    case $operatingsystem {
	    centos, redhat: {
		    package { $rpm_php_apache:
			    ensure => installed
		    }
	    }
    }
    case $operatingsystem {
	    debian, ubuntu: {
		    package { $apt_php_apache:
			    ensure => installed
		    }
	    }
    }
            
    apache::vhost { 'myawesomeness.locahost':
	    port             => '80',
	    docroot          => '/vagrant/trunk',	
	    docroot_owner    => 'vagrant',
	    docroot_group    => 'vagrant',
    }
   
    notify { 'apache vhost configured?': }
}
