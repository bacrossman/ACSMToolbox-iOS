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

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[CoreDataStoreController sharedInstance] loadManagedDocumentWithCompletionHandler:^(BOOL success) {
        NSManagedObjectContext* context = [[CoreDataStoreController sharedInstance] managedObjectContext];

        self.userProfiles = [UserProfile fetchUserProfilesFromContext:context];
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end
