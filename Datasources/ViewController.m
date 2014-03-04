//
//  ViewController.m
//  Datasources
//
//  Created by Tim Hanby on 3/3/14.
//  Copyright (c) 2014 Timothy Hanby. All rights reserved.
//

#import "ViewController.h"
#import "ArrayDataSource.h"

static NSString * const NamesCellIdentifier = @"NameCell";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ArrayDataSource *namesArrayDataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation ViewController

- (IBAction)editTableView:(id)sender {
    if([[self.editButton title] isEqualToString:@"Done"]){
        [self.editButton setTitle:@"Edit"];
        [self.tableView setEditing:NO animated:YES];
    }else{
        [self.editButton setTitle:@"Done"];
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupTableView];
}

- (void)setupTableView
{
    TableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, NSString *name) {
        [cell.textLabel setText:name];
    };
    
    NSMutableArray *namesArray = [[NSMutableArray alloc] initWithObjects:
                       @"Eric Delabar",
                       @"Justin Cockburn",
                       @"Dan Cuconati",
                       @"Tim Hanby",
                       @"Developer",
                       nil];
    self.namesArrayDataSource = [[ArrayDataSource alloc] initWithArray:namesArray
                                                        cellIdentifier:NamesCellIdentifier
                                                    configureCellBlock:configureCell];
    self.tableView.dataSource = self.namesArrayDataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NamesCellIdentifier];
}



@end
