//
//  MRJActionSheet.h
//  BrokerCommunity
//
//  Created by mrjlovetian@gmail.com on 09/17/2017.
//  Copyright (c) 2017 mrjlovetian@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRJActionSheet;

@protocol MRJActionSheetDelegate <NSObject>

/** 点击了buttonIndex处的按钮 */
- (void)actionSheet:(MRJActionSheet *)actionSheet didClickedButtonAtIndex:(int)buttonIndex;
@optional
- (void)actionSheetDidCancel:(MRJActionSheet *)actionSheet;
@end

@interface MRJActionSheet : UIView

@property (nonatomic, weak) id<MRJActionSheetDelegate> kdelegate;
@property (nonatomic, copy) void (^MRJActionSheetClickedBlock)(MRJActionSheet *actionSheet, int buttonIndex);

/** Tip: 如果没有红色按钮, redButtonIndex给`-1`即可 
 defColor 特殊颜色的按钮索引
 */
- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs delegate:(id<MRJActionSheetDelegate>)delegate;

//带定义按钮颜色的初始化方法
- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs delegate:(id<MRJActionSheetDelegate>)delegate;

- (void)showWithDarkness:(CGFloat)alpha;

- (void)show;

- (BOOL)isDisplay;

- (void)addDetailText:(NSString*)detailText atIndex:(NSInteger)index;

@end
