#
#  Be sure to run `pod spec lint JavaShopBaseEngine.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "JavaShopBaseEngine"
  s.version      = "0.1.2"
  s.summary      = "JavaShop Basic dynamic dependency Library."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  # s.description  = <<-DESC
  

  s.homepage     = "https://github.com/YuMengShuaii/JavaShopBaseEngine/"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "yumengshuai" => "yumengshuai@gmail.com" }
  # Or just: s.author    = "yumengshuai"
  # s.authors            = { "yumengshuai" => "yumengshuai@gmail.com" }
  # s.social_media_url   = "http://twitter.com/yumengshuai"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
    s.platform     = :ios, "9.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/YuMengShuaii/JavaShopBaseEngine.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "SourceFile/**/*.swift"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

   s.resource  = "Resources/ImageResource.bundle"
  # s.resources = "Resources/*.{png}"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  s.frameworks = "Foundation","UIKit","AudioToolbox"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

    s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
    s.dependency "Action", "~> 3.2.0"
    s.dependency "Alamofire","~>4.5.1"
    s.dependency "Moya","~>9.0.0"
    s.dependency "Moya/RxSwift","~>9.0.0"
    s.dependency "Then","~>2.2.0"
    s.dependency "SwiftDate","~>4.3.0"
    s.dependency "SnapKit","~>3.2.0"
    s.dependency "Kingfisher","~>3.13.1"
    s.dependency "PermissionScope","~>1.1.1"
    s.dependency "RxSwift","~>3.6.1"
    s.dependency "RxCocoa","~>3.6.1"
    s.dependency "RxDataSources","~>2.0.2"
    s.dependency "ImageViewer","~>4.1.0"
    s.dependency "HandyJSON","~>1.8.0"
    s.dependency "NoticeBar","~>0.1.5"
    s.dependency "RealmSwift","~>2.10.1"
    s.dependency "EZSwiftExtensions","~>1.11.0"
    s.dependency "Reusable","~>4.0.0"
    s.dependency "RxOptional","~>3.2.0"
    s.dependency "SwiftWebVC","~>0.4.1"
    s.dependency "SideMenu","~>3.0.1"
    s.dependency "SwiftyBeaver","~>1.4.1"
    s.dependency "NSObject+Rx","~>3.0.0"
    s.dependency "TangramKit","1.1.6"
    s.dependency "RAMAnimatedTabBarController","~>2.2.3"
    s.dependency "HMSegmentedControl","~>1.5.2"

end
