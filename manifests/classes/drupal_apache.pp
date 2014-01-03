class drupal_apache inherits apache {
    apache::vhost { 'myawesomeness.locahost':
	    port          => '80',
	    docroot       => '/vagrant/trunk',	
	    docroot_owner => 'vagrant',
	    docroot_group => 'vagrant',
	    suphp_engine  => 'on',
        	directories => 
			{ 
			path   => '/vagrant/trunk',
			'suphp' => {
				user  => 'vagrant',
				group  => 'vagrant'
			},
			}
    
    }
    notify { 'apache vhost configured?': }
}
