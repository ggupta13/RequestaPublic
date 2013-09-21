//
//  PollPanel.m
//  Educlick
//
//  Created by Benjamin Hsu on 9/7/13.
//  Copyright (c) 2013 BAGA. All rights reserved.
//

#import "PollMultChoicePanel.h"

@implementation PollMultChoicePanel
{
    NSMutableArray *answerChoices;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UILabel *pollStaticTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 240, 40)];
        [pollStaticTextLabel setText:@"Choose your answer: "];
        [pollStaticTextLabel setTextColor:[UIColor whiteColor]];
        [pollStaticTextLabel setBackgroundColor:[UIColor clearColor]];
        [pollStaticTextLabel setFont:[UIFont fontWithName:@"Futura" size:20.0f]];
        [self addSubview:pollStaticTextLabel];
        
        
        answerChoices = [[NSMutableArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E", nil];
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(40, 60, 240, 300)];
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
        
        
    }
    return self;
}
#pragma mark - UITableViewDelegate/DataSource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [answerChoices objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Futura" size:20.0f]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return answerChoices.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"checking if responds...");
    if([self.delegate2 respondsToSelector:@selector(answerChoiceWasSelected:ofPoll:)])
    {
        NSLog(@"it responds");
        [self.delegate2 answerChoiceWasSelected:[answerChoices objectAtIndex:indexPath.row] ofPoll:self.poll];
    }
    
    [self.closeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}
//- (void) buttonPressed: (UIButton *) sender
//{
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
