# GDImage

GDImage is a Swift library providing background image-loading capabilities.

## Features

- [x] Asnychronous image downloading
- [x] Two-layer caching: memory and disk
- [x] UIImage extensions offered
- [x] Support for download cancellation 
- [x] Support for jpeg images 

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required.

To integrate GDImage into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'GDImage', :git => 'https://github.com/spinach/GDImage', :tag => '1.0.3'
end
```

Then, run the following command:

```bash
$ pod install
```


## Usage

### QuickStart

The simplest way to use GDImage is using UIImageView extension

```swift
import GDImage

imageView.setImage(withUrl: url)
```
GDImage will download the image asynchronously from `url`, puts it in the memory cache and disk cache, and then displays it in `imageView`.

### Demo
You can quickly try out the library by cloning this repo and opening the Demo project. At the root of the Demo project, run `pod install` and then run the project.

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
The constructor lets you customise whether to use caching or not, and the contentMode of the UIImageView

`GDImage(useCacheStore:Bool = true, contentMode: UIViewContentMode = .scaleAspectFit)`

The methods for GDImage are similar to the ones of extensions of UIImageView

- `func setImage(ofImageView: UIImageView, withUrl: URL)`
- `func setImage(ofImageView: UIImageView, withLink: String)`
- `func cancelDownload(ofImageView: UIImageView)`

## TODOs
- Handle error cases (when image cannot be found). Can offer an errorHandler in the method
- Provide onCompleteHandler
- Support more image formats
- Write tests
- Provide placeholer image capabilities
- Submit public pod
- More cleanup, especially print statements
- Improve the Demo project

## License

GDImage is released under the MIT license. See LICENSE for details.
