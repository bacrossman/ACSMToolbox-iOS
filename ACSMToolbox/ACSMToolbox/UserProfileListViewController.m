//
//  UserProfileListViewController.m
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import "UserProfileListViewController.h"
#import "CoreDataStoreController.h"
#import "UserProfile+CoreData.h"
#import "UserProfileListCell.h"
#import "UserProfileEditViewController.h"

@interface UserProfileListViewController ()
@property (nonatomic,strong) NSArray* userProfiles;
@property (nonatomic,strong) NSArray* genericProfiles;
@end

@implementation UserProfileListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    self.userProfiles = @[];
    self.genericProfiles = @[];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [[CoreDataStoreController sharedInstance] loadManagedDocumentWithCompletionHandler:^(BOOL success) {
        NSManagedObjectContext* context = [[CoreDataStoreController sharedInstance] managedObjectContext];
        
        self.userProfiles = [UserProfile fetchUserProfilesFromContext:context];
        
        [self.tableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditProfile"])
    {
        UserProfileEditViewController* dest = [segue destinationViewController];
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        switch (indexPath.section) {
            case 0:
                dest.userProfile = self.userProfiles[indexPath.item];
            case 1:
            default:
                dest.userProfile = nil;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.userProfiles.count;
    if (section == 1)
        return self.genericProfiles.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserProfileListCell* cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
        UserProfile* profile = self.userProfiles[indexPath.item];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", profile.firstName, profile.lastName];
        cell.detailLabel.text = [NSString stringWithFormat:@"%@ - %@%@", profile.sex, profile.heightCm, @"cm"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StockProfileCell" forIndexPath:indexPath];
        UserProfile* profile = self.genericProfiles[indexPath.item];
        cell.nameLabel.text = profile.firstName;
        cell.detailLabel.text = [NSString stringWithFormat:@"%@ - %@", profile.sex, profile.trainingProfile];
    }
    
    return cell;
}

@end
