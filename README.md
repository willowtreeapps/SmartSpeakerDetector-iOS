# SmartSpeakerDetector

[![CI Status](https://img.shields.io/travis/willowtreeapps/SmartSpeakerDetector.svg?style=flat)](https://travis-ci.org/willowtreeapps/SmartSpeakerDetector)
[![Version](https://img.shields.io/cocoapods/v/SmartSpeakerDetector.svg?style=flat)](https://cocoapods.org/pods/SmartSpeakerDetector)
[![License](https://img.shields.io/cocoapods/l/SmartSpeakerDetector.svg?style=flat)](https://cocoapods.org/pods/SmartSpeakerDetector)
[![Platform](https://img.shields.io/cocoapods/p/SmartSpeakerDetector.svg?style=flat)](https://cocoapods.org/pods/SmartSpeakerDetector)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Features

Library to detect smart speaker devices on local network. 

Library is using mDNS lookup to find Google Home devices on the local network. Since Google Home uses Cast SDK, detection should be reliable. 
Amazon Alexa support is coming up soon.

## Usage

Create an instance of `SmartSpeakerDetector` and call `detectGoogleHome` on it. This function takes a closure of type `Bool -> Void` which return `true` or `false` based on search result.

```let detector = SmartSpeakerDetector()
detector.detectGoogleHome { success in
    if success {
        // do something
        } else {
        // do something else
    }
}
```

`SmartSpeakerDetector` also provides logger functionally for debugging though the `SmartSpeakerDetectorLogger` protocol which sends all detection progress events. In the example project you may tap bug button in the top right corner to check the current detection status.

```class MyClass: SmartSpeakerDetectorLogger {
    let detector = SmartSpeakerDetector()
    
    func func log(event: String) {
        print(event)
    }
}
```

## Requirements

iOS 10.0 or later

## Installation

#### [CocoaPods](https://cocoapods.org):
Simply add the following line to your Podfile:

```ruby
pod 'SmartSpeakerDetector'
```

#### Carthage
Add the following to your project's Cartfile:

```github "cbpowell/MarqueeLabel"
```

## License

SmartSpeakerDetector is available under the Apache license. See the LICENSE file for more info.
