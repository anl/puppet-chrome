class google-chrome {

  # Assumes definition elsewhere of an Exec["apt-get update"]
  file { "/etc/apt/sources.list.d/google-chrome.list":
    owner => "root",
    group => "root",
    mode => 444,
    source => "puppet:///google-chrome/google-chrome.list",
    notify => [ Exec["apt-get update"],
                Exec["Google apt-key"], ],
  }

  ## Exec["apt-get update"] could be something like:
  # exec { "apt-get update":
  #   command => "/usr/bin/apt-get update",
  #   refreshonly => true,
  # }
  
  # Add Google's apt-key:
  exec { "Google apt-key":
    command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xfbef0d696de1c72ba5a835fe5a9bf3bb4e5e17b5",
    refreshonly => true,
  }

  package { "google-chrome-beta":
    ensure => latest,
    require => [ File["/etc/apt/sources.list.d/google-chrome.list"],
                 Exec["Google apt-key"] ],
  }
  
}
                                
