//
//  Dog.h
//  Assessment4
//
//  Created by Brent Dady on 6/5/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DogOwner;

@interface Dog : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *breed;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) DogOwner *owner;

@end
