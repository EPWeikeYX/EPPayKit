//
//  AppDelegate+EPPayKit.m
//  EPPayKit_Example
//
//  Created by Jarhom on 2019/2/23.
//  Copyright © 2019 陈家宏. All rights reserved.
//

#import "AppDelegate+EPPayKit.h"
#import <objc/runtime.h>
#import "UPPaymentControl.h"
#import "WXApi+XWAdd.h"
#import "AlipaySDK+XWAdd.h"
#import "EPPayKit.h"



@implementation AppDelegate (EPPayKit)

+(void)load
{
    
    Method openURLMethod = class_getClassMethod(self, @selector(application:openURL:options:));
    
    Method myOpenURLMethod = class_getClassMethod(self, @selector(eppay_application:openURL:options:));
    
    //交换
    method_exchangeImplementations(openURLMethod, myOpenURLMethod);
}


- (BOOL)eppay_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
    [WXApi xwAdd_handleOpenURL:url];
    [AlipaySDK xwAdd_handleOpenURL:url];
    
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        

        if([code isEqualToString:@"success"]) {
            
            //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
            if(data != nil){
                //数据从NSDictionary转换为NSString
                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:nil];
                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                
                //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
                if ([EPPayKit shareInstance].upcallback) {
                    //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
                    [EPPayKit shareInstance].upcallback(YES,sign);
                }
            }
            
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
            if ([EPPayKit shareInstance].upcallback) {
                //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
                [EPPayKit shareInstance].upcallback(NO,nil);
            }
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
            [EPPayKit shareInstance].upcallback(NO,nil);
        }
    }];
    
    
    return [self eppay_application:app openURL:url options:options];
}


@end
