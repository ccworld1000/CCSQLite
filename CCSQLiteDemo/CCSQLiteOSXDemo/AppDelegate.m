//
//  AppDelegate.m
//  CCSQLiteOSXDemo
//
//  Created by deng you hua on 2/13/17.
//
//

#import "AppDelegate.h"
#import "CCSQLiteTest.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [CCSQLiteTest SQLiteTest];
    
//    NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"SQLite.db"];
//    CCSQLite *SQLite = [CCSQLite databaseWithPath: path];
//    if (![SQLite open]) {
//        SQLite = nil;
//        return;
//    }
//    
//    CCResultSet *s = [SQLite executeQuery:@"select * from myTable"];
//    while ([s next]) {
//        NSLog(@"next");
//    }
//    
//    NSLog(@"CCResultSet *s = %@", s);
//    
//    [SQLite close];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
