//
//  DJRequestSongInfoPanel.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "DJRequestSongInfoPanel.h"

@implementation DJRequestSongInfoPanel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.votes = [[UITextView alloc] initWithFrame:CGRectMake(30, 110, 250, 70)];
        [self addSubview:self.votes];
        [self.votes setBackgroundColor:[UIColor clearColor]];
        self.votes.textAlignment = NSTextAlignmentLeft;
        [self.votes setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.votes setTextColor:[UIColor whiteColor]];
        
        self.tempo = [[UITextView alloc] initWithFrame:CGRectMake(30, 140, 250, 70)];
        [self addSubview:self.tempo];
        [self.tempo setBackgroundColor:[UIColor clearColor]];
        self.tempo.textAlignment = NSTextAlignmentLeft;
        [self.tempo setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.tempo setTextColor:[UIColor whiteColor]];
        
        self.danceability = [[UITextView alloc] initWithFrame:CGRectMake(30, 170, 250, 70)];
        [self addSubview:self.danceability];
        [self.danceability setBackgroundColor:[UIColor clearColor]];
        self.danceability.textAlignment = NSTextAlignmentLeft;
        [self.danceability setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.danceability setTextColor:[UIColor whiteColor]];
        
        self.danceability = [[UITextView alloc] initWithFrame:CGRectMake(30, 170, 250, 70)];
        [self addSubview:self.danceability];
        [self.danceability setBackgroundColor:[UIColor clearColor]];
        self.danceability.textAlignment = NSTextAlignmentLeft;
        [self.danceability setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.danceability setTextColor:[UIColor whiteColor]];
        
        self.energy = [[UITextView alloc] initWithFrame:CGRectMake(30, 200, 250, 70)];
        [self addSubview:self.energy];
        [self.energy setBackgroundColor:[UIColor clearColor]];
        self.energy.textAlignment = NSTextAlignmentLeft;
        [self.energy setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.energy setTextColor:[UIColor whiteColor]];
        
        self.loudness = [[UITextView alloc] initWithFrame:CGRectMake(30, 230, 250, 70)];
        [self addSubview:self.loudness];
        [self.loudness setBackgroundColor:[UIColor clearColor]];
        self.loudness.textAlignment = NSTextAlignmentLeft;
        [self.loudness setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.loudness setTextColor:[UIColor whiteColor]];
        
        self.duration = [[UITextView alloc] initWithFrame:CGRectMake(30, 260, 250, 70)];
        [self addSubview:self.duration];
        [self.duration setBackgroundColor:[UIColor clearColor]];
        self.duration.textAlignment = NSTextAlignmentLeft;
        [self.duration setFont:[UIFont fontWithName:@"Eurostile" size:18.0f]];
        [self.duration setTextColor:[UIColor whiteColor]];

    }
    
    
    
    
    
    
    
    return self;
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
