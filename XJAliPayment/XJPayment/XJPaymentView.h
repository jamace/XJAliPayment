//
//  XJPaymentView.h
//  XJAliPayment
//
//  Created by 肖吉 on 2017/8/23.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJPaymentViewDelegate <NSObject>

-(void)successInputPayPsd:(NSString *)psd;
-(void)forgetPayPsd;

@end
@interface XJPaymentView : UIView
@property (nonatomic, assign) id<XJPaymentViewDelegate>delegate;
-(void)paymentViewShow;
-(void)paymentViewHidden;
@end
