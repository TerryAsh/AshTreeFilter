//
//  AshHierachyViewModel.h
//  OCTest
//
//  Created by 陈震 on 2018/3/9.
//  Copyright © 2018年 陈震. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AshHierachyViewModel : NSObject

@property(nonatomic ,copy) NSString *id;
@property(nonatomic ,copy) NSString *name;
@property(nonatomic ,copy) NSArray<AshHierachyViewModel *> *leafs;

@property(nonatomic ,readonly) BOOL isLeafNode;//nodes without leafs

@end
