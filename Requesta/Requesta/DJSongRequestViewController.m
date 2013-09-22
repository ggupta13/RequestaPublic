//
//  DJSongRequestViewController.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "DJSongRequestViewController.h"
#import "DJRequestCell.h"
#import <Firebase/Firebase.h>
#import "DeeJay.h"
#import "Song.h"
#import "Singleton.h"
#import "QuestionPanel.h"

@interface DJSongRequestViewController ()

@end

@implementation DJSongRequestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addCallbackOnSongs
{
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://requesta.firebaseio.com/DJProfiles"];
    
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot)
     {
         for(FDataSnapshot *child in snapshot.children)
         {
             DeeJay *d = [[DeeJay alloc]init];
             d.requestedSongs = [NSMutableArray new];
             int count=0;
             
             for(FDataSnapshot *child2 in child.children)
             {
                 if(count==0)
                     d.location = [child2.value description];
                 else if(count==1)
                     d.nickname = [child2.value description];
                 else if(count==2)
                     d.realName = [child2.value description];
                 else if(count==3)
                 {
                     
                     for(FDataSnapshot *c in child2.children)
                     {
                         Song *s = [[Song alloc]init];
                         int count2=0;
                         for(FDataSnapshot *child3 in c.children)
                         {
                             //artist,dance,duration
                             if(count2==0)
                                 s.artist = [child3.value description];
                             else if(count2==1)
                                 s.danceability = [child3.value doubleValue];
                             else if(count2==2)
                                 s.duration = [child3.value doubleValue];
                             else if(count2==3)
                                 s.energy = [child3.value doubleValue];
                             else if(count2==4)
                                 s.loudness = [child3.value doubleValue];
                             else if(count2==5)
                                 s.songName  = [child3.value description];
                             else if(count2==6)
                                 s.song_id  = [child3.value description];
                             else if(count2==7)
                                 s.tempo = [child3.value doubleValue];
                             else if(count2==8)
                                 s.votes = [child3.value integerValue];

                             
                             count2++;
                         }
                         [d.requestedSongs addObject:s];
                     }
                 }
                 count++;
             }
             if([self.chosenDJ.nickname isEqualToString:d.nickname] && [self.chosenDJ.realName isEqualToString:d.realName])
             {
                 self.chosenDJ.requestedSongs = [[NSMutableArray alloc]initWithArray:d.requestedSongs];
                 [self.SongRequestTableOutlet reloadData];
             }
         }
     }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.chosenDJ = [Singleton sharedInstance].currentDeejay;
    NSLog(@"dj name: %@",self.chosenDJ.nickname);
    [self addCallbackOnSongs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Song *s = [self.chosenDJ.requestedSongs objectAtIndex:indexPath.row];
    
    //THERE IS YOUR SONG, LOOK AT SONG.H FOR ALL THE DATA
    
    
    /*CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height * (6/8.));
    QuestionPanel *qPanel = [[QuestionPanel alloc] initWithFrame:frame];
    qPanel.delegate2 = self;
    qPanel.djRealName = [Singleton sharedInstance].currentDeejay.realName;
    qPanel.djNickname = [Singleton sharedInstance].currentDeejay.nickname;
    [self.view addSubview:qPanel];
    [qPanel showFromPoint:self.view.center];*/
}

 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    
     DJRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
       cell = [[DJRequestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }
    //DATA FOR SONG HERE
    Song *s = [self.chosenDJ.requestedSongs objectAtIndex:indexPath.row];
    cell.ArtistTextField.text = s.artist;
    cell.SongTitleTextField.text = s.songName;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %i", self.chosenDJ.requestedSongs.count);
    return self.chosenDJ.requestedSongs.count;//Number of cells
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
