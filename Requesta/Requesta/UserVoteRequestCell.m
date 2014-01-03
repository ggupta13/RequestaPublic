//
//  UserVoteRequestCell.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "UserVoteRequestCell.h"
#import "Singleton.h"
#import "Song.h"
#import <Firebase/Firebase.h>
#import "RequestaAppDelegate.h"

@implementation UserVoteRequestCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"UserVoteRequestCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
                              NSString *songName=@"",*songArtist=@"",*song_id=@"";
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
                                      else if(count2==5)
                                          songName = [childd2.value description];
                                      else if(count2==6)
                                          song_id = [childd2.value description];
                                      else if(count2==8)
                                          currVotes = [childd2.value integerValue];
                                      
                                      count2++;
                                  }
                                  
                                  NSLog(@"%@ %@ %@",songArtist,songName,song_id);
                                  
                                  if([song.artist isEqualToString:songArtist] &&
                                     [song.songName isEqualToString:songName])
                                  {
                                      
                                      NSString *path = [NSString stringWithFormat:@"https://requesta.firebaseio.com/DJProfiles/%@/requestedSongs/%@",currName,currSong];
                                      NSLog(@"found the song at path: %@",path);
                                      Firebase *f3 = [[Firebase alloc]initWithUrl:path];
                                      
                                      __block BOOL already2 = NO;
                                      
                                      [f3 observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshotx2)
                                       {
                                           if(!already2)
                                           {
                                               [f3 updateChildValues:@{
                                                @"artist":song.artist,
                                                @"danceability":[NSNumber numberWithDouble:song.danceability],
                                                @"duration":[NSNumber numberWithDouble:song.duration],
                                                @"energy":[NSNumber numberWithDouble:song.energy],
                                                @"loudness":[NSNumber numberWithDouble:song.loudness],
                                                @"songName":song.songName,
                                                @"song_id":song.song_id,
                                                @"tempo":[NSNumber numberWithDouble:song.tempo],
                                                @"votes":[NSNumber numberWithInt: song.votes+1]
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


- (IBAction)VoteArrowPressed:(id)sender {
    //[self.VoteArrow setImage :[UIImage imageNamed: @"VoteArrowOrange.png"] forState: UIControlStateNormal];
    //[self.VoteArrow setImage :[UIImage imageNamed: @"VoteArrowOrange.png"] forState: UIControlStateSelected];
    if(!self.hasBeenPressed)
    {
        self.hasBeenPressed = YES;
        //[self.VoteArrow setBackgroundImage :[UIImage imageNamed: @"VoteArrowOrange.png"] forState: UIControlStateNormal];

        /*int currentVotes = [self.VoteCountTextField.text integerValue];
>>>>>>> f64ba56b828477527ac270a225ebfaa77f07eb40
        currentVotes++;
        self.VoteCountTextField.text = [NSString stringWithFormat:@"%d",currentVotes];*/
        
         NSIndexPath *myIndexPath = [(UITableView *)self.superview indexPathForCell: self];
        
        Song *s = [[Singleton sharedInstance].currRequestedSongs objectAtIndex:myIndexPath.row];
        NSLog(@"name: %@",s.songName);
        DeeJay *d = [Singleton sharedInstance].currentDeejay;
        [self voteSong:s forDJNickname:d.nickname realName:d.realName];
    }
}
@end
