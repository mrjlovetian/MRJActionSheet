# MRJActionSheet

[![CI Status](http://img.shields.io/travis/mrjlovetian@gmail.com/MRJActionSheet.svg?style=flat)](https://travis-ci.org/mrjlovetian@gmail.com/MRJActionSheet)
[![Version](https://img.shields.io/cocoapods/v/MRJActionSheet.svg?style=flat)](http://cocoapods.org/pods/MRJActionSheet)
[![License](https://img.shields.io/cocoapods/l/MRJActionSheet.svg?style=flat)](http://cocoapods.org/pods/MRJActionSheet)
[![Platform](https://img.shields.io/cocoapods/p/MRJActionSheet.svg?style=flat)](http://cocoapods.org/pods/MRJActionSheet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


```
MRJActionSheet *sheet = [[MRJActionSheet alloc] initWithTitle:@"标题" buttonTitles:@[@"第一", @"第二", @"第三", @"第四"] redButtonIndex:-1 defColor:nil actionSheetClickBlock:^(MRJActionSheet *actionSheet, int buttonIndex) {
    }];
    [sheet show];
```

![](actionSheet.png)

## Installation

MRJActionSheet is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MRJActionSheet'
```

## Author

mrjlovetian@gmail.com, mrjyuhongjiang@gmail.com

## License

MRJActionSheet is available under the MIT license. See the LICENSE file for more info.
# MRJActionSheet


