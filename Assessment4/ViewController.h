//
//  ViewController.h
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Dog.h"

@interface ViewController : UIViewController

@property NSManagedObjectContext *managedObjectContext;

@property Dog *dog;

@end
