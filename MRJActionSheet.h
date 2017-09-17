//
//  KKActionSheet.h
//  BrokerCommunity
//
//  Created by jessen.liu on 15/4/27.
//  Copyright (c) 2015年 kakao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewBase.h"

@class KKActionSheet;

@protocol KKActionSheetDelegate <NSObject>

/** 点击了buttonIndex处的按钮 */
- (void)actionSheet:(KKActionSheet *)actionSheet didClickedButtonAtIndex:(int)buttonIndex;
@optional
- (void)actionSheetDidCancel:(KKActionSheet *)actionSheet;
@end

@interface KKActionSheet : UIViewBase

@property (nonatomic, weak) id<KKActionSheetDelegate> kdelegate;
@property (nonatomic, copy) void (^KKActionSheetClickedBlock)(KKActionSheet *actionSheet, int buttonIndex);

/** Tip: 如果没有红色按钮, redButtonIndex给`-1`即可 
 defColor 特殊颜色的按钮索引
 */
- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs delegate:(id<KKActionSheetDelegate>)delegate;

//带定义按钮颜色的初始化方法
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs delegate:(id<KKActionSheetDelegate>)delegate;
- (void)showWithDarkness:(CGFloat)alpha;
- (void)show;
-(BOOL)isDisplay;
- (void)addDetailText:(NSString*)detailText atIndex:(NSInteger)index;
@end
