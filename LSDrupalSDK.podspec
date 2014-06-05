Pod::Spec.new do |s|
  s.name             = "LSDrupalSDK"
  s.version          = File.read('VERSION')
  s.summary          = "Drupal 8 iOS SDK"
  s.description      = <<-DESC
			#Drupal 8 iOS SDK
                       DESC
  s.homepage         = "http://drupalsdk.com"
  s.license          = 'MIT'
  s.author           = { "Oleg Stasula" => "oleg.stasula@lemberg.co.uk" }
  s.source           = { :git => "https://github.com/lemberg/d8iossdk.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.dependency 'AFNetworking', '~> 2.0'
end
