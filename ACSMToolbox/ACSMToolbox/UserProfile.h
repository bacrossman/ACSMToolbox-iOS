//
//  UserProfile.h
//  ACSMToolbox
//
//  Created by cdann on 4/23/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserProfile : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSString * trainingProfile;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSNumber * heightCm;
@property (nonatomic, retain) NSNumber * weightKg;
@property (nonatomic, retain) NSNumber * isGenericProfile;

@end
