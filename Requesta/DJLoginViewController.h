//
//  DJLoginViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *UsernameTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

- (IBAction)LoginButtonPressed:(id)sender;
@end
