//
//  AshViewController.m
//  AshFilterView
//
//  Created by terry ash on 12/26/2017.
//  Copyright (c) 2017 terry ash. All rights reserved.
//

#import "AshViewController.h"
#import <AshFilterView/AshHierachyView.h>
#import <FrameAccessor/FrameAccessor.h>
#import <MJExtension/MJExtension.h>


@interface AshViewController ()<AshHierachyViewDelegate>

@property(nonatomic ,strong) AshHierachyView *hierachyView;

@end

@implementation AshViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightTextColor];
    //[self _createTripleTree];
    [self _createDoubeTree];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AshHierachyView *)hierachyView{
    if (nil == _hierachyView) {
        _hierachyView = [AshHierachyView defaultHierachyView];
        _hierachyView.delegate = self;
        [self.view addSubview:_hierachyView];
    }
    return _hierachyView;
}

- (void)_createDoubeTree{
    NSArray *datas = @[@{
                           @"id":@"a",
                           @"name":@"a",
                           @"leafs":@[@{
                                          @"id":@"a1",
                                          @"name":@"a1"
                                          },
                                      @{
                                          @"id":@"a2",
                                          @"name":@"a2",
                                          },
                                      @{
                                          @"id":@"a3",
                                          @"name":@"a3"
                                          }]
                           },
                       @{
                           @"id":@"d",
                           @"name":@"d"
                           }];
    NSArray<AshHierachyViewModel *> *vms = [AshHierachyViewModel mj_objectArrayWithKeyValuesArray:datas];
    
    self.hierachyView.treeContainer.depth = 1;
    self.hierachyView.treeContainer.treeData = vms;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [self _createTripleTree];
}

- (void)_createTripleTree{
    NSArray *datas = @[@{
                           @"id":@"a",
                           @"name":@"a",
                           @"leafs":@[@{
                                          @"id":@"a1",
                                          @"name":@"a1"
                                          },
                                      @{
                                          @"id":@"a2",
                                          @"name":@"a2",
                                          @"leafs":@[@{
                                                         @"id":@"a21",
                                                         @"name":@"a21"
                                                         },
                                                     @{
                                                         @"id":@"a22",
                                                         @"name":@"a22"
                                                         },
                                                     @{
                                                         @"id":@"a23",
                                                         @"name":@"a23"
                                                         }],
                                          },
                                      @{
                                          @"id":@"a3",
                                          @"name":@"a3"
                                          }],
                           },
                       @{
                           @"id":@"d",
                           @"name":@"d"
                           }];
    NSArray<AshHierachyViewModel *> *vms = [AshHierachyViewModel mj_objectArrayWithKeyValuesArray:datas];
    
    self.hierachyView.treeContainer.depth = 2;
    self.hierachyView.treeContainer.treeData = vms;
}

#pragma mark--
- (void)onHierachyViewDidPressedEnsure:(AshHierachyView *)hierachyView{
    NSLog(@"%@,%@,%s",hierachyView.treeContainer.selectedAreas,
                      hierachyView.treeContainer.selectedDistrict,
                      __func__);
}

- (void)onHierachyViewDidPressedReset:(AshHierachyView *)hierachyView{
    NSLog(@"%@,%@,%s",hierachyView.treeContainer.selectedAreas,
          hierachyView.treeContainer.selectedDistrict,
          __func__);
}
@end
