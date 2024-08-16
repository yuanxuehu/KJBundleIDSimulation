//
//  NSBundle+changeBundleId.h
//  KJBundleIDSimulation
//
//  Created by TigerHu on 2024/8/16.
//

#import <Foundation/Foundation.h>

@interface NSBundle (changeBundleId)

@property (nonatomic, strong) NSString *orgBundleId;
@property (nonatomic, strong) NSString *nowBundleId;

/**
 修改包名

 @param bundleId 包名，nil为默认包名
 */
- (void)changeBundleIdentifier:(NSString *)bundleId;

@end
