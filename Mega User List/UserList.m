//
//  UserList.m
//  Mega User List
//
//  Created by Suman Roy on 16/10/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "UserList.h"

@implementation UserList

-(id)init{
    
    self = [ super init ];
    
    if (self) {
        
        _userList = [[NSMutableArray alloc] init ];
        
        int userCount = 0;
        NSString *userName;
        
        for (; userCount < 50; userCount++ ) {
            
            userName = [NSString stringWithFormat:@"user %d", (userCount + 1) ];
            
            [ _userList addObject:userName ];
        }
        
    }
    
    return self;
}

@end
