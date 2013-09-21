//
//  UserSongsRequestedViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSongsRequestedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *UserSongRequestedTableOutlet;
- (IBAction)RequestNewSongButtonPressed:(id)sender;

@end
