//
//  ArrayDataSource.m
//  Datasources
//
//  Created by Tim Hanby on 3/3/14.
//  Copyright (c) 2014 Timothy Hanby. All rights reserved.
//

#import "ArrayDataSource.h"


@interface ArrayDataSource ()
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@end

@implementation ArrayDataSource

- (id)initWithArray:(NSMutableArray *)aTableArray
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.tableArray = aTableArray;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.client = [MSClient clientWithApplicationURLString:@"https://namestest.azure-mobile.net/"
                                                applicationKey:@"rvYeJVoPJysGaaRUZitZmSNKvzJTRW26"];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.searchResults){
        return [self.searchResults count];
    }
    return [self.tableArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] init];
    }

    NSString *name = nil;
    if(self.searchResults){
        name = [self.searchResults objectAtIndex:indexPath.row];
    }else{
        name = [self.tableArray objectAtIndex:indexPath.row];
    }
    
    [cell.textLabel setText:name];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"item == '%@'", [self.tableArray objectAtIndex:indexPath.row]]];
        MSTable *itemTable = [self.client tableWithName:@"Item"];
        [itemTable readWithPredicate:predicate completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
            for(id item in items){
                [itemTable delete:item completion:^(id itemId, NSError *error) {
                    [self.tableArray removeObjectAtIndex:indexPath.row];
                    NSArray * indexPaths = [NSArray arrayWithObject:indexPath];
                    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
            }
        }];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSString *item = [self.tableArray objectAtIndex:fromIndexPath.row];
    [self.tableArray removeObject:item];
    [self.tableArray insertObject:item atIndex:toIndexPath.row];
    
}

@end
