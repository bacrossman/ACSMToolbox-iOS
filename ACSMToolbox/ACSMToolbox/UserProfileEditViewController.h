//
//  UserProfileEditViewController.h
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import <UIKit/UIKit.h>
#import "UserProfile+CoreData.h"

@interface UserProfileEditViewController : UITableViewController

@property (nonatomic,strong) UserProfile* userProfile;

@property (nonatomic,strong) IBOutlet UITextField* firstName;
@property (nonatomic,strong) IBOutlet UITextField* lastName;
@property (nonatomic,strong) IBOutlet UILabel* birthDate;
@property (nonatomic,strong) IBOutlet UISegmentedControl* sex;
@property (nonatomic,strong) IBOutlet UILabel* trainingProfile;

@property (nonatomic,strong) IBOutlet UITextField* height;
@property (nonatomic,strong) IBOutlet UITextField* weight;

- (IBAction) trainingProfileSelected:(UIStoryboardSegue*)segue;

@end
