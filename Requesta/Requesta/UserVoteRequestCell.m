//
//  UserVoteRequestCell.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "UserVoteRequestCell.h"

@implementation UserVoteRequestCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"UserVoteRequestCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)VoteArrowPressed:(id)sender {
    if(!self.hasBeenPressed)
    {
        self.hasBeenPressed = YES;
        [self.VoteArrow setBackgroundImage:[UIImage imageNamed: @"VoteArrowOrange.png"] forState: UIControlStateNormal];
        int currentVotes = [self.VoteCountTextField.text integerValue];
        currentVotes++;
        self.VoteCountTextField.text = [NSString stringWithFormat:@"%d",currentVotes];
    }
}
@end
