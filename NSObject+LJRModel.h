//
//  NSObject+LJRModel.h
//  RuntimeModel
//
//  Created by lujianrong on 16/7/2.
//  Copyright © 2016年 LJR. All rights reserved.
// runtime 取 model

#import <Foundation/Foundation.h>

@interface NSObject (LJRModel)
/**
 for (NSDictionary *dict in status) {
    LJRTestModel *model = [LJRTestModel modelWithDict:dict];
    //NSLog(@"\n %@", model);
    NSLog(@"\n %@", model.user.profile_image_url);
 } 
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
