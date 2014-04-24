//
//  UserProfileEditViewController.m
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import "UserProfileEditViewController.h"
#import "CoreDataStoreController.h"

@interface UserProfileEditViewController ()

@property (nonatomic,strong) IBOutlet UITextField* firstName;
@property (nonatomic,strong) IBOutlet UITextField* lastName;
@property (nonatomic,strong) IBOutlet UILabel* birthDate;
@property (nonatomic,strong) IBOutlet UISegmentedControl* sex;
@property (nonatomic,strong) IBOutlet UILabel* trainingProfile;

@property (nonatomic,strong) IBOutlet UITextField* height;
@property (nonatomic,strong) IBOutlet UITextField* weight;

@property (nonatomic,strong) NSDateFormatter* dateFormatter;

@end

@implementation UserProfileEditViewController

- (void)setUserProfile:(UserProfile *)userProfile {

    _userProfile = userProfile;
    
    self.firstName.text = userProfile.firstName;
    self.lastName.text = userProfile.lastName;

    if (userProfile.birthDate) {
        NSString* birthDateString = [self.dateFormatter stringFromDate:userProfile.birthDate];
        self.birthDate.text = birthDateString;
    }
    
    if ([userProfile.sex isEqualToString:@"M"]) {
        self.sex.selectedSegmentIndex = 0;
    }
    else if ([userProfile.sex isEqualToString:@"F"]) {
        self.sex.selectedSegmentIndex = 1;
    }
    
    // TODO: Handle metric to US unit conversions
    self.height.text = [NSString stringWithFormat:@"%0.1f", [userProfile.heightCm floatValue]];
    self.weight.text = [NSString stringWithFormat:@"%0.1f", [userProfile.weightKg floatValue]];
}

- (IBAction) saveUserProfile:(id)sender {
    
    if ([self validateUserProfile]) {

        [[CoreDataStoreController sharedInstance] loadManagedDocumentWithCompletionHandler:^(BOOL success) {
            NSManagedObjectContext* context = [[CoreDataStoreController sharedInstance] managedObjectContext];
            
            // Create a new userProfile
            self.userProfile = [UserProfile createUserProfileInContext:context];
            
            self.userProfile.firstName = self.firstName.text;
            self.userProfile.lastName = self.lastName.text;
            self.userProfile.birthDate = [self.dateFormatter dateFromString:self.birthDate.text];
            self.userProfile.sex = self.sex.selectedSegmentIndex == 0 ? @"M" : @"F";
            self.userProfile.trainingProfile = self.trainingProfile.text;
            
            // TODO: Handle metric to US unit conversions
            self.userProfile.heightCm = @([self.height.text floatValue]);
            self.userProfile.weightKg = @([self.weight.text floatValue]);

            NSError* error;
            [context save:&error];
            if (error) {
                // TODO: Alert user to saving issue
            }
            else {
                // TODO: This should probably be an unwind segue that selects the newly created userProfile
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
    }
    else {
        // TODO: Alert user to the validation issue
    }
}

- (BOOL) validateUserProfile {
    // TODO: Validate for missing values and other errors
    return YES;
}

- (NSDateFormatter*) dateFormatter {
    
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
    }
    
    return _dateFormatter;
}

@end
