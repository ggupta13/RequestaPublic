//
//  Singleton.h
//  Requesta
//
//  Created by Gagan Gupta on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeeJay.h"

@interface Singleton : NSObject

+ (Singleton *)sharedInstance;
@property (nonatomic,retain) DeeJay *currentDeejay;
@property (nonatomic,retain) NSMutableArray *currRequestedSongs;

@end
