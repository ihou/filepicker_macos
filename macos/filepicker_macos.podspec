#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint filepicker_macos.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'filepicker_macos'
  s.version          = '0.0.1'
  s.summary          = 'filepicker_macos'
  s.description      = <<-DESC
filepicker_macos
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
