//
//  AshHierachyView.m
//  AshFilterView
//
//  Created by 陈震 on 2018/3/19.
//

#import "AshHierachyView.h"
#import "FrameAccessor.h"

@implementation AshHierachyView
@synthesize treeContainer = _treeContainer;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGRect defaultFrame =  CGRectMake(0, 0,width , 310);
        _treeContainer = [[AshHierarchyTreeContailer alloc] initWithFrame:defaultFrame];
        [self addSubview:_treeContainer];
    }
    return self;
}

+ (instancetype)defaultHierachyView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    AshHierachyView *hierachyView = [[AshHierachyView alloc] initWithFrame:CGRectMake(0, 0, width, 310 + 50)];
    
    UIButton *resetButton = [hierachyView _createResetButton];
    resetButton.left = 15;
    resetButton.bottom = hierachyView.height - 10;;
    [hierachyView addSubview:resetButton];
    
    UIButton *ensureBUtton = [hierachyView _createEnsureButton];
    ensureBUtton.right = hierachyView.right - 15;
    ensureBUtton.bottom = resetButton.bottom;
    [hierachyView addSubview:ensureBUtton];
    return hierachyView;
}


- (UIButton *)_createResetButton{
    CGRect frame = CGRectMake(0,
                              0,
                              self.width * .5 - 20,
                              35 );
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.layer.cornerRadius = frame.size.height * .5;
    btn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [btn setTitle:@"重置" forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(onPressedReset)
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIButton *)_createEnsureButton{
    CGRect frame = CGRectMake(0,
                              0,
                              self.width * .5 - 20,
                              35 );
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(onPressedEnsureBtn)
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark handler
- (void)onPressedReset{
    [self.treeContainer reset];
    if (self.delegate) {
        [self.delegate onHierachyViewDidPressedReset:self];
    }
}

- (void)onPressedEnsureBtn{
    if (self.delegate) {
        [self.delegate onHierachyViewDidPressedEnsure:self];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
