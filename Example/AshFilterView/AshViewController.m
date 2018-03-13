//
//  AshViewController.m
//  AshFilterView
//
//  Created by terry ash on 12/26/2017.
//  Copyright (c) 2017 terry ash. All rights reserved.
//

#import "AshViewController.h"
#import <AshFilterView/AshHierarchyTreeContailer.h>
#import <FrameAccessor/FrameAccessor.h>
#import <MJExtension/MJExtension.h>
@interface AshViewController ()

@end

@implementation AshViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightTextColor];
    [self _createTripleTree];
    [self _createDoubeTree];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    AshHierarchyTreeContailer *container = [[AshHierarchyTreeContailer alloc] initWithFrame:self.view.frame];
    container.height *= .4;
    container.depth = 2;
    container.top =self.view.height *.5;
    container.treeData = vms;
    [self.view addSubview:container];
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
    
    AshHierarchyTreeContailer *container = [[AshHierarchyTreeContailer alloc] initWithFrame:self.view.frame];
    container.height *= .4;
    container.depth = 3;
    container.treeData = vms;
    [self.view addSubview:container];
}

@end
