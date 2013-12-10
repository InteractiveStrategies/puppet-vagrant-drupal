class drupal_db (
	$drupal_user = drupal,
	$drupal_user_password = drupal,
	$drupal_database = drupal,
        )
	{
	/*
         * Extention of the Puppet Labs MySQL Puppet Module.
        */
	class { '::mysql::server':
		root_password => 'interactivedatabase',
	}
	class { '::mysql::server::backup':

	class { '::mysql::client':}
	mysql::db { $drupal_database :
		user     => $drupal_user,
		password => $drupal_user_password,
		host     => 'localhost',
		grant    => ['ALL'],
		charset  => 'utf8',
		collate  => 'utf8_general_ci',
	}
}
