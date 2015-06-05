//
//  ImportedDogOwner.h
//  Assessment4
//
//  Created by Brent Dady on 6/5/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImportedDogOwner : NSObject

@property NSString *name;

- (instancetype)initWithString:(NSString *)string;
+ (void)retrieveOwnersWithCompletion:(void(^)(NSArray*))complete;

@end
