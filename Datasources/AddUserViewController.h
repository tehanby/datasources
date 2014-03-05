//
//  AddUserViewController.h
//  Datasources
//
//  Created by Tim Hanby on 3/5/14.
//  Copyright (c) 2014 Timothy Hanby. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddUserViewController;

@protocol AddUserViewControllerDelegate <NSObject>
- (void)addUserViewController:(AddUserViewController *)controller didFinishEnteringUser:(NSString *)user;
@end

@interface AddUserViewController : UITableViewController

@property (nonatomic, weak) id <AddUserViewControllerDelegate> delegate;

@end
