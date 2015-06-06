//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"
#import "DogOwner.h"
#import "AppDelegate.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *dogs;
@property NSManagedObjectContext *moc;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.moc = delegate.managedObjectContext;

    [self loadDogs];
}

-(void)loadDogs {
    self.dogs = [self.owner.dog allObjects];
    [self.dogsTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    [self loadDogs];
    [self.dogsTableView reloadData];
}


#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    Dog *dog = [self.dogs objectAtIndex:indexPath.row];
    cell.textLabel.text = dog.name;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        AddDogViewController *destVC = segue.destinationViewController;
        destVC.owner = self.owner;
    }
    else
    {

    }
}

@end
