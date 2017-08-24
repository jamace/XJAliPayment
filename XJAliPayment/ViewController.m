//
//  ViewController.m
//  XJAliPayment
//
//  Created by 肖吉 on 2017/8/23.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "ViewController.h"
#import "XJPaymentView.h"
#import "XJKeyBoradView.h"
@interface ViewController ()<XJPaymentViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextF;
@property (strong, nonatomic) XJPaymentView *pamentView;
- (IBAction)sureBtnClick:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputTextF.inputView = [[XJKeyBoradView alloc] init];
}

//确定
- (IBAction)sureBtnClick:(UIButton *)sender {
    [self.inputTextF resignFirstResponder];
    //重复点击问题
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(surePay) object:nil];
    [self performSelector:@selector(surePay) withObject:nil afterDelay:0.3];
}
-(void)surePay
{
    XJPaymentView *paymentView = [[XJPaymentView alloc] init];
    paymentView.delegate = self;
    [paymentView paymentViewShow];
    self.pamentView = paymentView;
}
//忘记密码
-(void)forgetPayPsd
{
    self.inputTextF.text = [NSString stringWithFormat:@"忘记密码"];
}

//成功输入支付密码
-(void)successInputPayPsd:(NSString *)psd
{
    self.inputTextF.text = [NSString stringWithFormat:@"支付密码为：%@",psd];

}

@end
