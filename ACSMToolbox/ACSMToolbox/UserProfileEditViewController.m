//
//  UserProfileEditViewController.m
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import "UserProfileEditViewController.h"
#import "CoreDataStoreController.h"
#import "SimpleSelectionViewController.h"

@interface UserProfileEditViewController ()

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
            _userProfile = [UserProfile createUserProfileInContext:context];
            
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectTrainingProfile"])
    {
        SimpleSelectionViewController* dest = [segue destinationViewController];
        dest.options = @[
                         NSLocalizedString(@"White",@"White"),
                         NSLocalizedString(@"Black",@"Black"),
                         NSLocalizedString(@"American Indian",@"American Indian"),
                         NSLocalizedString(@"Hispanic",@"Hispanic"),
                         NSLocalizedString(@"Japanese",@"Japanese"),
                         NSLocalizedString(@"Singaporean",@"Singaporean"),
                         NSLocalizedString(@"Resistance Trained",@"Resistance Trained"),
                         NSLocalizedString(@"Endurance Trained",@"Endurance Trained"),
                         NSLocalizedString(@"All Sports",@"All Sports"),
                         NSLocalizedString(@"Other", @"Other")
                    ];
        
        if ([self.trainingProfile.text length] > 0) {
            dest.selectedOption = self.trainingProfile.text;
        }
    }
}

- (IBAction) trainingProfileSelected:(UIStoryboardSegue*)segue {

    if ([segue.identifier isEqualToString:@"SimpleSelectionMade"])
    {
        SimpleSelectionViewController* source = [segue sourceViewController];
        self.trainingProfile.text = source.selectedOption;
    }
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
