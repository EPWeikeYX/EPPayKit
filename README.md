# EPPayKit

[![CI Status](https://img.shields.io/travis/陈家宏/EPPayKit.svg?style=flat)](https://travis-ci.org/陈家宏/EPPayKit)
[![Version](https://img.shields.io/cocoapods/v/EPPayKit.svg?style=flat)](https://cocoapods.org/pods/EPPayKit)
[![License](https://img.shields.io/cocoapods/l/EPPayKit.svg?style=flat)](https://cocoapods.org/pods/EPPayKit)
[![Platform](https://img.shields.io/cocoapods/p/EPPayKit.svg?style=flat)](https://cocoapods.org/pods/EPPayKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
项目AppDelegate类命名不能加前缀，应为AppDelegate.h

## Installation

EPPayKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EPPayKit'
```

info.plist 添加


```
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>alipay</string>
		<string>weixin</string>
        <string>uppaysdk</string>
        <string>uppaywallet</string>
        <string>uppayx1</string>
        <string>uppayx2</string>
        <string>uppayx3</string>
	</array>
	
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>alipayscheme</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>paydemo</string><!--app自定义scheme-->
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>weixin</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>wxcaaeff7537392b0c</string><!--weixin的wx+appkey->
			</array>
		</dict>
	</array>

```
## Author

陈家宏, 197778537@qq.com

## License

EPPayKit is available under the MIT license. See the LICENSE file for more info.
