//
//  AddDogViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;
@property NSManagedObjectContext *moc;
@property NSArray *dogs;

@end

@implementation AddDogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.moc = delegate.managedObjectContext;

}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Dog"];
//    self.dogs = [self.moc executeFetchRequest:request error:nil];

    Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.moc];
    dog.name = self.nameTextField.text;
    dog.breed = self.breedTextField.text;
    dog.color = self.colorTextField.text;
    [self.owner addDogObject:dog];

    [self.moc save:nil];

//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Dog"];
//    self.dogs = [self.moc executeFetchRequest:request error:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
