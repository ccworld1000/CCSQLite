[![Platform](https://img.shields.io/badge/platforms-iOS%20%7C%20OSX-orange.svg)](https://github.com/ccworld1000/CCSQLite.git)
[![Languages](https://img.shields.io/badge/languages-ObjC-orange.svg)](https://github.com/ccworld1000/CCSQLite)
![Swift 5.3.0.x](https://img.shields.io/badge/Swift-5.3.0.x-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/CCSQLite.svg)](https://github.com/ccworld1000/CCSQLite.git)
[![License](https://img.shields.io/cocoapods/l/CCSQLite.svg)](https://github.com/ccworld1000/CCSQLite/blob/master/LICENSE/LICENSE.CCSQLite.txt)

### CCSQLite Objective-C 封装的SQLite. 结合YapDatabase(key/value store) + FMDB.

###  [CCSQLite](https://github.com/ccworld1000/CCSQLite)
***
[英文README](README.md)

***
# 目的
* 转变 FMDB 到 ARC 模式
* YapDatabase 键/值 store 
* CCSQLite 结合 FMDB 和 YapDatabase 键/值 

***
###  目的
* 转变 FMDB 到 ARC 模式
* YapDatabase 键/值 store  
* CCSQLite 结合 FMDB 和 YapDatabase 键/值
* 支持 OBJECT, JSON 到 键/值

***

***
# 缘由 && 为啥
***
当我在写"HSCache [缓存处理方面]", 想选择FMDB或者YapDatabase, 但是他们看起来不一样. 因此想结合YapDatabase(键/值 store) 与 FMDB, 于是 CCSQLite 在路上.


###  大于版本 1.1.1调整变化
***
![CCSQLite CCSQLiteMac Screenshot](https://github.com/ccworld1000/CCSQLite/blob/master/Documentation/MainAdjust.png?raw=true)

###  Podfile

```ruby
pod 'CCSQLite'
```

***

### 演示

#### for Objective-C
##### see CCSQLiteDemo
##### iOS CCSQLiteiOSDemo
##### OSX CCSQLiteOSXDemo

### for Swift call Objective-C
##### iOS CCSQLiteDataiOS
##### OSX CCSQLiteDatamacOS

### 演示代码
```objective-c
#import <CCSQLite.h>
```
or

```objective-c
#import "CCSQLite.h"
```
or

```objective-c
#import "CCSQLite/CCSQLite.h"
```


```objective-c
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
}

```

### CCKeyValue 演示代码
```objective-c
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
```
结果
![CCKeyValue Screenshot](https://github.com/ccworld1000/CCSQLite/blob/master/Documentation/CCKeyValue.png?raw=true)

### Swift 调用 Objective-C

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CCSQLiteData.writeList()
        if let list = CCSQLiteData.readList() {
            print(list)
        }
    }
```

### MIT 许可证
***

MIT License

Copyright (c) 2016-now ccworld1000 | bug : <a href="mailto:ccworld1000@gmail.com">ccworld1000@gmail.com</a>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

***
### 其他许可证
***

[FMDB LICENSE](LICENSE/LICENSE.FMDB.txt) 

[YapDatabase LICENSE](LICENSE/LICENSE.YapDatabase.txt) 

