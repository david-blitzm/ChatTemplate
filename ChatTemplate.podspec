Pod::Spec.new do |s|
  s.name         = 'ChatTemplate'
  s.version      = '0.0.1'
  s.license      = 'Apache License, Version 2.0'
  s.homepage     = 'git@gitlab.boris.blitzm.systems:jet/jet-ios-sdk'
  s.authors      = 'Blitzm Systems Pty Ltd': 'support@blitzm.com'
  s.summary      = 'Chat View Template'

  s.platform     =  :ios, '7.0'
  s.source       =  { :git => "git@gitlab.boris.blitzm.systems:jet/jet-ios-sdk.git", :tag => "v#{s.version}" }
  s.source_files = 'ChatTemplte/**/*.{m, h}'
  s.public_header_files = 'ChatTemplte/**/*.h'
  s.resource_bundles = {
    'ChatTemplate' => ['ChatTemplte/*.xib'],
  }
  s.frameworks   =  'SystemConfiguration'
  s.requires_arc = true
  
# Pod Dependencies

end
