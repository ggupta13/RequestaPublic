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
#import "Singleton.h"
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
        [Singleton sharedInstance].currentDeejay = (DeeJay *) [self.listOfDJs objectAtIndex:self.chosenRow];
        DeeJay *aa = (DeeJay *)[self.listOfDJs objectAtIndex:self.chosenRow];
        [Singleton sharedInstance].currRequestedSongs = aa.requestedSongs;
        
        //NSLog(@"in here, sending: %@",[self.listOfDJs objectAtIndex:self.chosenRow]);
    }
    [Singleton sharedInstance].currentDeejay = (DeeJay *) [self.listOfDJs objectAtIndex:self.chosenRow];
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
    self.DJSignInButton.titleLabel.font = [UIFont fontWithName:@"Eurostile" size:18.0f];
        
	// Do any additional setup after loading the view.
    
    UIColor *blue = [UIColor colorWithRed:44.0/255.0f green:172/255.0f blue:205/255.0f alpha:1.0f];
    //[[UINavigationBar appearance] setTintColor:blue];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeFont:[UIFont fontWithName:@"Eurostile" size:22.0f]}];
    self.navigationController.navigationBar.tintColor = blue;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[UIFont fontWithName:@"Eurostile" size:14.0f] forKey:UITextAttributeFont];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    UIImage *backgroundImage = [self drawImageWithColor:blue];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    //44,172,205
}

-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImage*)drawImageWithColor:(UIColor*)color{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *imagePath;
    imagePath = [[paths lastObject] stringByAppendingPathComponent:@"NavImage.png"];
    if([fileManager fileExistsAtPath:imagePath]){
        return  [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
    }
    UIGraphicsBeginImageContext(CGSizeMake(320, 40));
    [color setFill];
    UIRectFill(CGRectMake(0, 0, 320, 40));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:imagePath atomically:YES];
    return image;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DJSignInButtonPressed:(id)sender {
}
@end
