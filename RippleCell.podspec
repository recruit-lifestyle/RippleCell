#
# Be sure to run `pod lib lint RippleCell.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RippleCell"
  s.version          = "0.1.0"
  s.summary          = "Swift subclass of the UITableViewCell."

  s.description      = <<-DESC
                      * show ripple effects on you tapped.
                      * swift subclass of the UITableViewCell.
                       DESC

  s.homepage         = "https://github.com/recruit-lifestyle/RippleCell"
  s.license          = 'MIT'
  s.author           = { "NariFrow" => "na.ju.rights@gmail.com" }
  s.source           = { :git => "https://github.com/recruit-lifestyle/RippleCell.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Fye_design'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'RippleCell' => ['Pod/Assets/*.png']
  }

end
