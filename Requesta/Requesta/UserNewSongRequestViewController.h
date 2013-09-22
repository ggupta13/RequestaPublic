//
//  UserNewSongRequestViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionPanel.h"

@interface UserNewSongRequestViewController : UIViewController <QuestionPanelDelegate>

@property (weak, nonatomic) IBOutlet UITextField *MusicSearchTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UITableView *SearchResultTableOutlet;
- (IBAction)SearchButtonPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property NSMutableArray *searchResults;

@end
