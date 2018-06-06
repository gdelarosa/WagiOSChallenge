//
//  UserTableViewCell.h
//  WagiOSChallenge
//
//  Created by Gina De La Rosa on 6/6/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *gravatarImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *goldBadge;
@property (weak, nonatomic) IBOutlet UILabel *silverBadge;
@property (weak, nonatomic) IBOutlet UILabel *bronzeBadge;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *gravatarActivity;

@end
