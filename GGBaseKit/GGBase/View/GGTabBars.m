//
//  GGTabBars.m
//  GGBaseKit
//
//  Created by Mac on 2018/5/29.
//  Copyright © 2018年 Mr.Gao. All rights reserved.
//

#import "GGTabBars.h"

@interface GGTabBars ()
@property (nonatomic, weak) UIButton *centerButton;
@property (nonatomic, assign) UIEdgeInsets oldSafeAreaInsets;
@end

@implementation GGTabBars

- (void)safeAreaInsetsDidChange{
    [super safeAreaInsetsDidChange];
    if (self.oldSafeAreaInsets.left != self.safeAreaInsets.left ||
        self.oldSafeAreaInsets.right != self.safeAreaInsets.right ||
        self.oldSafeAreaInsets.top != self.safeAreaInsets.top ||
        self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom) {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
}

- (CGSize)sizeThatFits:(CGSize)size{
    CGSize s = [super sizeThatFits:size];
    if (@available(iOS 11.0 , *)) {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if (bottomInset>0 && self.height < 50) {
            s.height += bottomInset;
        }
    }
    return s;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setBackgroundImage:[UIImage new]];
//        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        //添加中间按钮
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_mega45"] forState:UIControlStateNormal];
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_mega45"] forState:UIControlStateHighlighted];
        [centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        centerButton.size = centerButton.currentBackgroundImage.size;
        [self addSubview:centerButton];
        self.centerButton = centerButton;
    }
    return self;
}

- (void)centerButtonClick{
//    ViewController *publish = [[ViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //标记按钮是否已经添加过监听器
    static BOOL added = NO;
    
    CGFloat height = self.height;
    CGFloat width  = self.width;
    
    //适配ios11
    if (@available(iOS 11.0 , *)) {
        height -= self.safeAreaInsets.bottom;
    }
    
    //设置中间按钮中心点
    self.centerButton.center = CGPointMake(width * 0.5, 0.2 * height);
    
    //设置其他item的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width/5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.centerButton)
            continue;
        
        //计算按钮的X值
        CGFloat buttonX = buttonW  * ((index > 1) ? (index + 1) :index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index++;
        if (added == NO) {
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;
}

- (void)buttonClick{
    /** 选中除了中间按钮，其他4个按钮的时候发出的通知，比如重复点击的时候让页面做刷新处理 **/
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarDidSelectNotification" object:nil userInfo:nil];
}

////重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.centerButton];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.centerButton pointInside:newP withEvent:event]) {
            return self.centerButton;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
