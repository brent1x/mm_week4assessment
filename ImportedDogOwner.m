//
//  ImportedDogOwner.m
//  Assessment4
//
//  Created by Brent Dady on 6/5/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ImportedDogOwner.h"

@implementation ImportedDogOwner

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    self.name = string;
    return self;
}

+ (void)retrieveOwnersWithCompletion:(void (^)(NSArray *))complete{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *importedOwners = [NSMutableArray arrayWithCapacity:results.count];
        for (NSString *owner in results) {
            [importedOwners addObject:[[ImportedDogOwner alloc]initWithString:owner]];
        }
        complete(importedOwners);
    }];
}

@end
