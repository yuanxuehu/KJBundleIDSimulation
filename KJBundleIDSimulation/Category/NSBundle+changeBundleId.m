//
//  NSBundle+changeBundleId.m
//  KJBundleIDSimulation
//
//  Created by TigerHu on 2024/8/16.
//

#import "NSBundle+changeBundleId.h"
#import <objc/runtime.h>

//原包名
#define NSBundle_changeBundleIdentifier_orgBundleId @"NSBundle_changeBundleIdentifier_orgBundleId"

//修改包名
#define NSBundle_changeBundleIdentifier_nowBundleId @"NSBundle_changeBundleIdentifier_nowBundleId"

@implementation NSBundle (changeBundleId)

- (void)setNowBundleId:(NSString *)nowBundleId {
    objc_setAssociatedObject(self, NSBundle_changeBundleIdentifier_nowBundleId, nowBundleId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)nowBundleId {
    return objc_getAssociatedObject(self, NSBundle_changeBundleIdentifier_nowBundleId);
}

- (void)setOrgBundleId:(NSString *)orgBundleId {
    objc_setAssociatedObject(self, NSBundle_changeBundleIdentifier_orgBundleId, orgBundleId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)orgBundleId {
    return objc_getAssociatedObject(self, NSBundle_changeBundleIdentifier_orgBundleId);
}

//修改包名
- (void)changeBundleIdentifier:(NSString *)bundleId {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.orgBundleId = [[NSBundle mainBundle] bundleIdentifier];
        {
            Method m1 = class_getInstanceMethod([self class], NSSelectorFromString(@"bundleIdentifier"));
            Method m2 = class_getInstanceMethod([self class], NSSelectorFromString(@"_changeB"));
            method_exchangeImplementations(m1, m2);
        }
        {
            Method m1 = class_getInstanceMethod([self class], NSSelectorFromString(@"objectForInfoDictionaryKey:"));
            Method m2 = class_getInstanceMethod([self class], NSSelectorFromString(@"_changeC:"));
            method_exchangeImplementations(m1, m2);
        }
        {
            Method m1 = class_getInstanceMethod([self class], NSSelectorFromString(@"infoDictionary"));
            Method m2 = class_getInstanceMethod([self class], NSSelectorFromString(@"_changeD"));
            method_exchangeImplementations(m1, m2);
        }
    });
   
    self.nowBundleId = bundleId;
}

- (NSString *)_changeB {
    if (self.nowBundleId) {
        return self.nowBundleId;
    } else {
        return [self _changeB];
    }
}

- (nullable id)_changeC:(NSString *)key {
    if ([@"CFBundleIdentifier" compare:key] == NSOrderedSame && self.nowBundleId) {
        return self.nowBundleId;
    } else {
        return [self _changeC:key];
    }
}

- (NSDictionary<NSString *, id> *)_changeD {
    if (self.nowBundleId) {
        NSDictionary *dic = [self _changeD];
        [dic setValue:self.nowBundleId forKey:@"CFBundleIdentifier"];
        return dic;
    } else {
        return [self _changeD];
    }
}

@end
