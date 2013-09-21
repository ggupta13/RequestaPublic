//
//  UserRequestedSongsViewController.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRequestedSongsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *RequestSongButton;
- (IBAction)RequestNewSongAction:(id)sender;

@end
