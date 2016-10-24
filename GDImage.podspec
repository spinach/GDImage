Pod::Spec.new do |s|
  s.name         = "GDImage"
  s.version      = "1.0.2"
  s.summary      = "A Swift library for downloading images"
  s.description  = "A Swift library for downloading and caching images from the web"
  s.homepage     = "https://github.com/spinach/GDImage"
  s.license      = "MIT"
  s.author       = { "Guy Daher" => "guydaher1@gmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { git: "https://github.com/spinach/GDImage.git", :tag => "#{s.version}" }
  s.source_files = "GDImage", "GDImage/**/*.{h,m,swift}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
end
