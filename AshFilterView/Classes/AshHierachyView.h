//
//  AshHierachyView.h
//  AshFilterView
//
//  Created by 陈震 on 2018/3/19.
//

#import <UIKit/UIKit.h>
#import "AshHierarchyTreeContailer.h"


@protocol AshHierachyViewDelegate;

@interface AshHierachyView : UIView

@property(nonatomic ,readonly) AshHierarchyTreeContailer *treeContainer;
@property(nonatomic ,weak) id<AshHierachyViewDelegate> delegate;

+ (instancetype)defaultHierachyView;

@end

@protocol AshHierachyViewDelegate

- (void)onHierachyViewDidPressedEnsure:(AshHierachyView *) hierachyView;
- (void)onHierachyViewDidPressedReset:(AshHierachyView *) hierachyView;

@end


