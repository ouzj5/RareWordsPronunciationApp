//
//  Record.m
//  final
//
//  Created by 区梓俊 on 2019/12/20.
//  Copyright © 2019 区梓俊. All rights reserved.
//
#import "Record.h"
#import <Foundation/Foundation.h>

@implementation Record
-(id)initWithType:(NSInteger)type {
    NSLog(@"%ld",type);
    self = [super init];
    _input_prefix = @"";
    _output_prefix = @"";
    _recordType = type;
    _num = [self getNum];
    return self;
}
-(NSInteger)getNum {
    NSInteger ret = 0;
    NSFileManager *fm =  [NSFileManager defaultManager];
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    for (int i = 0; i < 1000; i ++ ) {
            NSString *path = [[NSString alloc] initWithFormat:@"%@/t%ld%d", cache, _recordType, i];
        if ([fm fileExistsAtPath:path]) {
            ret ++;
        } else {
            break;
        }
    }
    return ret;
}
-(void)addRecord:(NSString *)str outcome:(NSString *)output{
    
    NSString *str2 = [_input_prefix stringByAppendingString:str];
    NSString *str1 = [_output_prefix stringByAppendingString:output];
    NSFileManager *fm =  [NSFileManager defaultManager];
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *path = [[NSString alloc] initWithFormat:@"%@/t%ld%ld", cache, _recordType, _num];
    
    _num ++;
    NSData *data = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"add %@", str1);
    [data writeToFile:path atomically:YES];
    
    NSString *path1 = [[NSString alloc] initWithFormat:@"%@/t%ld%ld", cache, _recordType, _num];
    _num ++;
    NSData *data1 = [str2 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"add %@", path1);
    [data1 writeToFile:path1 atomically:YES];
}

-(NSMutableArray *)getRecord {
    NSLog(@"num: %ld", _num);
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSFileManager *fm =  [NSFileManager defaultManager];
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    for (long i = _num - 1; i >= 0; i -- ) {
        NSString *path = [[NSString alloc] initWithFormat:@"%@/t%ld%ld", cache, _recordType, i];
        if ([fm fileExistsAtPath:path]) {
            NSData *data;
            data = [NSData dataWithContentsOfFile:path];
            [arr addObject:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
        } else {
            break;
        }
    }
    return arr;
}
-(void)delRecord {
    for (int i = 0; i < _num; i ++ ) {
        NSFileManager *fm =  [NSFileManager defaultManager];
        NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        NSString *path = [[NSString alloc] initWithFormat:@"%@/t%ld%d", cache, _recordType, i];
        [fm removeItemAtPath:path error:nil];
    }
    _num = 0;
}
@end
