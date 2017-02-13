###### CCSQLite for iOS && OSX (A Cocoa / Objective-C wrapper around SQLite. YapDatabase(key/value store) + FMDB (ARC))
=======================
[![Apps Using](https://img.shields.io/cocoapods/at/CCSQLite.svg?label=Apps%20Using%20CCSQLite&colorB=28B9FE)](http://cocoapods.org/pods/CCSQLite) [![Downloads](https://img.shields.io/cocoapods/dt/CCSQLite.svg?label=Total%20Downloads&colorB=28B9FE)](http://cocoapods.org/pods/CCSQLite)

[![Platform](https://img.shields.io/badge/platforms-iOS%20%7C%20OSX-orange.svg)](https://github.com/ccworld1000/CCSQLite.git)
[![Languages](https://img.shields.io/badge/languages-ObjC-orange.svg)](https://github.com/ccworld1000/CCSQLite)

[![Version](https://img.shields.io/cocoapods/v/CCSQLite.svg)](https://github.com/ccworld1000/CCSQLite.git)
[![License](https://img.shields.io/cocoapods/l/CCSQLite.svg)](https://github.com/ccworld1000/CCSQLite/blob/master/LICENSE/LICENSE.CCSQLite.txt)


support MAC OSX and iOS

[https://github.com/ccworld1000/CCSQLite.git](https://github.com/ccworld1000/CCSQLite.git)

##bug 
Email ： <a href="mailto:ccworld1000@gmail.com">ccworld1000@gmail.com</a>

***
# CCSQLite
***
目的 : YapDatabase(key/value store) + FMDB

[英文README](README.md)

***
# 缘由 && 为啥
***
当我在写"HSCache [缓存处理方面]", 想选择FMDB或者YapDatabase, 但是他们看起来不一样. 因此想结合YapDatabase(键/值 store) 与 FMDB, 于是 CCSQLite 在路上.

# 引用
[FMDB](https://github.com/ccgus/fmdb) 

[YapDatabase](https://github.com/yapstudios/YapDatabase)

***
# 目的
* 转变 FMDB 到 ARC 模式
* YapDatabase 键/值 store 
* CCSQLite 结合 FMDB 和 YapDatabase 键/值 

***

# 调整变化
***
![HSFont HSFontMac Screenshot](https://github.com/ccworld1000/CCSQLite/blob/master/Documentation/MainAdjust.png?raw=true)

***
# 用法 && 迁移
***

[用法 : 类似 FMDB, 只要替换 "FM\*" 成 "CC\*"] (https://github.com/ccgus/fmdb/blob/master/README.markdown)

[更多详细](https://github.com/ccworld1000/CCSQLite/blob/master/Documentation/MainAdjust.png?raw=true)

***
# 演示
###see CCSQLiteDemo/

###iOS CCSQLiteiOSDemo

###OSX CCSQLiteOSXDemo

# MIT许可证
***

MIT License

Copyright (c) 2016-2017 ccworld1000 | bug : <a href="mailto:ccworld1000@gmail.com">ccworld1000@gmail.com</a>

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
# 其他许可证
***

[FMDB LICENSE](LICENSE/LICENSE.FMDB.txt) 

[YapDatabase LICENSE](LICENSE/LICENSE.YapDatabase.txt) 
