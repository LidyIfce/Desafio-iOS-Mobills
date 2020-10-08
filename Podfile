# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DesafioIosMobils' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end

	
  # Pods for DesafioIosMobils
	pod 'Firebase/Analytics'
	pod 'Firebase/Core'
	pod 'Firebase/Database'
	pod 'Firebase/Storage'
	pod 'Firebase/Auth'


end
