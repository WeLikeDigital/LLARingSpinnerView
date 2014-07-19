# LLARingSpinnerView

LLARingSpinnerView is a deligthful spinner for diplaying indeterminate progress that you can use in your apps.

- Simple API
- Respects interface tint color
- Automatically dims the tint color when an alert view or an action sheet is presented
- iOS7 compatible

## Example

![Screenshot](http://i.imgur.com/LboRSet.png)

Open up the included Xcode project for an example app.

## Usage

``` objc
// Initialize the progress view
LLARingSpinnerView *spinnerView = [[LLARingSpinnerView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];

// Optionally set the current progress
spinnerView.lineWidth = 1.5f;

// Optionally change the tint color
spinnerView.tintColor = [UIColor redColor];

// Add it as a subview
[self.view addSubview:spinnerView];

...

// Spin it
[spinnerView startAnimating];

// Stop animation
[spinnerView stopAnimating];
```

See the [header file](LLARingSpinnerView/LLARingSpinnerView.h) for full documentation.

## Installation

[CocoaPods](http://cocoapods.org) is the recommended method of installing LLARingSpinnerView. Simply add the following line to your `Podfile`:

#### Podfile

```ruby
pod 'LLARingSpinnerView'
```

Otherwise you can just add `LLARingSpinnerView.h` and `LLARingSpinnerView.m` to your project.

## Requirements

LLARingSpinnerView is tested on iOS7 and requires ARC.

## Contact

Lukas Lipka

- http://github.com/lipka
- http://twitter.com/lipec
- http://lukaslipka.com

## License

LLARingSpinnerView is available under the [MIT license](LICENSE). See the LICENSE file for more info.