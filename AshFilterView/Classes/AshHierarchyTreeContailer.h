//
//  Ash AshHierarchyTreeContailer.h
//  OCTest
//
//  Created by 陈震 on 2018/3/9.
//  Copyright © 2018年 陈震. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AshHierachyViewModel.h"

@interface AshHierarchyTreeContailer : UIView{
    @private
    NSMutableArray<NSMutableArray<NSNumber *> *> *_selectedRowNumbers;
    NSInteger _depth;

    @protected
    NSMutableArray<AshHierachyViewModel *> *_treeData;
}

/**
 整个树状图的层次
 max is 3
 min is 2
 defalut is 2
 */
@property(assign ,nonatomic) NSInteger depth;

@property(nonatomic ,copy) NSArray<AshHierachyViewModel *> *treeData;
@property(nonatomic ,readonly) NSArray<NSArray<NSNumber *> *> *selectedRowNumbers;

- (instancetype)initWithFrame:(CGRect)frame;

@end
