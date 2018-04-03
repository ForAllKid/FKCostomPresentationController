# FKCostomPresentationController

### Decription

A custom PresentationController for iOS platform

### Features

- easy to use

### How to use:


See Demo Project

```

- (IBAction)normalPresent:(UIButton *)sender {

    NextViewController *controller = [NextViewController new];
    
    [self customDirectionalPresentViewController:controller animated:YES];
    
}

- (IBAction)RoundPresent:(UIButton *)sender {

    CGFloat corner = [self.textField.text floatValue];
    
    NextViewController *controller = [NextViewController new];
    
    [self customDirectionalPresentViewController:controller cornerRadius:corner animated:YES];
    
}

- (IBAction)fadePresent:(UIButton *)sender {
    
    NextViewController *controller = [NextViewController new];
    
    [self customFadedPresentViewController:controller animated:YES];
    
}

```

### Installation

```
pod 'FKCustomPresentationController'

```

### Requirements

```
iOS8 or later
```

### License

FKCustomPresentationController is available under the MIT license. See the LICENSE file for more info.
