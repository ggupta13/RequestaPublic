//
//  Singleton.m
//  Requesta
//
//  Created by Gagan Gupta on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (Singleton *)sharedInstance
{
    static Singleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Singleton alloc] init];
        
        // Do any other initialization stuff here
        
    });
    return sharedInstance;
}

@end
