//
//  User.h
//  WagiOSChallenge
//
//  Created by Gina De La Rosa on 6/6/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsersModel : NSObject

@property NSMutableArray *users;
@property NSInteger currentPage;
@property NSString *site;

- (void)loadUsers;

@end
