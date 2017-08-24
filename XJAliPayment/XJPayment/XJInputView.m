//
//  XJInputView.m
//  XJAliPayment
//
//  Created by 肖吉 on 2017/8/23.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJInputView.h"

@interface XJInputView()
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UITextField *inputTextF;
@end
@implementation XJInputView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = XJPayment_LineH;
    self.layer.borderColor = [XJPayment_LineColor CGColor];
    
    self.inputTextF = [[UITextField alloc] init];
    self.inputTextF.frame = self.bounds;
    self.inputTextF.textColor = [UIColor clearColor];
    self.inputTextF.tintColor =[UIColor clearColor];
    self.inputTextF.keyboardType = UIKeyboardTypeNumberPad;
    [self.inputTextF addTarget:self action:@selector(inputValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.inputTextF];
    [self.inputTextF becomeFirstResponder];
    
    CGFloat inputWidth = (XJKScreen_Width - 2*XJPayment_Padding)/XJPayment_PsdCount;
    CGFloat inputPaddingLeft = (inputWidth-XJPayment_CircleWidth)/2.0f;
    CGFloat inputPaddingTop = (XJPayment_InputH-XJPayment_CircleWidth)/2.0f;
    for (int i = 0; i < XJPayment_PsdCount; i++) {
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(inputWidth*i, 0, XJPayment_LineH, XJPayment_InputH);
        lineView.backgroundColor = XJPayment_LineColor;
        [self addSubview:lineView];
        
        UILabel *circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(inputWidth*i+inputPaddingLeft, inputPaddingTop, XJPayment_CircleWidth, XJPayment_CircleWidth)];
        circleLabel.hidden = YES;
        circleLabel.backgroundColor = [UIColor blackColor];
        circleLabel.layer.masksToBounds = YES ;
        circleLabel.layer.cornerRadius = XJPayment_CircleWidth/2.0f;
        [self addSubview:circleLabel];
        [self.resultArray addObject:circleLabel];
    }
}

//输入值改变
-(void)inputValueChanged:(UITextField *)textFiled
{
    if (self.inputTextF.text.length == self.resultArray.count) {
        if ([self.delegate respondsToSelector:@selector(endInputPayPsd:)]) {
            [self.inputTextF resignFirstResponder];
            [self.delegate endInputPayPsd:self.inputTextF.text];
        }
        return;
    }
    for (int i = 0; i<self.resultArray.count; i++) {
        UILabel *circleLabel = self.resultArray[i];
        if (i < self.inputTextF.text.length) {
            circleLabel.hidden = NO;
        }else{
            circleLabel.hidden = YES;
        }
    }
}

-(NSMutableArray *)resultArray
{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}
@end
