//
//  DJSignUpViewController.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "DJSignUpViewController.h"

@interface DJSignUpViewController ()

@end

@implementation DJSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIFont *euro = [UIFont fontWithName:@"Eurostile" size:18.0f];
    self.RealNameTextField.font = euro;
    self.DJNameTextField.font = euro;
    self.LocationTextField.font = euro;
    self.PasswordTextField.font = euro;
    self.realnameLabel.font = euro;
    self.djNameLabel.font=euro;
    self.locationLabel.font = euro;
    self.passwordLabel.font = euro;
    self.signupButton.font = euro;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUpButtonPressed:(id)sender {
}
@end
