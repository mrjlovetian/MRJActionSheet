//
//  MRJActionSheet.h
//  BrokerCommunity
//
//  Created by mrjlovetian@gmail.com on 09/17/2017.
//  Copyright (c) 2017 mrjlovetian@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRJActionSheet;

typedef void(^MRJActionSheetBlock)(MRJActionSheet *actionSheet, int buttonIndex);

@protocol MRJActionSheetDelegate <NSObject>

///点击了buttonIndex处的按钮
- (void)actionSheet:(MRJActionSheet *)actionSheet didClickedButtonAtIndex:(int)buttonIndex;

@optional
///取消按钮被点击
- (void)actionSheetDidCancel:(MRJActionSheet *)actionSheet;

@end

@interface MRJActionSheet: UIView

///代理
@property (nonatomic, weak)id<MRJActionSheetDelegate> mrjdelegate;

///
@property (nonatomic, copy)MRJActionSheetBlock mrjActionSheetClickBlock;

///如果没有红色按钮, redButtonIndex给`-1`即可, defColor 特殊颜色的按钮索引
- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs delegate:(id<MRJActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title buttonTitles:(NSArray *)titles redButtonIndex:(int)buttonIndex defColor:(NSArray *)indexs actionSheetClickBlock:(MRJActionSheetBlock)actionSheetClickBlock;

- (void)showWithDarkness:(CGFloat)alpha;

- (void)show;

- (BOOL)isDisplay;

- (void)addDetailText:(NSString*)detailText atIndex:(NSInteger)index;

@end
