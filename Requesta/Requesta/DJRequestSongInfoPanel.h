//
//  DJRequestSongInfoPanel.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "QuestionPanel.h"

@interface DJRequestSongInfoPanel : QuestionPanel
@property (nonatomic, strong) UITextView *tempo;
@property (nonatomic, strong) UITextView *hotttness;
@property (nonatomic, strong) UITextView *danceability;
@property (nonatomic, strong) UITextView *duration;
@property (nonatomic, strong) UITextView *energy;
@property (nonatomic, strong) UITextView *loudness;
@property (nonatomic, strong) UITextView *votes;
@end


