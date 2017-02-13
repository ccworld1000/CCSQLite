Pod::Spec.new do |s|
  s.name = 'CCSQLite'
  s.version = '1.0.0'
  s.summary = 'A Cocoa / Objective-C wrapper around SQLite. YapDatabase(key/value store) + FMDB (ARC)'
  s.homepage = 'https://github.com/ccworld1000/CCSQLite'
  s.license = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author = { 'CC' => 'ccworld1000@gmail.com' }
  s.source = { :git => 'https://github.com/ccworld1000/CCSQLite.git', :tag => "#{s.version}" }
  s.requires_arc = true
  s.default_subspec = 'standard'  
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  # use the built-in library version of sqlite3
  s.subspec 'standard' do |ss|
    ss.library = 'sqlite3'
    ss.source_files = 'CCSQLite/*.{h,m}'
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited)' }
  end

  # use SQLCipher and enable -DSQLITE_HAS_CODEC flag
  s.subspec 'SQLCipher' do |ss|
    ss.dependency 'SQLCipher'
    ss.source_files = 'CCSQLite/*.{h,m}'
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC -DHAVE_USLEEP=1' }
  end
  
end
