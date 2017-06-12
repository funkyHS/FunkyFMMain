Pod::Spec.new do |s|
  s.name             = 'FunkyFMMain'
  s.version          = '0.1.0'
  s.summary          = 'FunkyFMMain'


  s.description      = <<-DESC
FunkyFMMain是FM的主骨架，包括nav，tabbar等
                       DESC

  s.homepage         = 'https://github.com/funkyHS/FunkyFMMain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'funkyHS' => 'hs1024942667@163.com' }
  s.source           = { :git => 'https://github.com/funkyHS/FunkyFMMain.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'FunkyFMMain/Classes/**/*'
  
  s.resource_bundles = {
    'FunkyFMMain' => ['FunkyFMMain/Assets/*']
  }

  s.dependency 'FunkyFMBase/Category'

end
