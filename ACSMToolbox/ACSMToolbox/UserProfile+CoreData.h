//
//  UserProfile+CoreData.h
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import "UserProfile.h"

@interface UserProfile (CoreData)

+ (NSArray*) fetchUserProfilesFromContext:(NSManagedObjectContext*)context;
+ (UserProfile*) createUserProfileInContext:(NSManagedObjectContext*) context;

@end
