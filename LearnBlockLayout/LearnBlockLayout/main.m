//
//  main.m
//  LearnBlockLayout
//
//  Created by ios on 2019/1/25.
//  Copyright © 2019年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

int height = 180;

typedef void(^YZBlock)(void);
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        static int age = 10;
        YZBlock block = ^{
            NSLog(@"hello age : %i",height);
        };
        block();
    }
    return 0;
}
