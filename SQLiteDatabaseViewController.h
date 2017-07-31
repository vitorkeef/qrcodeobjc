//
//  SQLiteDatabaseViewController.h
//  QueryCodeObjective
//
//  Created by ImacTeamMobile2 on 28/07/17.
//  Copyright © 2017 Vitor Leone Prado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface SQLiteDatabaseViewController : UIViewController

@property(strong, nonatomic) NSString *databasePath;
@property(nonatomic) sqlite3 *DB;

@end
