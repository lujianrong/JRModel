//
//  NSObject+LJRProperty.h
//  RuntimeModel
//
//  Created by lujianrong on 16/7/2.
//  Copyright © 2016年 LJR. All rights reserved.
/**
 *  自动生成属性
 */
#import <Foundation/Foundation.h>
/**
 *  [LJRTestModel propertyWithDict:status[0][@"user"]];
 */
@interface NSObject (LJRProperty)
+ (NSString *)propertyWithDict:(NSDictionary *)dict;
@end
