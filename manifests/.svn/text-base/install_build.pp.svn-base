class drupal::site { 
  $host = 'ncssd.localhost'
  $db ='ncssd_stage'
  $drupal_password = "^|*N:6!y!&bq$3/I"
  $db_user = "Eu78g74t3055jP7j"
  $sql_file = 'puppet:///sites/ncssd_stage.sql'
/*  
  file { '/etc/httpd/conf.d/$host.conf':
    source => 'puppet:///sites/$host.conf',
    notify => Service["httpd"]
  }
*/  
  exec { 'create-$db_user':
    command => '/usr/bin/mysql -u root -p$root_password -e \"CREATE USER $db_user;"',
  }
  exec { 'create-$host-db':
    command => '/usr/bin/mysql -u root -p$root_password -e "CREATE DATABASE $db; GRANT ALL ON $db.* to $db_user@localhost identified by \"$drupal_password";"',
  }
  exec { 'reload-$sql_file':
    command => '/usr/bin/mysql -u root -p $root_password $db < $sql_file',
  }
}

include drupal::site
