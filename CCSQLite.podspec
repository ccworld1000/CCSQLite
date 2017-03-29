Pod::Spec.new do |s|
  s.name = 'CCSQLite'
  s.version = '1.2.1'
  s.summary = '
A Cocoa / Objective-C wrapper around SQLite. YapDatabase(key/value store) + FMDB (ARC),
CCKeyValue can replace NSUserDefaults or simple data type or key value type [Lightweight data] [Lightweight cache]. 
CCSQLite 支持 iOS与OSX (Objective-C 封装的SQLite. 结合YapDatabase(key/value store) + FMDB (ARC)),
CCKeyValue可替换NSUserDefaults 或 简单数据类型 或 键值类型 [轻量级数据] [轻量级缓存].'
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
