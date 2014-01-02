class drupal_db (
	$drupal_user = drupal,
	$drupal_user_password = drupal,
	$drupal_database = drupal,
	$root_db_pwd = 'interactivedatabase',
	$backup_db = true,
        )
	{
	/*
         * Extention of the Puppet Labs MySQL Puppet Module.
        */
	class { '::mysql::server':
		root_password => $root_db_pwd,
	}
	
	case $backup_db {
		true: {
			class { '::mysql::server::backup':
				backupuser     => vagrant,
				backuppassword => 'vagrant',
				backupdir      => '/vagrant/_docs/',
				backuprotate   => 10,
				file_per_database => true,
			}
		}
	}
	
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
