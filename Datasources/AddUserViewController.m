//
//  AddUserViewController.m
//  Datasources
//
//  Created by Tim Hanby on 3/5/14.
//  Copyright (c) 2014 Timothy Hanby. All rights reserved.
//

#import "AddUserViewController.h"
#import "ViewController.h"

@interface AddUserViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *userName;


@end

@implementation AddUserViewController

- (IBAction)handleSaveUser:(id)sender {
    NSString *user = self.userName.text;
    [self.delegate addUserViewController:self didFinishEnteringUser:user];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


@end
