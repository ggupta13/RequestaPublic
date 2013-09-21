//
//  UserNewSongRequestViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNewSongRequestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *MusicSearchTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UITableView *SearchResultTableOutlet;
- (IBAction)SearchButtonPressed:(id)sender;

@end
