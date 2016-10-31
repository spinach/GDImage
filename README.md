# GDImage

GDImage is a Swift library providing background image-loading capabilities.

## Features

- [x] Asnychronous image downloading
- [x] Two-layer caching: memory and disk
- [x] UIImage extensions offered
- [x] Support for download cancellation 
- [x] Support for jpeg and png images tested

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

> CocoaPods 1.1.0+ is required.

To integrate GDImage into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'GDImage', :git => 'https://github.com/spinach/GDImage', :tag => '1.0.6'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage


To integrate GDImage into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "spinach/GDImage"
```

Run `carthage update` to build the framework and drag the built `GDImage.framework` into your Xcode project.


## Usage

### QuickStart

The simplest way to use GDImage is using UIImageView extension

```swift
import GDImage

imageView.setImage(withLink: "https://s3.amazonaws.com/dummy-images-guy/algolia-logo.jpg")
```
GDImage will download the image asynchronously, put it in the memory cache and disk cache, and then display it in `imageView`.

### Demo
You can quickly try out the library by cloning this repo and opening `GDImage.xcworkspace`. Build the `GDImage` target, then run the `Demo` target.

### UIImageView Extension Methods

- `func setImage(withUrl: URL)`
- `func setImage(withLink: String)`
- `func cancelImageDownload()`

### GDImage Methods

GDImage offers more customisation.

```swift
import GDImage

let gdImage = GDImage()
gdImage.setImage(ofImageView: imageView, withUrl: url)

```
The constructor lets you customise whether to use caching or not, the contentMode of the UIImageView and the activityIndicatorStyle shown while loading the image.

`GDImage(useCacheStore:Bool = true, contentMode: UIViewContentMode = .scaleAspectFit, activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray)`

The methods for GDImage are similar to the ones of extensions of UIImageView

- `func setImage(ofImageView: UIImageView, withUrl: URL)`
- `func setImage(ofImageView: UIImageView, withLink: String)`
- `func cancelDownload(ofImageView: UIImageView)`

### Completion Handler
If you wish to do some task at the completion of an image download, or do error handling, you can use the optional argument `completionHandler` like this:

```swift
imageView.setImage(withUrl: url) { (image, error) in
    // use error to do error handling
    // use image to do something with the image
}

```

## TODOs
- [x] Create workspace containing Demo and Library
- [x] Write to Store Asynchronously
- [x] Manutally test with more image formats
- [x] Add default ActivityIndicator while loading image
- [x] Support for Carthage
- [x] More cleanup, especially print statements
- [x] Handle error cases (when image cannot be found). Can offer an errorHandler in the method
- [x] Provide onCompleteHandler
- Write tests
- Improve the Demo project
- Prefetch image capabilities
- Provide placeholer image capabilities
- Submit public pod

## License

GDImage is released under the MIT license. See LICENSE for details.
