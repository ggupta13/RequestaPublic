//
//  OpenScreenViewController.m
//  Requesta
//
//  Created by Jonathan Brelje on 9/21/13.
//  Copyright (c) 2013 JaganBreljGupta. All rights reserved.
//

#import "OpenScreenViewController.h"
#import "UserSongsRequestedViewController.h"
#import <Firebase/Firebase.h>
#import "DeeJay.h"
#import "MBProgressHUD.h"
#import "Song.h"
#import "DJChoiceCell.h"

@interface OpenScreenViewController ()
@property MBProgressHUD *hud;
@property NSUInteger chosenRow;
@end

@implementation OpenScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listOfDJs.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.chosenRow = indexPath.row;
    [self performSegueWithIdentifier:@"SelectDJToUserQueue" sender:self];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SelectDJToUserQueue"])
    {
        //in this segue
        UserSongsRequestedViewController *controller = segue.destinationViewController;
        controller.chosenDJ=[self.listOfDJs objectAtIndex:self.chosenRow];
        //NSLog(@"in here, sending: %@",[self.listOfDJs objectAtIndex:self.chosenRow]);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    DJChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil
       ) {
        cell = [[DJChoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
        
    }
    
    

    
    DeeJay *d = (DeeJay *)[self.listOfDJs objectAtIndex:indexPath.row];
    cell.DJNameTextField.text = d.nickname;
    cell.DJNameTextField.font = [UIFont fontWithName:@"Eurostile" size:27.0f];
    cell.RealNameTextField.text = d.realName;
    cell.RealNameTextField.font = [UIFont fontWithName:@"Eurostile" size:20.0f];
    return cell;
}

-(void)testQueryForDict
{
    NSString *url =  @"http://developer.echonest.com/api/v4/artist/search?api_key=NS1ENIII2ZDJXWXNT&name=radiohead";
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10   ];
    [req setHTTPMethod:@"GET"];
    NSData *lib;
    [req setHTTPBody:lib];
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error)
         {
             NSLog(@"error loading: %@",[error localizedDescription]);
         }
         else
             
         { NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             
             NSLog(@"dict: %@",dictionary);
         }
     }];

}

-(void)queryForDJs
{
    self.listOfDJs = [NSMutableArray new];
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://requesta.firebaseio.com/DJProfiles"];
    
    __block BOOL already = NO;
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(!already)
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
                //NSLog(@"got these requested songs: %@",d.requestedSongs);
                [self.listOfDJs addObject:d];
            }
            
            [self.hud hide:YES];
            [self.SelectDJTableViewOutlet reloadData];
            
            already = YES;
        }
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText=@"Loading...";
    
    self.listOfDJs = [NSMutableArray new];
    [self queryForDJs];
        
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DJSignInButtonPressed:(id)sender {
}
@end
