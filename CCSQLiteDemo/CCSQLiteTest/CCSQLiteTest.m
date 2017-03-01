//
//  CCSQLiteTest.m
//  CCSQLiteDemo
//
//  Created by dengyouhua on 17/2/13.
//  Copyright © 2017年 CC | ccworld1000@gmail.com. All rights reserved.
//

#import "CCSQLiteTest.h"
#import <CCSQLite.h>

@implementation CCSQLiteTest
    
+ (void) SQLiteTest {
    NSLog(@"SQLiteTest");
    
    NSString *path = nil;
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
#else
    path = NSTemporaryDirectory() ;
#endif
    
    path = [path stringByAppendingPathComponent:CCSQLiteTestDB];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error: nil];
    }
    
    CCSQLite *SQLite = [CCSQLite databaseWithPath: path];

    if ([SQLite open]) {
        BOOL result = [SQLite executeUpdate: @"create table if not exists t_student (id integer primary key autoincrement, name text not NULL, age integer not NULL);"];
        if (result) {
            NSLog(@"create table t_student ok");
            NSLog(@"path : %@", path);
       }
    }
    
    [SQLite executeUpdate:@"insert into t_student (name, age) values (?, ?);", @"cc test 0", @0];
    [SQLite executeUpdate:@"insert into t_student (name, age) values (?, ?);", @"cc test 1", @1];
    [SQLite executeUpdateWithFormat:@"insert into t_student (name, age) values (%@, %i);", @"cc test 2", 2000];
    
//    [SQLite executeUpdate:@"delete from t_student where id = ?", @1];
    
    CCResultSet *resultSet = [SQLite executeQuery:@"select * from t_student;"];
    while ([resultSet next]) {
        int idNum = [resultSet intForColumn:@"id"];
        NSString *name = [resultSet objectForColumnName:@"name"];
        int age = [resultSet intForColumn:@"age"];
        
        NSLog(@"id = %d name = %@ age = %d", idNum, name, age);
    }
    
//    [SQLite executeUpdate:@"drop table if exists t_student;"];
    
    NSString *sql = @"create table bulktest1 (id integer primary key autoincrement, x text);"
    "create table bulktest2 (id integer primary key autoincrement, y text);"
    "create table bulktest3 (id integer primary key autoincrement, z text);"
    "insert into bulktest1 (x) values ('XXX');"
    "insert into bulktest2 (y) values ('YYY');"
    "insert into bulktest3 (z) values ('ZZZ');";
    
    BOOL success = [SQLite executeStatements:sql];
    
    if (success) {
        NSLog(@"success");
    }
    
    sql = @"select count(*) as count from bulktest1;"
    "select count(*) as count from bulktest2;"
    "select count(*) as count from bulktest3;";
    
    [SQLite executeStatements:sql withResultBlock:^int(NSDictionary *resultsDictionary) {
        NSInteger count = [resultsDictionary[@"count"] integerValue];
        NSLog(@"count = %ld", count);
        return 0;
    }];
    
    
    [SQLite close];


    

    [[CCKeyValue defaultKeyValueWithPath:path] setObject:@"CC china 1112" key:@"china key"];
    [[CCKeyValue defaultKeyValueWithPath:path] setObject:@"CCVV" key:@"CC"];
    
    id test = [[CCKeyValue defaultKeyValueWithPath:path] objectForKey:@"CC"];
    NSLog(@"test 1 : %@", test);
    
    [[CCKeyValue defaultKeyValueWithPath:path] setObject:@[@1, @2, @3] key:@"CA"];
    
    test = [[CCKeyValue defaultKeyValueWithPath:path] objectForKey:@"CA"];
    NSLog(@"test 2 : %@", test);
    
    CCSQLiteQueue *queue = [CCSQLiteQueue databaseQueueWithPath:path];
    
    __block NSInteger index = 3000;
    [queue inDatabase:^(CCSQLite *db) {
        while (index < 3100) {
            index++;
            [db executeUpdate:@"insert into t_student (name, age) values (?, ?);", [NSString stringWithFormat:@"cc test inDatabase %ld", index], @(index)];
        }

    }];
    
    [queue inTransaction:^(CCSQLite *db, BOOL *rollback) {
        NSLog(@"rollback NO");
        while (index < 3150) {
            index++;
            [db executeUpdate:@"insert into t_student (name, age) values (?, ?);", [NSString stringWithFormat:@"cc test inTransaction %ld", index], @(index)];
        }
    }];
    
    [queue inTransaction:^(CCSQLite *db, BOOL *rollback) {
        NSLog(@"rollback YES");
        while (index < 3200) {
            index++;
            [db executeUpdate:@"insert into t_student (name, age) values (?, ?);", [NSString stringWithFormat:@"cc test inTransaction %ld", index], @(index)];
            
            if (index == 3188) {
                *rollback = YES;
                return ;
            }
        }
    }];
    
    CCKeyValue *kv = [CCKeyValue defaultKeyValueWithPath:path];
    kv.valueType = CCKeyValueTypeJson;
    
    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CCJSON" ofType:@"json"]];
    
    [kv setObject:data key:@"jsonkey"];
    
    id CCJSON =  [kv objectForKey:@"jsonkey"];
    
    if ([CCJSON isKindOfClass:[NSArray class]]) {
        NSArray *list = CCJSON;
        
        [list enumerateObjectsUsingBlock:^(NSDictionary *d, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@\n", d);
        }];
    }
}

@end
