class google-chrome {

  file { "/etc/apt/sources.list.d/google-chrome.list":
    owner => "root",
    group => "root",
    mode => 444,
    source => "puppet:///google-chrome/google-chrome.list",
    notify => [ Exec["/usr/bin/apt-get update"],
                Exec["Google apt-key"], ],
  }
  
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
                                
