//
//  DJSignUpViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJSignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *RealNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *DJNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *LocationTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
- (IBAction)SignUpButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *djNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;


@end
