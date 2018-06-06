//
//  UserTableViewController.m
//  WagiOSChallenge
//
//  Created by Gina De La Rosa on 6/6/18.
//  Copyright © 2018 Gina De La Rosa. All rights reserved.
//

#import "UserTableViewController.h"
#import "User.h"
#import "UserTableViewCell.h"

@interface UserTableViewController () <UIScrollViewDelegate>

@property UsersModel *model;
@property NSURL *userURL;

@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [[UsersModel alloc] init];
    self.model.site = @"stackoverflow";
    [self.model initialLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.users.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

- (UserTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.username.text = self.model.users[indexPath.row][@"display_name"];
    
    cell.goldBadge.text = [NSString stringWithFormat:@"• %@",
                           self.model.users[indexPath.row][@"gold"]];
    
    cell.silverBadge.text = [NSString stringWithFormat:@"• %@",
                             self.model.users[indexPath.row][@"silver"]];
    
    cell.bronzeBadge.text = [NSString stringWithFormat:@"• %@",
                             self.model.users[indexPath.row][@"bronze"]];
    
    cell.imageView.image = nil;
    cell.imageView.layer.borderWidth = 2.0;
    cell.imageView.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.imageView.layer.masksToBounds = YES;
    
    [cell.gravatarActivity startAnimating];
    [cell setNeedsLayout];
    NSURL *profileImageURL = [NSURL URLWithString:self.model.users[indexPath.row][@"profile_image_url"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        NSData *profileImageData = [NSData dataWithContentsOfURL:profileImageURL];
        UIImage *profileImage = [UIImage imageWithData:profileImageData];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            NSArray *visibleIndexPaths = self.tableView.indexPathsForVisibleRows;
            if ( [visibleIndexPaths containsObject:indexPath] ) {
                cell.imageView.image = profileImage;
                [cell.gravatarActivity stopAnimating];
                [cell setNeedsLayout];
            }
        });
    });
    
    return cell;
}

#pragma mark - Scroll View Delegate

-(void)scrollViewDidScroll: (UIScrollView*)scrollView {
    CGFloat frameHeight = scrollView.frame.size.height;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat scrollOffset = scrollView.contentOffset.y;
    
    if ( self.model.users != nil && (scrollOffset + frameHeight >= contentHeight) ) {
        [self.model loadUsers];
        [self.tableView reloadData];
    }
}

@end


