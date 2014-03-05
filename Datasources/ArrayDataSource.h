//
//  ArrayDataSource.h
//  Datasources
//
//  Created by Tim Hanby on 3/3/14.
//  Copyright (c) 2014 Timothy Hanby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrayDataSource : NSObject<UITableViewDataSource>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@property (strong, nonatomic) NSMutableArray *tableArray;

- (id)initWithArray:(NSArray *)aTableArray
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

@end
