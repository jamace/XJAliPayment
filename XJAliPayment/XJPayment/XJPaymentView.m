//
//  XJPaymentView.m
//  XJAliPayment
//
//  Created by 肖吉 on 2017/8/23.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJPaymentView.h"
#import "XJKeyboradHeader.h"
#import "XJPaymentHeader.h"
#import "XJInputView.h"

@interface XJPaymentView()<XJInputViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) XJInputView *inputView;
@property (nonatomic, strong) UIButton *forgetPadBtn;
@end
@implementation XJPaymentView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

//子控件
-(void)initSubviews
{
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.alpha = 0.95;
    [self addSubview:self.contentView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"closeh"] forState:UIControlStateHighlighted];
    [self.backBtn addTarget:self action:@selector(backbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.backBtn];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"请输入支付密码";
    [self.contentView addSubview:self.titleLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = XJPayment_LineColor;
    [self.contentView addSubview:self.lineView];
    
    self.inputView = [[XJInputView alloc] initWithFrame:CGRectMake(XJPayment_Padding, XJPayment_Top+2*XJPayment_Padding, XJKScreen_Width - 2*XJPayment_Padding, XJPayment_InputH)];
    self.inputView.delegate = self;
    [self.contentView addSubview:_inputView];
    
    self.forgetPadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.forgetPadBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.forgetPadBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    self.forgetPadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.forgetPadBtn addTarget:self action:@selector(forgetPadBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.forgetPadBtn];
    
    [self setViewFrame];

}

#pragma mark --- 忘记密码
-(void)forgetPadBtnClick
{
    [self paymentViewHidden];
    if ([self.delegate respondsToSelector:@selector(forgetPayPsd)]) {
        [self.delegate forgetPayPsd];
    }
}
#pragma mark --- 输入支付密码的回调
-(void)endInputPayPsd:(NSString *)psd
{
    [self paymentViewHidden];
    if ([self.delegate respondsToSelector:@selector(successInputPayPsd:)]) {
        [self.delegate successInputPayPsd:psd];
    }
}
-(void)setViewFrame
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.contentView.frame = CGRectMake(0, XJKScreen_Height, XJKScreen_Width, XJPayment_Height);
    self.backBtn.frame = CGRectMake(XJPayment_Padding, XJPayment_Padding, 20, 20);
    self.titleLabel.frame = CGRectMake(50, 0, XJKScreen_Width - 100, XJPayment_Top);
    self.lineView.frame = CGRectMake(0, XJPayment_Top, XJKScreen_Width, XJPayment_LineH);
    self.forgetPadBtn.frame = CGRectMake(XJPayment_Padding, XJPayment_Top+3*XJPayment_Padding+XJPayment_InputH,XJKScreen_Width - 2*XJPayment_Padding, XJPayment_Padding);

}
-(void)backbtnClick
{
    [self paymentViewHidden];
}
-(void)paymentViewShow
{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -XJPayment_Height);
    }];
}
-(void)paymentViewHidden
{
    [self.inputView endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, XJPayment_Height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.contentView removeFromSuperview];
        self.contentView = nil;
    }];
}
@end
