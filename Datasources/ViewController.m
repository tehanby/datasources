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
    self.client = [MSClient clientWithApplicationURLString:@"https://namestest.azure-mobile.net/"
                                            applicationKey:@"rvYeJVoPJysGaaRUZitZmSNKvzJTRW26"];
    
    [self buildNamesArray];
    
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
    self.searchDisplayController.searchResultsDataSource = self.namesArrayDataSource;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NamesCellIdentifier];
}

- (void)addUserViewController:(AddUserViewController *)controller didFinishEnteringUser:(NSString *)user
{
    NSDictionary *item = @{ @"item" : user };
    MSTable *itemTable = [self.client tableWithName:@"Item"];
    [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
        }
    }];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self buildNamesArray];
}

- (void)buildNamesArray
{
    NSMutableArray *namesArray = [[NSMutableArray alloc] init];
    MSTable *itemTable = [self.client tableWithName:@"Item"];
    [itemTable readWithCompletion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        for (id item in items){
            [namesArray addObject:[item objectForKey:@"item"]];
        }
        [self buildTableView:namesArray];
        [self.tableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    
    ((AddUserViewController *)segue.destinationViewController).delegate = self;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
    self.namesArrayDataSource.searchResults = [self.namesArrayDataSource.tableArray filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

@end
