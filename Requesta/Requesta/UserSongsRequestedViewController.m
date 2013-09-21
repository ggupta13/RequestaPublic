//
//  UserSongsRequestedViewController.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "UserSongsRequestedViewController.h"
#import "Song.h"
#import <Firebase/Firebase.h>
#import "UserVoteRequestCell.h"

@interface UserSongsRequestedViewController ()

@end

@implementation UserSongsRequestedViewController

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
                            //artist,md5,songname,songid,votes
                            if(count2==0)
                                s.artist = [child3.value description];
                            else if(count2==1)
                                s.audio_md5 = [child3.value description];
                            else if(count2==2)
                                s.songName  = [child3.value description];
                            else if(count2==3)
                                s.song_id  = [child3.value description];
                            else if(count2==4)
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
                [self.UserSongRequestedTableOutlet reloadData];
            }
        }
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = self.chosenDJ.nickname;
    [self addCallbackOnSongs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RequestNewSongButtonPressed:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UserVoteRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UserVoteRequestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }
    
    Song *s = (Song *)[self.chosenDJ.requestedSongs objectAtIndex:indexPath.row];
    cell.SongTitleTextField.text = s.songName;
    cell.SongTitleTextField.font = [UIFont fontWithName:@"Eurostile" size:27.0f];
    cell.ArtistTextField.text = s.artist;
    cell.ArtistTextField.font = [UIFont fontWithName:@"Eurostile" size:20.0f];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chosenDJ.requestedSongs.count;//Number of cells
}



@end
