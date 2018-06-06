//
//  User.m
//  WagiOSChallenge
//
//  Created by Gina De La Rosa on 6/6/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

#import "User.h"

@implementation UsersModel

- (void)loadUsers {
    if ( !self.users ) {
        self.users = [[NSMutableArray alloc] init];
        self.currentPage = 1;
    }

    NSString *urlFormatString = @"https://api.stackexchange.com/2.2/users?page=%d&site=%@";
    NSString *urlString = [NSString stringWithFormat:urlFormatString, self.currentPage, self.site];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    
    if ( data == nil ) {
        NSLog(@"Error: Data can't be loaded");
        self.currentPage -= 1;
        return;
    }
    
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                options:kNilOptions
                                                                  error:nil];
    NSMutableArray *userInformation = json[@"items"];
    
    for ( id user in userInformation ) {
        NSDictionary *userDict = @{@"user_id": user[@"user_id"],
                                   @"display_name": user[@"display_name"],
                                   @"gold": user[@"badge_counts"][@"gold"],
                                   @"silver": user[@"badge_counts"][@"silver"],
                                   @"bronze": user[@"badge_counts"][@"bronze"],
                                   @"profile_image_url": user[@"profile_image"]
                                   };
        [self.users addObject: userDict];
    }
}

@end
