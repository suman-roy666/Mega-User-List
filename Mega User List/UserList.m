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
        
        NSString *userName;
        NSString *imageURL ;
        
        for (int userCount = 1, imageCount = 1 ; userCount <= 50; userCount++, imageCount++ ) {
            
            userName = [NSString stringWithFormat:@"user %d", (userCount) ];
            imageURL = [ NSString stringWithFormat: @"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_%d.jpg", imageCount];
            
            if (imageCount == 10) {
                imageCount = 0;
            }
            
            [ _userList addObject:
                    [ [ NSMutableDictionary alloc ] initWithObjectsAndKeys: userName,@"UserName",imageURL,@"UserImage", nil ] ];
        }
        
        
        
    }
    
    return self;
}

@end
