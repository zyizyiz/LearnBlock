//
//  main.m
//  Learn
//
//  Created by ios on 2019/1/2.
//  Copyright © 2019年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyClass : NSObject {
    NSObject *_instanceObj;
}
@end

@implementation MyClass
NSObject *__globalObj = nil;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _instanceObj = [[NSObject alloc]init];
    }
    return self;
}

- (void) test {
    static NSObject *__staticObj = nil;
    __globalObj = [[NSObject alloc]init];
    __staticObj = [[NSObject alloc]init];
    
    NSObject *localObj = [[NSObject alloc]init];
    __block NSObject *blockObj = [[NSObject alloc]init];
    
    typedef void (^MyBlock)(void);
    MyBlock aBlock = ^{
        NSLog(@"%@", __globalObj);
        NSLog(@"%@", __staticObj);
        NSLog(@"%@", _instanceObj);
        NSLog(@"%@", localObj);
        NSLog(@"%@", blockObj);
    };
    // copy 浅拷贝（指针拷贝）
    //修改源对象的属性和行为，不会影响副本对象
    //修改副本对象的属性和行为，不会影响源对象
    aBlock = [[aBlock copy] autorelease];
    aBlock();
    
    NSLog(@"%lu", (unsigned long)[__globalObj retainCount]);
    NSLog(@"%lu", (unsigned long)[__staticObj retainCount]);
    NSLog(@"%lu", (unsigned long)[_instanceObj retainCount]);
    NSLog(@"%lu", (unsigned long)[localObj retainCount]);
    NSLog(@"%lu", (unsigned long)[blockObj retainCount]);
}

@end


NSString *zcount = @"12";
void initblock(){
    int age = 10;
    static int num = 11;
    __block int year = 2018;
    NSString *str = @"new";
    NSMutableString *mutStr = [NSMutableString stringWithFormat:@"mutStr"];
    void(^Block)(void) = ^(void) {
        NSLog(@"%d,%d,%d,%@,%@,%@",age,num,year,str,zcount,mutStr);
    };
    age = 20;
    num = 21;
    year = 2019;
    str = @"year";
    
    NSLog(@"%@",str);
    [mutStr appendString:@"String"];
    NSLog(@"%@",mutStr);
    zcount = @"2";
    Block();
    
    void(^mallocBlock)(void) = ^(void) {
        NSLog(@"13456");
    };
    mallocBlock();
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


