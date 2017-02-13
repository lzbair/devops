# Class: class vagrant_default_classes
# 
class vagrant_default_classes {

  class { 'base' :
    reboot_after_patching => false,
    is_puppetmaster       => false,
    enable_mcollective    => false,
  }

}

node 'rampuplab.nespresso.com' {
  include vagrant_default_classes
  include rampuplab
  class {'rampuplab': } 
}
