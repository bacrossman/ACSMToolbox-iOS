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

@end
