//
//  DJLoginViewController.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "DJLoginViewController.h"

@interface DJLoginViewController ()

@end

@implementation DJLoginViewController

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
    self.UsernameTextFieldOutlet.font = euro;
    self.passwordTextFieldOutlet.font = euro;
    self.usernameLabel.font = euro;
    self.passwordLabel.font = euro;
    self.loginButton.titleLabel.font = euro;
    self.signUpButton.titleLabel.font = euro;
    self.areYouDJLabel.font = euro;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButtonPressed:(id)sender
{
    NSLog(@"here");
}
@end
