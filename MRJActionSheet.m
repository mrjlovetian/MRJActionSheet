//
//  MRJActionSheet.m
//  BrokerCommunity
//
//  Created by mrjlovetian@gmail.com on 09/17/2017.
//  Copyright (c) 2017 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJActionSheet.h"
#import "UIImage+Color.h"

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
                     delegate:(id<MRJActionSheetDelegate>)delegate
{
    return [self initWithTitle:title titleColor:[UIColor KK_Gray33] buttonTitles:titles redButtonIndex:buttonIndex defColor:indexs delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                 buttonTitles:(NSArray *)titles
               redButtonIndex:(int)buttonIndex
                     defColor:(NSArray *)indexs
                     delegate:(id<KKActionSheetDelegate>)delegate;
{
    
    if (self = [super init]) {
        
        _kdelegate = delegate;
        
        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        darkView.userInteractionEnabled = YES;
        darkView.backgroundColor = colorWithHexString(@"313131");//LCColor(46, 49, 50);
        darkView.alpha = 0;
        darkView.frame = (CGRect){0, 0, SCREEN_SIZE};
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        // 所有按钮的底部view
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = colorWithHexString(COLOR_BG_MAGIN);//LCColor(242, 242, 242);
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        if (title) {
            
            // 标题
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.font = KKShare.font12;
            label.textColor = colorWithHexString(@"b2b1b1");//LCColor(111, 111, 111);
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake(0, 0, SCREEN_SIZE.width, BUTTON_H);
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
                btn.titleLabel.font = KKShare.font16;
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                UIColor *cuTitleColor = nil;
                if (i == buttonIndex) {
                    cuTitleColor = [UIColor KK_Red];//colorWithHexString(@"ff0a0a");//LCColor(255, 10, 10);
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
                    cuTitleColor = colorWithHexString(@"aeaeae");//LCColor(173, 174, 174);
                }
                [btn setTitleColor:cuTitleColor forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xdddddd) size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                CGFloat btnY = BUTTON_H * (i + (title ? 1 : 0));
                btn.frame = CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H);
                [bottomView addSubview:btn];
            }
            
            for (int i = 0; i < titles.count; i++) {
                
                // 所有线条
                UIView *line = [[UIView alloc] init];
                line.backgroundColor = colorWithHexString(SeperatorLineCellColor);//LCColor(225, 225, 225);
                line.contentMode = UIViewContentModeCenter;
                CGFloat lineY = (i + (title ? 1 : 0)) * BUTTON_H;
                line.frame = CGRectMake(0, lineY, SCREEN_SIZE.width, 0.5f);
                [bottomView addSubview:line];
            }
        }
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.tag = titles.count + 1000;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = [KKShare font16];
        [cancelBtn setTitle:@"Cancel".local_basic forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xdddddd) size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btnY = BUTTON_H * (titles.count + (title ? 1 : 0)) + 10.0f;
        cancelBtn.frame = CGRectMake(0, btnY, SCREEN_SIZE.width, BUTTON_H);
        [bottomView addSubview:cancelBtn];
        CGFloat bottomH = (title ? BUTTON_H : 0) + BUTTON_H * titles.count + BUTTON_H + 10.0f;
        bottomView.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, bottomH);
        
        self.frame = (CGRect){0, 0, SCREEN_SIZE};
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}



- (void)didClickBtn:(UIButton *)btn {
    if ([self.kdelegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
        [self.kdelegate actionSheet:self didClickedButtonAtIndex:(int)btn.tag - 1000];
    }
    if (self.KKActionSheetClickedBlock) self.KKActionSheetClickedBlock(self,(int)btn.tag - 1000);
    [self dismiss:nil];
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    if ([self.kdelegate respondsToSelector:@selector(actionSheetDidCancel:)]
        && tap) {
        [self.kdelegate actionSheetDidCancel:self];
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

- (void)didClickCancelBtn {
    
    if ([self.kdelegate respondsToSelector:@selector(actionSheetDidCancel:)]
        ) {
        [self.kdelegate actionSheetDidCancel:self];
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
//                         if ([self.kdelegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:)]) {
//                             [self.kdelegate actionSheet:self didClickedButtonAtIndex:(int)_buttonTitles.count];
//                         }
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

- (void)show {
    [self showWithDarkness:0.4];
}

-(BOOL)isDisplay {
    if (_darkView.alpha > 0) {
        return YES;
    }
    return NO;
}
- (void)addDetailText:(NSString *)detailText atIndex:(NSInteger)index{
   UIButton *btn = [_bottomView viewWithTag:index];
      [btn.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
   NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[btn titleForState:UIControlStateNormal],detailText]];
    [title addAttribute:NSFontAttributeName value:KKShare.font10 range:[title.string rangeOfString:detailText]];
    [title addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x999999) range:[title.string rangeOfString:detailText]];
    [btn setAttributedTitle:title forState:UIControlStateNormal];
//    [btn setTitle:[NSString stringWithFormat:@"%@\n%@",[btn titleForState:UIControlStateNormal],detailText ] forState:UIControlStateNormal];
}
@end
