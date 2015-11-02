//
//  UserList.m
//  Mega User List
//
//  Created by Suman Roy on 16/10/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "UserManager.h"
#import "UserDetails.h"

@implementation UserManager

@synthesize userCount = _userCount;

+ (id)getSharedInstance{
    
    static UserManager *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UserManager alloc] init];
    });
    
    return _sharedInstance;
}

-(id)init{
    
    self = [ super init ];
    
    if (self) {
        
        self.userArray = [[NSMutableArray alloc] init ];
        
        for (int counter = 1, imageCount = 1 ; counter <= 10; counter++, imageCount++ ) {
            
            UserDetails *user = [[ UserDetails alloc] init];
            
            user.userName = [ NSString stringWithFormat:@"user %d", (counter) ];
            
            user.userImageUrl = [ [NSMutableDictionary alloc] initWithDictionary: [ [ NSDictionary alloc ] initWithObjectsAndKeys:
                                                     [ NSString stringWithFormat: @"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_%d.jpg", imageCount],
                                                     @"image",
                                                     nil ] ];
   
            
            if (imageCount == 10) {
                imageCount = 0;
            }
            
            [ self.userArray addObject: user ];
        }
        
        
        
    }
    
    _userCount = [ self.userArray count ];
    
    return self;
}

-(NSUInteger) userCount{
    
    return [ self.userArray count ];
}

-(void) addMoreUsers: (NSUInteger) increment{
    
    NSUInteger counter = self.userCount+1;
    NSUInteger imageCounter = ( counter % 10 );
    NSUInteger limit = self.userCount+increment;
    
    
    for (; counter <= limit ; counter++, imageCounter++ ) {
        
        UserDetails *user = [[ UserDetails alloc] init];
        
        user.userName = [ NSString stringWithFormat:@"user %lu", counter ];
        
        user.userImageUrl = [ [NSMutableDictionary alloc] initWithDictionary: [ [ NSDictionary alloc ] initWithObjectsAndKeys:
                                                                               [ NSString stringWithFormat: @"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_%lu.jpg", imageCounter],
                                                                               @"image",
                                                                               nil ] ];
        
        if (imageCounter == 10) {
            imageCounter = 0;
        }
        
        [ self.userArray addObject: user ];
    }
}

@end
