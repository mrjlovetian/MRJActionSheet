//
//  MRJActionSheet.m
//  BrokerCommunity
//
//  Created by mrjlovetian@gmail.com on 09/17/2017.
//  Copyright (c) 2017 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJActionSheet.h"
#import "UIColor+Additions.h"

#define BUTTON_H 48.0f

@interface MRJActionSheet () {
    NSArray *_buttonTitles;
    UIView *_darkView;
    UIView *_bottomView;
}
@end

@implementation MRJActionSheet

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(int)buttonIndex
                     defColor:(NSArray *)indexs
                     delegate:(id<MRJActionSheetDelegate>)delegate{
    return [self initWithTitle:title titleColor:[UIColor colorWithHexString:@"333333"] buttonTitles:titles redButtonIndex:buttonIndex defColor:indexs delegate:delegate actionSheetClickBlock:nil];
}

- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs actionSheetClickBlock:(MRJActionSheetBlock)actionSheetClickBlock{
    return [self initWithTitle:title titleColor:[UIColor colorWithHexString:@"333333"] buttonTitles:titles redButtonIndex:buttonIndex defColor:indexs delegate:nil actionSheetClickBlock:actionSheetClickBlock];
}

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(int)buttonIndex
                     defColor:(NSArray *)indexs
                     delegate:(id<MRJActionSheetDelegate>)delegate
        actionSheetClickBlock:(MRJActionSheetBlock)actionSheetClickBlock{
    
    if (self = [super init]) {
        
        self.mrjdelegate = delegate;
        self.mrjActionSheetClickBlock = actionSheetClickBlock;
        
        
        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        darkView.userInteractionEnabled = YES;
        darkView.backgroundColor = [UIColor colorWithHexString:@"313131"];//LCColor(46, 49, 50);
        darkView.alpha = 0;
        darkView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        // 所有按钮的底部view
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"ff801a"];//LCColor(242, 242, 242);
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        if (title) {
            // 标题
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorWithHexString:@"b2b1b1"];//LCColor(111, 111, 111);
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, BUTTON_H);
            [bottomView addSubview:label];
        }
        
        if (titles.count) {
            
            _buttonTitles = titles;
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                btn.tag = i + 1000;
                btn.backgroundColor = [UIColor whiteColor];
                 [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
                btn.titleLabel.font = [UIFont systemFontOfSize:17];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                UIColor *cuTitleColor = nil;
                if (i == buttonIndex) {
                    cuTitleColor = [UIColor colorWithHexString:@"ff0a0a"];//colorWithHexString(@"ff0a0a");//LCColor(255, 10, 10);
                } else {
                    cuTitleColor = titleColor;
                }
                BOOL isColor = NO;
                if (indexs) {
                    for (NSNumber *num in indexs) {
                        NSInteger intg = [num integerValue];
                        if (intg == i) {
                            isColor = YES;
                            break;
                        }
                    }
                }
                
                if (isColor) {
                    cuTitleColor = [UIColor colorWithHexString:@"aeaeae"];//LCColor(173, 174, 174);
                }
                [btn setTitleColor:cuTitleColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                CGFloat btnY = BUTTON_H * (i + (title ? 1 : 0));
                btn.frame = CGRectMake(0, btnY, [UIScreen mainScreen].bounds.size.width, BUTTON_H);
                [bottomView addSubview:btn];
            }
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有线条
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];//LCColor(225, 225, 225);
                line.contentMode = UIViewContentModeCenter;
                CGFloat lineY = (i + (title ? 1 : 0)) * BUTTON_H;
                line.frame = CGRectMake(0, lineY, [UIScreen mainScreen].bounds.size.width, 0.5f);
                [bottomView addSubview:line];
            }
        }
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.tag = titles.count + 1000;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
//        [cancelBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xdddddd) size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btnY = BUTTON_H * (titles.count + (title ? 1 : 0)) + 10.0f;
        cancelBtn.frame = CGRectMake(0, btnY, [UIScreen mainScreen].bounds.size.width, BUTTON_H);
        [bottomView addSubview:cancelBtn];
        CGFloat bottomH = (title ? BUTTON_H : 0) + BUTTON_H * titles.count + BUTTON_H + 10.0f;
        bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, bottomH);
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)didClickBtn:(UIButton *)btn {
    if ([self.mrjdelegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [self.mrjdelegate actionSheet:self didClickedButtonAtIndex:(int)btn.tag - 1000];
    }
    if (self.mrjActionSheetClickBlock) self.mrjActionSheetClickBlock(self,(int)btn.tag - 1000);
    [self dismiss:nil];
}

- (void)dismiss:(UITapGestureRecognizer *)tap{
    
    if ([self.mrjdelegate respondsToSelector:@selector(actionSheetDidCancel:)]
        && tap) {
        [self.mrjdelegate actionSheetDidCancel:self];
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         _darkView.alpha = 0;
                         _darkView.userInteractionEnabled = NO;
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         _bottomView.frame = frame;
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                     }];
}

- (void)didClickCancelBtn{
    if ([self.mrjdelegate respondsToSelector:@selector(actionSheetDidCancel:)]){
        [self.mrjdelegate actionSheetDidCancel:self];
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         _darkView.alpha = 0;
                         _darkView.userInteractionEnabled = NO;
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         _bottomView.frame = frame;
                         
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void) showWithDarkness:(CGFloat)alpha{
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         _darkView.alpha = alpha;
                         _darkView.userInteractionEnabled = YES;
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         _bottomView.frame = frame;
                     } completion:nil];
}

- (void)show{
    [self showWithDarkness:0.4];
}

- (BOOL)isDisplay{
    if (_darkView.alpha > 0) {
        return YES;
    }
    return NO;
}

- (void)addDetailText:(NSString *)detailText atIndex:(NSInteger)index{
   UIButton *btn = [_bottomView viewWithTag:index];
      [btn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
   NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[btn titleForState:UIControlStateNormal],detailText]];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:[title.string rangeOfString:detailText]];
//    [title addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:[title.string rangeOfString:detailText]];
    [btn setAttributedTitle:title forState:UIControlStateNormal];
}

@end
