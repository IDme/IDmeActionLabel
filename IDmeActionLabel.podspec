Pod::Spec.new do |s|
  s.name         = "IDmeActionLabel"
  s.version      = "1.0.0"
  s.summary      = "Adds Target-Action support for UILabel."
  s.homepage     = "https://github.com/IDme/IDmeActionLabel"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/ArtSabintsev/Harpy.git", :tag => "1.0.0" }
  s.source_files = 'IDmeActionLabel/*.{h,m}'
  s.author       = { "Arthur Ariel Sabintsev" => "arthur@sabintsev.com" }
  s.license      = 'MIT'
 end
