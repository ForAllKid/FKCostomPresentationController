# FKCostomPresentationController

### ScreenShot

![image](https://github.com/ForAllKid/FKCostomPresentationController/blob/master/FKCustomPresentationControllerScrenShot.gif)

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

<br/>

> Download or clone to see more use~


### Note

If you want to present a view controller which is not full screen (like screenshot shown), you need set the controller's contentSize like 

```
    self.preferredContentSize = CGSizeMake(100.f, 100.f);

```

or override the function



```

- (CGSize)preferredContentSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(screenSize.width, screenSize.height/2.f);
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

### Next

will support gestureRecognizer control

### License

FKCustomPresentationController is available under the MIT license. See the LICENSE file for more info.
