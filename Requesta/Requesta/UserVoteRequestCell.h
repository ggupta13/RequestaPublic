//
//  UserVoteRequestCell.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserVoteRequestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *SongTitleTextField;
@property  (nonatomic) BOOL 
hasBeenPressed;
@property (weak, nonatomic) IBOutlet UILabel *ArtistTextField;
@property (weak, nonatomic) IBOutlet UILabel *VoteCountTextField;
@property (weak, nonatomic) IBOutlet UIButton *VoteArrow;

- (IBAction)VoteArrowPressed:(id)sender;

@end
