//
//  NSObject+LJRModel.m
//  RuntimeModel
//
//  Created by lujianrong on 16/7/2.
//  Copyright © 2016年 LJR. All rights reserved.
//
/**
   KVC 是把网络请求来的参数,和模型属性匹配(--容易少属性)
   runtime 是把模型属性, 和请求的参数匹配(安全)
 */

#import "NSObject+LJRModel.h"

#import <objc/message.h>

@implementation NSObject (LJRModel)
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    
    unsigned int outCount = 0, i;
    Ivar *ivarList = class_copyIvarList(self, &outCount);
    
    for (i = 0; i < outCount; i++) {
        //获取成员变量属性
        Ivar ivar = ivarList[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        NSString *key = [propertyName substringFromIndex:1];
        
        id value = dict[key];
        
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) {//二级 model 转换
            //字典转换成模型
            // 转换成哪个类型
            
            // @"@\"User\"" User
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            // User\"";
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            
            // 字符串截取
            // 获取需要转换类的类对象
            Class subClass =  NSClassFromString(propertyType);
            if (subClass) {
                value =  [subClass modelWithDict:value];
            }
        }
        
        if (value) {
            // 给模型赋值 (KVC 不能传 nil)
            [objc setValue:value forKey:key];
        }
        
        
    }
    return objc;
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

@end
