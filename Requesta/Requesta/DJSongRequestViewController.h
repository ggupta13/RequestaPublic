//
//  DJSongRequestViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeeJay.h"

@interface DJSongRequestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *SongRequestTableOutlet;
@property DeeJay *chosenDJ;

@end
