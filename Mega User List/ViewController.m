//
//  ViewController.m
//  Mega User List
//
//  Created by Suman Roy on 16/10/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "ViewController.h"
#import "UserList.h"

#define TABLE_DISPLAY_COUNT 10

@implementation ViewController{
    
    NSMutableArray *dataSource;
    NSUInteger dataStartIndex;
    UITableViewCell *cell;
    UILabel *userLabel;
    UIImageView *userImageView;
    NSOperationQueue *imageDowloadQueue;
}
NSString *cellIndentifier = @"UserDisplayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.userList = [[ UserList alloc] init ];
    
    dataStartIndex = 0;
    
    dataSource = [ NSMutableArray arrayWithArray: [self.userList.userList
                                                   subarrayWithRange: NSMakeRange(dataStartIndex, TABLE_DISPLAY_COUNT) ] ];
    
    imageDowloadQueue = [[ NSOperationQueue alloc ] init ];
    //
    //    for (NSDictionary *dict in self.userList.userList) {
    //        NSLog(@"%@:: %@", [ dict valueForKey:@"UserName"], [ dict valueForKey:@"UserImage"] );
    //    }
    
    [self.userListTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        userLabel = [[ UILabel alloc] init ];
    }
    
    NSMutableDictionary *currentValue = [dataSource objectAtIndex:indexPath.row ];
    
    userLabel = (UILabel *)[cell viewWithTag:101];
    
    [ userLabel setText:[ currentValue valueForKey:@"UserName" ]];
    
    if ( [ currentValue valueForKey:@"status" ] ) {
        
        if ( [ [ currentValue valueForKey:@"status" ] isEqualToString: @"completed" ]
            && [ currentValue valueForKey:@"UserImage" ]
            && [[ currentValue valueForKey:@"UserImage" ] isKindOfClass: [ UIImage class] ] ) {
            
            
            userImageView = (( UIImageView* )[ cell viewWithTag:100 ]);
            
            [ userImageView setContentMode: UIViewContentModeScaleAspectFit ];
            
            [ userImageView setImage:[ currentValue valueForKey:@"UserImage" ] ];
            
        }
        
    } else {
        
        [ currentValue setValue:@"inprogress" forKey:@"status" ];
        
        [ imageDowloadQueue addOperationWithBlock: ^{
            
            UIImage *userImage = [ UIImage imageWithData:
                                  [ NSData dataWithContentsOfURL:
                                   [ NSURL URLWithString: [ currentValue valueForKey:@"UserImage" ]] ]];
            
            [ currentValue setValue:userImage forKey:@"UserImage" ];
            
            [ currentValue setValue:@"completed" forKey:@"status" ];
            
            [[ NSOperationQueue mainQueue ] addOperationWithBlock: ^{
                
                [ _userListTable reloadRowsAtIndexPaths:[ NSArray arrayWithObject:indexPath ]
                                       withRowAnimation:UITableViewRowAnimationAutomatic ];
                
            }];
            
        }];
    }
    
    return cell;
}

#pragma LoadMore Method::

- (IBAction)loadMoreTableData:(id)sender {
    
    dataStartIndex = dataStartIndex + TABLE_DISPLAY_COUNT;
    
    [ dataSource  addObjectsFromArray: [self.userList.userList
                                        subarrayWithRange: NSMakeRange(dataStartIndex, TABLE_DISPLAY_COUNT) ] ];
    [ self.userListTable reloadData ];
    
    if ( dataStartIndex >= ([ self.userList.userList count] - TABLE_DISPLAY_COUNT ) ) {
        
        [ self.LoadMoreButton setEnabled:NO ];
        
    }
}


@end
