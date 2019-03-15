//
//  EPPayKit.m
//  EPPayKit_Example
//
//  Created by Jarhom on 2019/2/23.
//  Copyright © 2019 陈家宏. All rights reserved.
//

#import "EPPayKit.h"
#import "AlipaySDK+XWAdd.h"
#import "WXApi+XWAdd.h"

@implementation EPPayKit

+ (instancetype)shareInstance {
    
    static EPPayKit *_shareInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _shareInstance = [[EPPayKit alloc] init];
    });
    
    return _shareInstance;
}

/**
 *  微信发起支付（服务端签名版本）
 *
 *  @param appID     申请的APPID
 *  @param partnerId 商户ID
 *  @param prepayId  预支付ID
 *  @param nonceStr  随机字符串
 *  @param timeStamp 时间戳
 *  @param package   打包信息
 *  @param sign      签名信息
 *  @param config    支付完成后的回调（successed = YES 代表支付成功）
 */
- (void)weixin_senPayRequsetWithAppID:(NSString *)appID
                           partnerId:(NSString *)partnerId
                            prepayId:(NSString *)prepayId
                            nonceStr:(NSString *)nonceStr
                           timeStamp:(NSString *)timeStamp
                             package:(NSString *)package
                                sign:(NSString *)sign
                             callback:(void (^)(BOOL successed))callback {
    [WXApi xwAdd_senPayRequsetWithAppID:appID
                              partnerId:partnerId
                               prepayId:prepayId
                               nonceStr:nonceStr
                              timeStamp:timeStamp
                                package:package
                                   sign:sign
                         callbackConfig:callback];
}


/**
 *  发起支付 (服务器端签名版本)
 *
 *  @param orderInfo 服务器签名好的订单信息
 *  @param appScheme 设置的app的URLScheme
 *  @param config    支付完成后的回调（无论是网页版本还是支付宝客户端的版本都通过此block回调）（successed = YES 代表支付成功）
 */
- (void)alipay_sendPayWithOrderInfo:(NSString *)orderInfo
                          appScheme:(NSString *)appScheme
                           callback:(void (^)(BOOL successed))callback {
    [AlipaySDK xwAdd_sendPayWithOrderInfo:orderInfo appScheme:appScheme callbackConfig:callback];
}


/**
 银联发起支付
 
 @param tn 交易流水号，商户后台向银联后台提交订单信息后，由银联后台生成并下发给商户后台的交易凭证；
 @param scheme 商户自定义协议，商户在调用支付接口完成支付后，用于引导支付控件返回而定义的协议，URL Type定义;
 @param mode "00"代表接入生产环境（正式版本需要）；
 "01"代表接入开发测试环境
 @param viewController 发起调用的视图控制器，商户应用程序调用银联手机支付控件的视图控制器
 @param callback 回调
 */
- (void)uppay_startPayWithTN:(NSString *)tn
                  fromScheme:(NSString *)scheme
                        mode:(NSString *)mode
              viewController:(UIViewController *)viewController
                    callback:(UPPayCallback)callback {
    [[UPPaymentControl defaultControl] startPay:tn
                                     fromScheme:scheme
                                           mode:mode
                                 viewController:viewController];
    self.upcallback = callback;

}







@end
