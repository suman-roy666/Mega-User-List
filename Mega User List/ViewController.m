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
    
}
NSString *cellIndentifier = @"UserDisplayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    self.userList = [[ UserList alloc] init ];
    
    dataStartIndex = 0;
    
    dataSource = [ NSMutableArray arrayWithArray: [self.userList.userList subarrayWithRange: NSMakeRange(dataStartIndex, TABLE_DISPLAY_COUNT) ] ];
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
    
//    if(cell == nil){
//        
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//        
//        userLabel = [[ UILabel alloc] init ];
//    }
    
    userLabel = (UILabel *)[cell viewWithTag:101];
    
    [ userLabel setText:[dataSource objectAtIndex:indexPath.row ]];
    
    return cell;
}

#pragma LoadMore Method::

- (IBAction)loadMoreTableData:(id)sender {
    
    dataStartIndex = dataStartIndex + TABLE_DISPLAY_COUNT;
    
    [ dataSource  addObjectsFromArray: [self.userList.userList subarrayWithRange: NSMakeRange(dataStartIndex, TABLE_DISPLAY_COUNT) ] ];
    [ self.userListTable reloadData ];

    if ( dataStartIndex >= ([ self.userList.userList count] - TABLE_DISPLAY_COUNT ) ) {
        
        [ self.LoadMoreButton setEnabled:NO ];
        
    }
}


@end
