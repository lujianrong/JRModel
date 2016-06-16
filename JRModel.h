//
//  JRModel.h
//  JRKit
//
//  Created by lujianrong on 16/5/24.
//  Copyright © 2016年 lujianrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+JRCategory.h"
/**
JRModel *model  = [JRModel modelWithName:@"融" price:@"¥30"];
 JRModel *deepCopyModel = [model deepCopy];
 NSLog(@"\n %@ %@", deepCopyModel, model);
 */
@interface JRModel : NSObject <NSCoding>
@property (nonatomic,   copy) NSString   *name;
@property (nonatomic,   copy) NSString   *price;
//@property (nonatomic,   copy) NSString   *u_id;

+ (id)modelWithName:(NSString *)name price:(NSString *)price;
+ (id)modelWithDict:(NSDictionary *)dict;
@end
