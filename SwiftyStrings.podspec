Pod::Spec.new do |s|
  s.name             = 'SwiftyStrings'
  s.version          = '0.1.5'
  s.summary          = 'SwiftyStrings is simple string manipulation extenson for Swift.'
  s.description      = <<-DESC
SwiftyStrings is simple string manipulation extenson for Swift. The purpose of this library is to translate useful PHP string methods to Swift. This library is helpful because the Swift API to manipulate strings is complicated and difficult to use when working with string parsing or manipulation projects. 
                       DESC

  s.homepage         = 'https://github.com/adle29/SwiftyStrings'
  s.license          = 'MIT'
  s.author           = { 'Abraham Adberstein' => 'abraham.adberstein@gmail.com' }
  s.source           = { :git => 'https://github.com/adle29/SwiftyStrings.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pod/Classes/**/*'
  
end
