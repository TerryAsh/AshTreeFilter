//
//  Ash AshHierarchyTreeContailer.m
//  OCTest
//
//  Created by 陈震 on 2018/3/9.
//  Copyright © 2018年 陈震. All rights reserved.
//

#import "AshHierarchyTreeContailer.h"
#import <FrameAccessor/FrameAccessor.h>

@interface AshHierarchyTreeContailer()<UITableViewDelegate ,UITableViewDataSource>{
    NSMutableArray<UITableView *> *_tables;
    
    NSArray<NSString *> *_rootKeys;
}

@end

@implementation AshHierarchyTreeContailer
@synthesize treeData = _treeData;
@synthesize depth = _depth;
@synthesize selectedDistrict = _selectedDistrict;
@synthesize selectedAreas = _selectedAreas;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self->_tables = [NSMutableArray new];
        self->_treeData = [NSMutableArray new];
        self->_selectedRowNumbers = [NSMutableArray new];
        self->_depth = 1;
    }
    return self;
}

#pragma mark --getter setter
- (void)setTreeData:(NSArray<AshHierachyViewModel *> *)treeData{
    [_treeData removeAllObjects];
    if (treeData) {
        [self->_treeData addObjectsFromArray:treeData];
    }
    [self _reload];
}

- (AshHierachyViewModel *)selectedDistrict{
    if (self.depth == 1) {
        return  nil;
    }
    __block NSArray<AshHierachyViewModel *> *nodes =  [self _nodesAt:0];
    NSNumber *districtNumber = [self->_selectedRowNumbers[0] firstObject];
    self->_selectedDistrict = nodes[districtNumber.integerValue];
    return self->_selectedDistrict;
}

- (NSArray<AshHierachyViewModel *> *)selectedAreas{
    __block  NSMutableArray<AshHierachyViewModel *> *selectedNodes = [NSMutableArray new];
    NSInteger areaIndex = self.depth > 1 ? 1:0;
    __block NSArray<AshHierachyViewModel *> *nodes =  [self _nodesAt:areaIndex];
    [self->_selectedRowNumbers[areaIndex] enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AshHierachyViewModel *node = nodes[obj.integerValue];
        [selectedNodes addObject:node];
    }];
    return selectedNodes;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark --table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger currentLevel = [self->_tables indexOfObject:tableView];
    NSArray<AshHierachyViewModel *> *nodes = [self _nodesAt:currentLevel];
    return nodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"AshCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger currentLevel = [self->_tables indexOfObject:tableView];
    NSArray<AshHierachyViewModel *> *nodes = [self _nodesAt:currentLevel];
    cell.textLabel.text = nodes[indexPath.row].name;
    
    NSArray<NSNumber *> *numbersSelected = self->_selectedRowNumbers[currentLevel];
    bool isSeleted = [numbersSelected containsObject:@(indexPath.row)];
    cell.textLabel.textColor = isSeleted ? [UIColor redColor] :[UIColor blackColor] ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger currentLevel = [self->_tables indexOfObject:tableView];
    BOOL needsCreareNewTable = (self->_tables.count <= currentLevel + 1);
    if (needsCreareNewTable) {
        if (currentLevel < self.depth-1) {
            [self _addNewTable];
        }
    }
    
    BOOL isSelectedLastTable = (currentLevel == self.depth -1);
    if (isSelectedLastTable) {
        if (![self->_selectedRowNumbers[currentLevel] containsObject:@(indexPath.row)]) {
            [self->_selectedRowNumbers[currentLevel]  addObject:@(indexPath.row)];
        } else {
            [self->_selectedRowNumbers[currentLevel] removeObject:@(indexPath.row)];
        }
        [self->_tables[currentLevel] reloadData];
    } else {
        for (NSInteger i = currentLevel ; i != self.depth; i++) {
            [self->_selectedRowNumbers[i] removeAllObjects];
        }
        [self->_selectedRowNumbers[currentLevel]  addObject:@(indexPath.row)];
        [self->_tables[currentLevel] reloadData];
        [self->_tables[currentLevel + 1] reloadData];
        
        if (self->_tables.count > 2) {
            if (currentLevel == 0) {
                self->_tables.lastObject.hidden = YES;
            } else {//点击中间table
                self->_tables.lastObject.hidden = NO;
            }
        }
    }
    
    [self _adjusteTables];
}

#pragma mark --public
- (void)reset{
    [self _reload];
}

#pragma mark --private

- (NSArray<AshHierachyViewModel *> *)_nodesAt:(NSInteger)level{
    if (0 == level) {
        return self.treeData;
    }
    if (level >= self.depth) {
        return @[];
    }
    NSArray<AshHierachyViewModel *> *nodes = self.treeData;
    for (int i = 0 ; i != level; i++) {
       NSArray<NSNumber *> *selectedRowsAtLevel = self->_selectedRowNumbers[i];
        if (selectedRowsAtLevel.count) {
           NSInteger selectedIndex = selectedRowsAtLevel[0].integerValue;
           nodes = nodes[selectedIndex].leafs;
        } else {
           nodes = @[];
        }
    }
    return nodes;
}

- (void)_reload{
    [self->_selectedRowNumbers removeAllObjects];
    for (int i = 0; i != self.depth; i++) {
        [self->_selectedRowNumbers addObject:[NSMutableArray new]];
    }
    
    [self->_tables removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
   [self _addNewTable];
}

- (UITableView *)_addNewTable{
    UITableView *table = [self _createTable];
    [self->_tables addObject:table];
    [self addSubview:table];
    return table;
}

- (UITableView *)_createTable{
    CGRect frame = CGRectMake(0, 0, self.width, self.height);
    UITableView *table = [[UITableView alloc] initWithFrame:frame
                                                      style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    return table;
}

- (void)_adjusteTables{
    if (self->_tables.lastObject.hidden) {
        self->_tables[1].left = self.width * .5;
    } else {
        CGFloat offset = self.width / self->_tables.count;
        for (int i = 1; i != self->_tables.count; i++) {
            self->_tables[i].left = i * offset;
        }
    }
}

@end
