//
//  AshHierachyViewModel.m
//  OCTest
//
//  Created by 陈震 on 2018/3/9.
//  Copyright © 2018年 陈震. All rights reserved.
//

#import "AshHierachyViewModel.h"

@implementation AshHierachyViewModel
@synthesize isLeafNode;

- (BOOL)isLeafNode{
    return (self.leafs.count == 0);
}

+ (NSDictionary *)objectClassInArray{
    return @{
             @"leafs" : @"AshHierachyViewModel"
             };
}

@end
