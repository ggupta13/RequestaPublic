//
//  RequestaAppDelegate.m
//  Requesta
//
//  Created by Gagan Gupta on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "RequestaAppDelegate.h"
#import <Firebase/Firebase.h>
#import "SIAlertView/SIAlertView.h"
#import "Song.h"

@implementation RequestaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    /*Firebase *f = [[Firebase alloc]initWithUrl:@"https://requesta.firebaseio.com/DJProfiles"];
    // Read data and react to changes
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
    }];*/
    
    Song *s = [[Song alloc]init];
    s.songName = @"Ashley";
    s.song_id = @"NOTREALIDBUTHASH";
    s.audio_md5 = @"NOTREALHASHBUTWILLBE";
    s.votes=0;
    s.artist=@"Big Sean";
    //[self requestSongForDJ:s nickname:@"Kid_Curi" realName:@"Yash Sharma"];
    //[self voteSong:s forDJNickname:@"Kid_Curi" realName:@"Yash Sharma"];
    
     //[self requestSongForDJ:s nickname:@"GaganG" realName:@"Jon Brelje"];
    
    return YES;
}

-(void)voteSong:(Song *)song forDJNickname:(NSString *)nickname realName:(NSString *)realName
{
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://requesta.firebaseio.com/DJProfiles"];
    
    
    __block BOOL alreadyRequested = NO;
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot)
     {
         //NSLog(alreadyRequested ? @"Yes" : @"No");
         if(!alreadyRequested)
         {
             BOOL found=NO;
             for(FDataSnapshot *child in snapshot.children)
             {
                 int count=0;
                 NSString *childNickname=@"",*childRealName=@"",*location=@"";
                 
                 NSString *currName = child.name;
                 for(FDataSnapshot *child2 in child.children)
                 {
                     if(count==0)
                         location=[child2.value description];
                     else if(count==1)
                         childNickname =[child2.value description];
                     else if(count==2)
                         childRealName=[child2.value description];
                     
                     count++;
                 }
                 if([nickname isEqualToString:childNickname] && [realName isEqualToString:childRealName])
                 {
                     found=YES;
                     NSLog(@"found DJ to vote song");
                     NSString *path = [NSString stringWithFormat:@"https://requesta.firebaseio.com/DJProfiles/%@/requestedSongs",currName];
                     Firebase *f2 = [[Firebase alloc]initWithUrl:path];
                     
                     __block BOOL already = NO;
                     
                     [f2 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshotx)
                      {
                          if(!already)
                          {
                              NSString *songName=@"",*songArtist=@"",*audio_md5=@"";
                              NSUInteger currVotes = 0;
                              for(FDataSnapshot *childd in snapshotx.children)
                              {
                                  //NSLog(@"should be a song: %@",childd.name);
                                  NSString *currSong = childd.name;
                                  int count2=0;
                                  for(FDataSnapshot *childd2 in childd.children)
                                  {
                                      if(count2==0)
                                          songArtist = [childd2.value description];
                                      else if(count2==1)
                                          audio_md5 = [childd2.value description];
                                      else if(count2==2)
                                          songName = [childd2.value description];
                                      else if(count2==4)
                                          currVotes = [childd2.value integerValue];
                                      
                                      count2++;
                                  }
                              
                              NSLog(@"%@ %@ %@",songArtist,audio_md5,songName);
                              
                                  if([song.artist isEqualToString:songArtist] &&
                                     [song.songName isEqualToString:songName] &&
                                     [song.audio_md5 isEqualToString:audio_md5])
                                  {
                                      NSLog(@"found the song!");
                                      NSString *path = [NSString stringWithFormat:@"https://requesta.firebaseio.com/DJProfiles/%@/requestedSongs/%@",currName,currSong];
                                      Firebase *f3 = [[Firebase alloc]initWithUrl:path];
                                      
                                      __block BOOL already2 = NO;
                                      
                                      [f3 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshotx2)
                                       {
                                           if(!already2)
                                           {
                                               [f3 updateChildValues:@{
                                                @"artist":song.artist,
                                                @"audio_md5":song.audio_md5,
                                                @"songName":song.songName,
                                                @"song_id":song.song_id,
                                                @"votes":[NSNumber numberWithInt:(currVotes +1)]
                                                }];
                                               
                                               already2=YES;
                                           }
                                           
                                       }];

                                  }
                                  
                              }
                              
                              
                              already=YES;
                          }
                      }];
                 }
             }
             if(!found)
             {
                 [RequestaAppDelegate showAlertViewWithTitle:@"Error" andText:@"DJ Not Found"];
             }
             
             alreadyRequested=YES;
         }
         
     }];

}

+ (void) showAlertViewWithTitle: (NSString *) title andText: (NSString *) text {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:text];
    
    
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              [alert dismissAnimated:YES];
                          }];
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
    };
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}

-(void)requestSongForDJ:(Song *)song nickname:(NSString *)nickname realName:(NSString *)realName
{
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://requesta.firebaseio.com/DJProfiles"];
    
    
    __block BOOL alreadyRequested = NO;
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot)
    {
        //NSLog(alreadyRequested ? @"Yes" : @"No");
        if(!alreadyRequested)
        {
            BOOL found=NO;
            for(FDataSnapshot *child in snapshot.children)
            {
                int count=0;
                NSString *childNickname=@"",*childRealName=@"",*location=@"";
                
                NSString *currName = child.name;
                for(FDataSnapshot *child2 in child.children)
                {
                    if(count==0)
                        location=[child2.value description];
                    else if(count==1)
                        childNickname =[child2.value description];
                    else if(count==2)
                        childRealName=[child2.value description];
                    
                    count++;
                }
                if([nickname isEqualToString:childNickname] && [realName isEqualToString:childRealName])
                {
                    found=YES;
                    NSLog(@"found DJ to request song");
                    NSString *path = [NSString stringWithFormat:@"https://requesta.firebaseio.com/DJProfiles/%@/requestedSongs",currName];
                    Firebase *f2 = [[Firebase alloc]initWithUrl:path];
                    
                    __block BOOL already = NO;
                    
                    [f2 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshotx)
                     {
                         if(!already)
                         {
                                [f2 updateChildValues:@{[NSString stringWithFormat:@"%i",snapshotx.childrenCount]:@{
                                 @"artist":song.artist,
                                 @"audio_md5":song.audio_md5,
                                 @"songName":song.songName,
                                 @"song_id":song.song_id,
                                 @"votes":[NSNumber numberWithInt: song.votes]
                                 }}];
                                 
                                 already=YES;
                         }

                    }];
                }
            }
            if(!found)
            {
                [RequestaAppDelegate showAlertViewWithTitle:@"Error" andText:@"DJ Not Found"];
            }
            
            alreadyRequested=YES;
        }
        
    }];
    
}


-(void)addDJProfileWithNickname:(NSString *)nickname realName:(NSString *)realName location:(NSString *)location
{
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://requesta.firebaseio.com/DJProfiles"];
    
    __block BOOL alreadyAdded=NO;
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot)
    {
        if(!alreadyAdded)
        {
            [f updateChildValues:@{[NSString stringWithFormat:@"%i",snapshot.childrenCount]:@{
             @"location":location,
             @"nickname":nickname,
             @"realName":realName
             }}];
            
            alreadyAdded = YES;
        }
        
    }];
}
					
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
