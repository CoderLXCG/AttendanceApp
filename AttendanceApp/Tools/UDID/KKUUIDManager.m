//
//  KKUUIDManager.m
//  AttendanceApp
//
//  Created by 杜仲 on 2017/5/11.
//  Copyright © 2017年 Chengdu Wangding Technology co.,LTD. All rights reserved.
//

#import "KKUUIDManager.h"
#import "KKKeyChain.h"

@implementation KKUUIDManager

#define KEY_IN_KEYCHAIN [NSBundle mainBundle].bundleIdentifier
#define KEY_UUID [NSString stringWithFormat:@"%@.uuid", KEY_IN_KEYCHAIN]

+(void)saveUUID:(NSString *)uuid
{
    [KKKeyChain save:KEY_IN_KEYCHAIN data:@{KEY_UUID:uuid}];
}

+(id)readUUID
{
    NSMutableDictionary *usernameUuidPairs = (NSMutableDictionary *)[KKKeyChain load:KEY_IN_KEYCHAIN];
    return [usernameUuidPairs objectForKey:KEY_UUID];
}

+(void)deleteUUID
{
    [KKKeyChain delete:KEY_IN_KEYCHAIN];
}
@end
