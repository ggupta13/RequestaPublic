//
//  QuestionPanel.h
//  Educlick
//
//  Created by Benjamin Hsu on 9/7/13.
//  Copyright (c) 2013 BAGA. All rights reserved.
//

#import "UAModalPanel.h"
#import "Song.h"

@protocol QuestionPanelDelegate;

@interface QuestionPanel : UAModalPanel

@property (nonatomic, strong) UITextView *songTitle;
@property (nonatomic, strong) UITextView *songArtist;
@property (nonatomic, strong) Song *song;
@property (nonatomic, strong) NSString *djNickname;
@property (nonatomic, strong) NSString *djRealName;
@property (nonatomic, strong) UIButton *requestButton;



@property (nonatomic, weak) id<QuestionPanelDelegate> delegate2;

@end

@protocol QuestionPanelDelegate <NSObject>

- (void) sendRequestForSong:(Song *)song nickname:(NSString *)nickname realName:(NSString *)realName;

@end