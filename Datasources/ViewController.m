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

@property (nonatomic, strong) ArrayDataSource *namesArrayDataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

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
    NSMutableArray *namesArray = [[NSMutableArray alloc] initWithObjects:
                       @"Eric Delabar",
                       @"Justin Cockburn",
                       @"Dan Cuconati",
                       @"Tim Hanby",
                       @"Developer",
                       nil];
    
    [self buildTableView:namesArray];
}

- (void)buildTableView:(NSMutableArray *)namesArray
{
    TableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, NSString *name) {
        [cell.textLabel setText:name];
    };
    
    self.namesArrayDataSource = [[ArrayDataSource alloc] initWithArray:namesArray
                                                        cellIdentifier:NamesCellIdentifier
                                                    configureCellBlock:configureCell];
    self.tableView.dataSource = self.namesArrayDataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NamesCellIdentifier];
}

- (void)addUserViewController:(AddUserViewController *)controller didFinishEnteringUser:(NSString *)user
{
    NSMutableArray *namesArray = self.namesArrayDataSource.tableArray;
    [namesArray addObject:user];
    NSLog(@"This was returned from AddUserViewController %@",user);
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self buildTableView:namesArray];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    ((AddUserViewController *)segue.destinationViewController).delegate = self;
}

@end
