//
//  PollPanel.h
//  Educlick
//
//  Created by Benjamin Hsu on 9/7/13.
//  Copyright (c) 2013 BAGA. All rights reserved.
//

#import "UAModalPanel.h"
#import "Poll.h"

@protocol PollMultChoiceDelegate;

@interface PollMultChoicePanel : UAModalPanel <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *aButton;
@property (nonatomic, strong) UIButton *bButton;
@property (nonatomic, strong) UIButton *cButton;
@property (nonatomic, strong) UIButton *dButton;
@property (nonatomic, strong) UIButton *eButton;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) Poll *poll;

@property (nonatomic, weak) id<PollMultChoiceDelegate> delegate2;

@end

@protocol PollMultChoiceDelegate <NSObject>

- (void) answerChoiceWasSelected: (NSString *) answerChoice ofPoll: (Poll*) poll;

@end