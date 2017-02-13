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
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
