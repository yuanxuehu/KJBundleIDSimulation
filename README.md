# KJBundleIDSimulation
iOS模拟应用包名

## 适用场景
在调试的时候经常某些功能经常需要固定包名，但该包名又不能进行调试时。

## 适用方式

```
//导入头文件
#import "NSBundle+changeBundleId.h"

//模拟包名
[[NSBundle mainBundle] changeBundleIdentifier:@"com.company.fakeBundleId"];

```

## 原理
写一个NSBundle的分类，调用修改包名方法时，将NSBundle类的bundleIdentifier方法和交换为自己实现的方法，该操作每次打开app只会执行一次

