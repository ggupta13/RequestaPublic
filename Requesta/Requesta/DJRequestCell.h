//
//  DJRequestCell.h
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJRequestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *SongTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *ArtistTextField;
@property (weak, nonatomic) IBOutlet UILabel *BPMTextField;
@property (weak, nonatomic) IBOutlet UILabel *BPMDigitsTextField;

@end
