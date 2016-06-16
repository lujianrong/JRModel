//
//  JRModel.m
//  JRKit
//
//  Created by lujianrong on 16/5/24.
//  Copyright © 2016年 lujianrong. All rights reserved.
//

#import "JRModel.h"
#import <objc/runtime.h>
@implementation JRModel

- (instancetype)initWithName:(NSString *)name price:(NSString *)price {
    if (self = [super init]) {
        _name = name;
        _price = price;
    }
    return self;
}

+ (id)modelWithName:(NSString *)name price:(NSString *)price {
    return [[self alloc] initWithName:name price:price];
}
#pragma mark
#pragma mark - KVC
+ (id)modelWithDict:(NSDictionary *)dict {
    JRModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"id"]) {
        //self.u_id = value;
    }
}
#pragma mark
#pragma mark - runtime - description
- (NSString *)description {
    NSMutableString *description_string = @"".mutableCopy;
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [self valueForKeyPath:key];
            [description_string appendString:[NSString stringWithFormat:@"%@ -> %@\n", key, value]];
        }
    }
    free(ivars);
    return description_string;
}


#pragma mark
#pragma mark - NSCoding - runtime - 归档 解档
- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count = 0;
    //取出JRModel这个对象的所有属性
    Ivar *ivars = class_copyIvarList([self class], &count);
    //对所有属性进行遍历
    for (int i = 0; i < count; i++) {
        // 取出i位置对应的成员变量
        @autoreleasepool {
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            [coder encodeObject:[self valueForKeyPath:key] forKey:key];
        }
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            @autoreleasepool {
                Ivar ivar = ivars[i];
                // 查看成员变量
                const char *name = ivar_getName(ivar);
                // 归档
                NSString *key = [NSString stringWithUTF8String:name];
                id value = [decoder decodeObjectForKey:key];
                // 设置到成员变量身上
                [self setValue:value forKey:key];
            }
        }
        free(ivars);
    }
    return self;
}

@end
