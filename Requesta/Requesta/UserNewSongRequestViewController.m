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
#import "MBProgressHUD.h"
#import "QuestionPanel.h"

@interface UserNewSongRequestViewController ()
@property MBProgressHUD *hud;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tapGesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.searchResults = [NSMutableArray new];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture setCancelsTouchesInView:NO];
    
    Song *s = [[Song alloc]init];
    s.songName = @"Beauty2222";
    s.song_id = @"willbechanged";
    s.audio_md5 = @"willbereal";
    s.votes=0;
    s.artist=@"JBiebs";

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

- (void) tapGesture
{
    [self.MusicSearchTextFieldOutlet resignFirstResponder];
}

- (IBAction)SearchButtonPressed:(id)sender
{
    self.searchResults = [NSMutableArray new];
    [self.MusicSearchTextFieldOutlet resignFirstResponder];

    NSString *typedFormatted = [self.MusicSearchTextFieldOutlet.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url =  [NSString stringWithFormat:@"http://developer.echonest.com/api/v4/song/search?api_key=NS1ENIII2ZDJXWXNT&combined=%@&sort=song_hotttnesss-desc&results=100",typedFormatted];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10   ];
    [req setHTTPMethod:@"GET"];
    NSData *lib;
    [req setHTTPBody:lib];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"Loading...";

    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             NSLog(@"error loading: %@",[error localizedDescription]);
         }
         else
             
         {
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             //NSLog(@"dict: %@",dictionary);
             
             NSEnumerator *enumerator = [[[dictionary objectForKey:@"response"]objectForKey:@"songs"] objectEnumerator];
             id value;
             while ((value = [enumerator nextObject]))
             {
                 Song *s = [[Song alloc]init];
                 int count=0;
                 id val;
                 NSEnumerator *e = [value objectEnumerator];
                 
                 while((val=[e nextObject]))
                 {
                     //NSLog(@"val: %@",val);
                     if(count==0)
                         s.artist = [val description];
                     else if(count==1)
                         s.song_id = [val description];
                     else if(count==2)
                         s.songName = [val description];
                     
                     count++;
                 }
                 
                 [self.searchResults addObject:s];
             }
             [self.hud hide:YES];
             [self.SearchResultTableOutlet reloadData];
         }
     }];
    

}

- (IBAction)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height * (6/8.));
    QuestionPanel *qPanel = [[QuestionPanel alloc] initWithFrame:frame];
    qPanel.delegate2 = self;
    qPanel.song = [self.searchResults objectAtIndex:indexPath.row];
    //qPanel.djRealName =
    [self.view addSubview:qPanel];
    [qPanel showFromPoint:self.view.center];
}

- (void) sendRequestForSong:(Song *)song nickname:(NSString *)nickname realName:(NSString *)realName
{
    //SEND REQUEST!
    //NSString *typedFormatted = [song.songName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"songid: %@",song.song_id);
    NSString *url =  [NSString stringWithFormat:@"http://developer.echonest.com/api/v4/song/search?api_key=NS1ENIII2ZDJXWXNT&id=%@&bucket=audio_summary",song.song_id];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10   ];
    [req setHTTPMethod:@"GET"];
    NSData *lib;
    [req setHTTPBody:lib];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"Loading...";
    
    
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             NSLog(@"error loading: %@",[error localizedDescription]);
         }
         else
             
         {
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSLog(@"dict: %@",dictionary);
             
             
             [self.hud hide:YES];
         }
     }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Song *s = (Song *)[self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",s.songName,s.artist];
    return cell;
}
@end
