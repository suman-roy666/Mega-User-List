//
//  ViewController.h
//  Mega User List
//
//  Created by Suman Roy on 16/10/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserList.h"

@interface ViewController : UIViewController <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *userListTable;
@property (weak, nonatomic) IBOutlet UIButton *LoadMoreButton;

@property (strong) UserList *userList;

@end

