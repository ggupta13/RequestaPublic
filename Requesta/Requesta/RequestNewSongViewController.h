//
//  RequestNewSongViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestNewSongViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *SearchTextField;
@property (weak, nonatomic) IBOutlet UIButton *SearchButton;
- (IBAction)Search:(id)sender;

@end
