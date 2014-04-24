//
//  UserProfile+CoreData.m
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import "UserProfile+CoreData.h"

@implementation UserProfile (CoreData)

+ (NSArray*) fetchUserProfilesFromContext:(NSManagedObjectContext*)context
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserProfile"
                                                         inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }
    
    return array;
}

+ (UserProfile*) createUserProfileInContext:(NSManagedObjectContext*) context
{
    // Create the UserProfile
    UserProfile* userProfile = [NSEntityDescription insertNewObjectForEntityForName:@"UserProfile" inManagedObjectContext:context];
    return userProfile;
}

@end
