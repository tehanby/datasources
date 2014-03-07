//
//  ViewController.h
//  Datasources
//
//  Created by Tim Hanby on 3/3/14.
//  Copyright (c) 2014 Timothy Hanby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddUserViewController.h"
#import <AzureSDK-iOS/WindowsAzureMobileServices.h>

@interface ViewController : UIViewController <AddUserViewControllerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (strong, nonatomic) MSClient *client;

@end
