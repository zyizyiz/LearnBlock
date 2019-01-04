//
//  main.m
//  Learn
//
//  Created by ios on 2019/1/2.
//  Copyright © 2019年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>

// MRC模式下使用
//@interface MyClass : NSObject {
//    NSObject *_instanceObj;
//}
//@end
//
//@implementation MyClass
//NSObject *__globalObj = nil;
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _instanceObj = [[NSObject alloc]init];
//    }
//    return self;
//}
//
//- (void) test {
//    static NSObject *__staticObj = nil;
//    __globalObj = [[NSObject alloc]init];
//    __staticObj = [[NSObject alloc]init];
//    
//    NSObject *localObj = [[NSObject alloc]init];
//    __block NSObject *blockObj = [[NSObject alloc]init];
//    
//    typedef void (^MyBlock)(void);
//    MyBlock aBlock = ^{
//        NSLog(@"%@", __globalObj);
//        NSLog(@"%@", __staticObj);
//        NSLog(@"%@", _instanceObj);
//        NSLog(@"%@", localObj);
//        NSLog(@"%@", blockObj);
//    };
//    // copy 浅拷贝（指针拷贝）
//    //修改源对象的属性和行为，不会影响副本对象
//    //修改副本对象的属性和行为，不会影响源对象
//    aBlock = [[aBlock copy] autorelease];
//    aBlock();
//    
//    NSLog(@"%lu", (unsigned long)[__globalObj retainCount]);
//    NSLog(@"%lu", (unsigned long)[__staticObj retainCount]);
//    NSLog(@"%lu", (unsigned long)[_instanceObj retainCount]);
//    NSLog(@"%lu", (unsigned long)[localObj retainCount]);
//    NSLog(@"%lu", (unsigned long)[blockObj retainCount]);
//}
//
//@end



@interface People:NSObject

// 姓名
@property(nonatomic,copy)NSString *name;
// 年龄
@property(nonatomic,assign)int age;
@end

@implementation People

@end

NSString *zcount = @"12";
void initblock(){
    // 基本类型
    int age = 10;
    // 静态变量
    static int num = 11;
    // __block修饰 将对象变为Block的结构体
    __block int year = 2018;
    // 不可变对象
    NSString *str = @"new";
    // 可变对象
    NSMutableString *mutStr = [NSMutableString stringWithFormat:@"mutStr"];
    // 自定义对象
    People *man = [People new];
    [man setName:@"张三"];
    [man setAge:20];
    
    // Block 捕获临时变量 值传递
    // ARC __NSMallocBlock__ 堆上
    // MRC __NSStackBlock__
    void(^assignBlock)(void) = ^(void) {
        // 10
        NSLog(@"age : %d",age);
    };
    
    age = 20;
    assignBlock();
    
    num = 21;
    // __NSGlobalBlock__ 全局 调用的static变量 指针传递
    void(^staticBlock)(void) = ^(void) {
        // 21
        NSLog(@"%d",num);
    };
    staticBlock();
    
    year = 2019;
    // ARC __NSMallocBlock__ 堆上
    // MRC __NSStackBlock__
    void(^blockBlock)(void) = ^(void) {
        // 2019
        NSLog(@"%d",year);
    };
    blockBlock();
    
    
    // ARC __NSMallocBlock__ 堆上
    // MRC __NSStackBlock__
    void(^strBlock)(void) = ^(void) {
        // new
        NSLog(@"block : %@",str);
    };
    // 更改str 地址已经改变
    str = @"year";
    NSLog(@"%@",str);
    strBlock();
    
    // Block 捕获临时变量
    // ARC __NSMallocBlock__ 堆上
    // MRC __NSStackBlock__
    void(^mutStrBlock)(void) = ^(void) {
        // mutStrString
        NSLog(@"block : %@",mutStr);
    };
    // 更改mutStr 地址不改变
    [mutStr appendString:@"String"];
    NSLog(@"%@",mutStr);
    mutStrBlock();
    
    // __NSGlobalBlock__
    void(^zcountBlock)(void) = ^(void) {
        // 2
        NSLog(@"block : %@",zcount);
    };
    // 更改全局变量 zcount
    zcount = @"2";
    zcountBlock();
    
    // ARC __NSMallocBlock__ 不捕获自定义对象
    // MRC __NSStackBlock__
    void(^customObjectBlock)(void) = ^(void) {
        // 李四,30
        NSLog(@"%@,%d",man.name,man.age);
    };
    [man setAge:30];
    [man setName:@"李四"];
    customObjectBlock();
    
    
    // ARC __NSMallocBlock__ 堆上
    // MRC __NSStackBlock__
    void(^MallocBlock)(void) = ^(void) {
        // block : 2,20
        NSLog(@"block : %@,%d",zcount,age);
    };
    MallocBlock();
    
    // __NSGlobalBlock__
    void(^GlobalBlock)(void) = ^(void) {
        NSLog(@"13456");
    };
    GlobalBlock();
    
    // ARC MRC __NSStackBlock__
    NSLog(@"%@",^{
        NSLog(@"%d",age);
    });
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Block捕获变量
        initblock();
        
        // 引用计数变化
//        MyClass *myClass = [[MyClass alloc]init];
//        [myClass test];

        
    }
    return 0;
}


