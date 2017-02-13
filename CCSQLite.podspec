Pod::Spec.new do |s|
  s.name = 'CCSQLite'
  s.version = '1.0.0'
  s.summary = 'A Cocoa / Objective-C wrapper around SQLite. YapDatabase(key/value store) + FMDB (ARC)'
  s.homepage = 'https://github.com/ccworld1000/CCSQLite'
  s.license = 'MIT'
  s.author = { 'CC' => 'ccworld1000@gmail.com' }
  s.source = { :git => 'https://github.com/ccworld1000/CCSQLite.git', :tag => "#{s.version}" }
  s.requires_arc = true
  s.default_subspec = 'standard'  

  # use the built-in library version of sqlite3
  s.subspec 'standard' do |ss|
    ss.library = 'sqlite3'
    ss.source_files = 'CCSQLite/*.{h,m}'
  end

  # use the built-in library version of sqlite3 with custom FTS tokenizer source files
  s.subspec 'FTS' do |ss|
    ss.source_files = 'src/extra/fts3/*.{h,m}'
    ss.dependency 'CCSQLite/standard'
  end

  # build the latest stable version of sqlite3
  s.subspec 'standalone' do |ss|
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DFMDB_SQLITE_STANDALONE' }
    ss.dependency 'sqlite3'
    ss.source_files = 'CCSQLite/CC*.{h,m}'
  end

  # build with FTS support and custom FTS tokenizer source files
  s.subspec 'standalone-fts' do |ss|
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DFMDB_SQLITE_STANDALONE' }
    ss.source_files = 'CCSQLite/CC*.{h,m}', 'src/extra/fts3/*.{h,m}'
    ss.dependency 'sqlite3/fts'
  end

  # use SQLCipher and enable -DSQLITE_HAS_CODEC flag
  s.subspec 'SQLCipher' do |ss|
    ss.dependency 'SQLCipher'
    ss.source_files = 'CCSQLite/CC*.{h,m}'
    ss.xcconfig = { 'OTHER_CFLAGS' => '$(inherited) -DSQLITE_HAS_CODEC -DHAVE_USLEEP=1' }
  end
  
end
