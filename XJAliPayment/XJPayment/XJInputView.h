//
//  XJInputView.h
//  XJAliPayment
//
//  Created by 肖吉 on 2017/8/23.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJInputViewDelegate <NSObject>

-(void)endInputPayPsd:(NSString *)psd;

@end
@interface XJInputView : UIView
@property (nonatomic, assign)id<XJInputViewDelegate>delegate;
@end
