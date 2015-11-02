//
//  ViewController.m
//  Mega User List
//
//  Created by Suman Roy on 16/10/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "ViewController.h"
#import "UserManager.h"
#import "UserDetails.h"
#import "UserDisplayCell.h"

#define TABLE_DISPLAY_COUNT 10

@implementation ViewController{
    
    NSUInteger dataStartIndex;
    NSOperationQueue *imageDowloadQueue;
    UserManager *userManager;
}

const NSString *cellIndentifier = @"UserDisplayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [ self.userListTable registerClass:[UserDisplayCell class] forCellReuseIdentifier:cellIndentifier ];
    
    [ self.userListTable registerNib:[UINib nibWithNibName:NSStringFromClass([UserDisplayCell class]) bundle:nil] forCellReuseIdentifier:cellIndentifier];
    

    
    userManager = [ UserManager getSharedInstance ];
    
    dataStartIndex = 0;
    
    imageDowloadQueue = [[ NSOperationQueue alloc ] init ];
    //
    //    for (NSDictionary *dict in self.userList.userList) {
    //        NSLog(@"%@:: %@", [ dict valueForKey:@"UserName"], [ dict valueForKey:@"image"] );
    //    }
    
    [self.userListTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ userManager userCount ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserDisplayCell *cell = [ self.userListTable dequeueReusableCellWithIdentifier:cellIndentifier forIndexPath:indexPath];
    
    UserDetails *currentUser = [ userManager.userArray objectAtIndex:indexPath.row ];
    
    [ cell.userNameLabel setText:[ currentUser valueForKey:@"userName" ]];
    
    NSDictionary *userImage = [ currentUser valueForKey:@"userImageUrl"];
    
    if ( [ userImage valueForKey:@"status" ] ) {
        
        if ( [ [ userImage valueForKey:@"status" ] isEqualToString: @"completed" ]
            && [ userImage valueForKey:@"image" ]
            && [[ userImage valueForKey:@"image" ] isKindOfClass: [ UIImage class] ] ) {
            
            [ cell.userImageView setImage:[ userImage valueForKey:@"image" ] ];
            [ cell.userImageView setContentMode: UIViewContentModeScaleAspectFill ];
        }
        
    } else {
        
        [ cell.userImageView setImage:nil ];

        
        [ userImage setValue:@"inprogress" forKey:@"status" ];
                
        [ imageDowloadQueue addOperationWithBlock: ^{
            
            UIImage *image = [ UIImage imageWithData:
                                  [ NSData dataWithContentsOfURL:
                                   [ NSURL URLWithString: [ userImage valueForKey:@"image" ]] ]];
            
            [ userImage setValue:image forKey:@"image" ];
            
            [ userImage setValue:@"completed" forKey:@"status" ];
            
            [[ NSOperationQueue mainQueue ] addOperationWithBlock: ^{
                
                [ _userListTable reloadRowsAtIndexPaths:[ NSArray arrayWithObject:indexPath ]
                                       withRowAnimation:UITableViewRowAnimationAutomatic ];
                
            }];
            
        }];
    }
    
    return cell;
}

#pragma mark LoadMore Method::

- (IBAction)loadMoreTableData:(id)sender {
    
    [ userManager addMoreUsers:10 ];
    
    [ self.userListTable reloadData ];
    
    if ( [ userManager userCount ] >= 100 ) {
        [ self.LoadMoreButton setEnabled:NO ];
    }
    
//    dataStartIndex = dataStartIndex + TABLE_DISPLAY_COUNT;
//    
//    [ dataSource  addObjectsFromArray: [self.userList.userArray
//                                        subarrayWithRange: NSMakeRange(dataStartIndex, TABLE_DISPLAY_COUNT) ] ];
//    [ self.userListTable reloadData ];
//    
//    if ( dataStartIndex >= ([ self.userList.userArray count] - TABLE_DISPLAY_COUNT ) ) {
//        
//        [ self.LoadMoreButton setEnabled:NO ];
//        
//    }
}


@end
