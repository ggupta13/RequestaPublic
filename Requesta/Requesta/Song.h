//
//  Song.h
//  Requesta
//
//  Created by Gagan Gupta on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property NSString *album;
@property NSString *artist;
@property NSString *songName;
@property double danceability;
@property double duration;
@property double energy;
@property double key;
@property double loudness;
@property double tempo;
@property NSUInteger votes;


@end
