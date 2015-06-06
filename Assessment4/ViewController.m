//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "ImportedDogOwner.h"
#import "DogOwner.h"
#import "AppDelegate.h"
#import "DogsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property NSManagedObjectContext *moc;
@property (nonatomic) NSArray *owners;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

    NSData *theData = [[NSUserDefaults standardUserDefaults] objectForKey:@"myColor"];
    UIColor *theColor = (UIColor *)[NSKeyedUnarchiver unarchiveObjectWithData:theData];
    self.navigationController.navigationBar.tintColor = theColor;

    self.owners = [NSArray new];

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.moc = delegate.managedObjectContext;

    [self loadOwners];
    [self loadOwnersIfEmpty];

}

- (void)loadOwnersIfEmpty {
    NSLog(@"%lu", (unsigned long)self.owners.count);
    if (self.owners.count == 0) {
        [ImportedDogOwner retrieveOwnersWithCompletion:^(NSArray *dogOwners) {
            for (ImportedDogOwner *importedDogOwner in dogOwners) {
                DogOwner *dogOwner = [NSEntityDescription insertNewObjectForEntityForName:@"DogOwner" inManagedObjectContext:self.moc];
                dogOwner.name = importedDogOwner.name;
            }
            [self.moc save:nil];
            [self loadOwners];
            [self.myTableView reloadData];
        }];
    }
}

- (void)loadOwners {
    NSFetchRequest *rq = [[NSFetchRequest alloc] initWithEntityName:@"DogOwner"];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    rq.sortDescriptors = [NSArray arrayWithObject:sort];
    self.owners = [self.moc executeFetchRequest:rq error:nil];
    [self.myTableView reloadData];
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owners.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    ImportedDogOwner *importedDogOwner = [self.owners objectAtIndex:indexPath.row];
    cell.textLabel.text = importedDogOwner.name;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    DogOwner *owner = [self.owners objectAtIndex:indexPath.row];
    DogsViewController *destVC = segue.destinationViewController;
    destVC.owner = owner;
}

#pragma mark - UIAlertView Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor purpleColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor blueColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor orangeColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
        NSData *theData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor greenColor]];
        [[NSUserDefaults standardUserDefaults] setObject:theData forKey:@"myColor"];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end







