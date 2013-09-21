//
//  DJSignUpViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextFieldOutlet;
- (IBAction)SignInButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SignUpButtonPressed;

- (IBAction)SignUpButtonPressed:(id)sender;
@end
