//
//  UserNewSongRequestViewController.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "UserNewSongRequestViewController.h"
#import <Firebase/Firebase.h>
#import "Song.h"
#import "RequestaAppDelegate.h"

@interface UserNewSongRequestViewController ()

@end

@implementation UserNewSongRequestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    Song *s = [[Song alloc]init];
    s.songName = @"Beauty2222";
    s.song_id = @"willbechanged";
    s.audio_md5 = @"willbereal";
    s.votes=0;
    s.artist=@"JBiebs";

    
    //////////////// REMOVE THIS LATER //////////////////
    [self requestSongForDJ:s nickname:@"Kid_Curi" realName:@"Yash Sharma"];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SearchButtonPressed:(id)sender {
}

- (IBAction)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = @"ya";
    return cell;
}
@end
