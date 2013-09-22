//
//  DJSongRequestViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeeJay.h"
#import "QuestionPanel.h"

@interface DJSongRequestViewController : UIViewController <QuestionPanelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *SongRequestTableOutlet;
@property DeeJay *chosenDJ;

@end
