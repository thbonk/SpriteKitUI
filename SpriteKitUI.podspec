Pod::Spec.new do |spec|
    spec.name         = 'FrameworkTemplate'
    spec.version      = '1'
    spec.osx.deployment_target = "10.13"
    spec.ios.deployment_target = "11.0"
    spec.tvos.deployment_target = "11.0"
    spec.summary      = 'Platform indpenedent UI Framework for SpriteKit applications'
    spec.author       = 'Thomas Bonk'
    spec.homepage     = 'https://github.com/thbonk/SpriteKitUI'
    spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
    spec.source       = { :git => 'https://github.com/thbonk/SpriteKitUI.git', :tag => 'v1' }
    spec.source_files = 'Sources/*.swift'
    spec.social_media_url = 'https://twitter.com/thbonk'
end
