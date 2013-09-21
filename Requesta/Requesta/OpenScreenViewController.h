//
//  OpenScreenViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *SelectDJTableViewOutlet;
- (IBAction)DJSignInButtonPressed:(id)sender;

@property NSMutableArray *listOfDJs;

@end
