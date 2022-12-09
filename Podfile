# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'Starter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'SwiftLint'
  
  pod 'SwiftGen', '~> 6.0'
  
  pod 'Reusable'
  
  pod 'RxSwift'
  
  pod 'RxCocoa'
  
  pod 'GRDB.swift'

  pod 'RxGRDB'
  
  pod 'Alamofire'
  
  target 'StarterTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'StarterUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = '12.0'
    end
  end
end
