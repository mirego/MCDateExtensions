Pod::Spec.new do |s|
  s.name     = 'MCDateExtensions'
  s.version  = '0.1.2'
  s.license  = 'BSD 3-Clause'
  s.summary  = 'Extensions on the dates classes.'
  s.homepage = 'https://github.com/mirego/MCDateExtensions.iOS'
  s.authors  = { 'Mirego, Inc.' => 'info@mirego.com' }
  s.source   = { :git => 'https://github.com/mirego/MCDateExtensions.iOS.git', :tag => s.version.to_s }
  s.source_files = 'MCDateExtensions/*.{h,m}'
  s.requires_arc = true
  
  s.platform = :ios, '5.0'
end