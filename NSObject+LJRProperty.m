//
//  NSObject+LJRProperty.m
//  RuntimeModel
//
//  Created by lujianrong on 16/7/2.
//  Copyright © 2016年 LJR. All rights reserved.


#import "NSObject+LJRProperty.h"

@implementation NSObject (LJRProperty)

+ (NSString *)propertyWithDict:(NSDictionary *)dict {
    
    NSMutableString *propertyStr = @"".mutableCopy;
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id propertyName, id value, BOOL * stop) {
        NSString *tempProperty;
        
        //NSLog(@"\nclass--> %@\nvalue-> %@\n\n", [value class], value);
        
        if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]) {
            
            tempProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;", propertyName];
            
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            
            tempProperty = [NSString stringWithFormat:@"@property (nonatomic,    copy) NSString *%@;", propertyName];
            
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            
            tempProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) NSNumber *%@;", propertyName];
            
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
            
            tempProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;", propertyName];
            
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            
             tempProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;", propertyName];
            
        }
        
        [propertyStr appendFormat:@"\n%@\n", tempProperty];
        
    }];
    
    /** 打印出来就好了 */
    NSLog(@"\n %@", propertyStr);
    
    return propertyStr;
}

@end
