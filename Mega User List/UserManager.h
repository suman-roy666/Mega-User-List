//
//  UserList.h
//  Mega User List
//
//  Created by Suman Roy on 16/10/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property NSMutableArray *userArray;

@property (readonly) NSUInteger userCount;

+ (id)getSharedInstance;

-(void) addMoreUsers: (NSUInteger) increment;

@end
