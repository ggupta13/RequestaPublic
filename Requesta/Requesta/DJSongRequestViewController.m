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
#import "DJRequestSongInfoPanel.h"
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
                 NSSortDescriptor *sortDescriptor;
                 sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"votes"
                                                              ascending:NO];
                 NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                 NSArray *sortedArray;
                 sortedArray = [d.requestedSongs sortedArrayUsingDescriptors:sortDescriptors];
                 d.requestedSongs = [[NSMutableArray alloc]initWithArray:sortedArray];
                 
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
    
    
    CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height * (5.3/8.));
    DJRequestSongInfoPanel *qPanel = [[DJRequestSongInfoPanel alloc] initWithFrame:frame];
    qPanel.delegate2 = self;
    qPanel.djRealName = [Singleton sharedInstance].currentDeejay.realName;
    qPanel.djNickname = [Singleton sharedInstance].currentDeejay.nickname;
    qPanel.songTitle.text = s.songName;
    qPanel.songArtist.text = s.artist;
    qPanel.tempo.text = [NSString stringWithFormat:@"Tempo: %i",(int)s.tempo];
    qPanel.votes.text = [NSString stringWithFormat:@"Votes: %i",s.votes];
    qPanel.danceability.text = [NSString stringWithFormat:@"Danceability: %i%%",(int)((s.danceability/1.0)*100)];
    qPanel.loudness.text = [NSString stringWithFormat:@"Loudness: %i dB",(int)s.loudness];
    qPanel.energy.text = [NSString stringWithFormat:@"Energy: %i%%",(int)((s.energy/1.0)*100)];
    qPanel.duration.text = [NSString stringWithFormat:@"Length: %i:%i",(int)s.duration/60, (int)(s.duration - (int)s.duration/60*60)];
    [qPanel.requestButton removeFromSuperview];
    [qPanel showFromPoint:self.view.center];
    [self.view addSubview:qPanel];
    
    
    
    
    /*
    @property (nonatomic, strong) UITextView *tempo;
    @property (nonatomic, strong) UITextView *hotttness;
    @property (nonatomic, strong) UITextView *danceability;
    @property (nonatomic, strong) UITextView *duration;
    @property (nonatomic, strong) UITextView *energy;
    @property (nonatomic, strong) UITextView *loudness;
    @property (nonatomic, strong) UITextView *votes;*/
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
    cell.BPMDigitsTextField.text = [NSString stringWithFormat:@"%i", (int)s.tempo];
    cell.VotesTextField.text = [NSString stringWithFormat:@"%i",s.votes];
    cell.ArtistTextField.font = [UIFont fontWithName:@"Eurostile" size:20.0f];
    cell.SongTitleTextField.font = [UIFont fontWithName:@"Eurostile" size:27.0f];
    cell.VotesTextField.font = [UIFont fontWithName:@"Eurostile" size:20.0f];
    cell.BPMDigitsTextField.font = [UIFont fontWithName:@"Eurostile" size:20.0f];
    cell.VotesTitleTextField.font = [UIFont fontWithName:@"Eurostile" size:20.0f];
    
    
    
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
