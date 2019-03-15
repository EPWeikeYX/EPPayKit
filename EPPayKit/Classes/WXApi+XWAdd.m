
//
//  WXApi+XWAdd.m
//  yyjx
//
//  Created by wazrx on 16/5/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WXApi+XWAdd.h"
#import <objc/runtime.h>

static NSString *const prePayIDUrl = @"https://api.mch.weixin.qq.com/pay/unifiedorder";

static void * const xwAdd_appID_key = "xwAdd_appID_key";
static void * const xwAdd_callbackConfig_key = "xwAdd_callbackConfig_key";


@interface _XWWxApiDelegateObject : NSObject<WXApiDelegate>

@property (nonatomic, copy) void(^config)(BOOL success);

+ (instancetype)xw_objectWithConfig:(void(^)(BOOL success))config;

@end

@implementation _XWWxApiDelegateObject

+ (instancetype)xw_objectWithConfig:(void(^)(BOOL success))config{
    _XWWxApiDelegateObject *obj = [_XWWxApiDelegateObject new];
    obj.config = config;
    return obj;
}

#pragma mark - <WXApiDelegate>

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        [self _xw_handlePayResq:resp];
    }
}

- (void)_xw_handlePayResq:(BaseResp *)resq{
    if (_config) {
        _config(resq.errCode == WXSuccess);
        _config = nil;
        objc_setAssociatedObject([WXApi class], xwAdd_callbackConfig_key, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

@end



@implementation WXApi (XWAdd)

+ (void)xwAdd_registerWeiXinWithAppID:(NSString *)appID {
    [WXApi registerApp:appID];
    [self _xwAdd_saveValueWithKey:xwAdd_appID_key value:appID];
}



+ (void)xwAdd_senPayRequsetWithAppID:(NSString *)appID partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId nonceStr:(NSString *)nonceStr timeStamp:(NSString *)timeStamp package:(NSString *)package sign:(NSString *)sign callbackConfig:(void (^)(BOOL))config{

    //微信的appID
    [WXApi xwAdd_registerWeiXinWithAppID:appID];
    
    //构建请求对象
    PayReq *req = [PayReq new];
    req.partnerId = partnerId;
    req.prepayId = prepayId;
    req.nonceStr = nonceStr;
    req.timeStamp = (UInt32)[timeStamp intValue];
    req.package = package;
    req.sign = sign;
    //发起微信支付
    BOOL flag = [WXApi sendReq:req];
    if (!flag){
        NSLog(@"请求微信失败");
        config(NO);
        return;
    }
    else{
        NSLog(@"请求成功");
        //保存回调block
        objc_setAssociatedObject(self, xwAdd_callbackConfig_key, config, OBJC_ASSOCIATION_COPY_NONATOMIC);
        return;
    }

}


+ (void)xwAdd_handleOpenURL:(NSURL *)url {
    void(^config)(BOOL success) = objc_getAssociatedObject(self, xwAdd_callbackConfig_key);
    if (!config) {
        return;
    }
    [WXApi handleOpenURL:url delegate:[_XWWxApiDelegateObject xw_objectWithConfig:config]];
}

#pragma mark - private methods



+ (void)_xwAdd_saveValueWithKey:(void *)key value:(id)value{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (id)_xwAdd_readValueWithKey:(void *)key{
    return objc_getAssociatedObject(self, key);
}
@end
