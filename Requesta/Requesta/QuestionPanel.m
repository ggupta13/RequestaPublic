//
//  QuestionPanel.m
//  Educlick
//
//  Created by Benjamin Hsu on 9/7/13.
//  Copyright (c) 2013 BAGA. All rights reserved.
//

#import "QuestionPanel.h"

@implementation QuestionPanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.songTitle = [[UITextView alloc] initWithFrame:CGRectMake(40, 35, 240, 50)];
        [self addSubview:self.songTitle];
        [self.songTitle setBackgroundColor:[UIColor clearColor]];
        self.songTitle.textAlignment = NSTextAlignmentCenter;
        [self.songTitle setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.songTitle setTextColor:[UIColor whiteColor]];
        
        self.songArtist = [[UITextView alloc] initWithFrame:CGRectMake(40, 75, 240, 110)];
        [self addSubview:self.songArtist];
        [self.songArtist setBackgroundColor:[UIColor clearColor]];
        self.songArtist.textAlignment = NSTextAlignmentCenter;
        [self.songArtist setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.songArtist setTextColor:[UIColor whiteColor]];
        
        self.requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.requestButton setFrame:CGRectMake(70, 200, 180, 60)];
        [self.requestButton setBackgroundColor:[UIColor colorWithRed:44.0/255 green:172.0/255 blue:205.0/255 alpha:1.0f]];
        [self.requestButton.titleLabel setFont:[UIFont fontWithName:@"Eurostile" size:16.0f]];
        [self addSubview:self.requestButton];
        [self.requestButton setTitle:@"Request" forState:UIControlStateNormal];
        [self.requestButton addTarget:self action:@selector(requestPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void) requestPressed
{
    if([self.delegate2 respondsToSelector:@selector(sendRequestForSong:nickname:realName:)])
    {
        [self.delegate2 sendRequestForSong:self.song nickname:self.djNickname realName:self.djRealName];
        NSLog(@"here");
    }
    
    [self.closeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
