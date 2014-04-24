//
//  CoreDataStoreController.h
//
//  Created by cdann on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataStoreController : NSObject

@property (readonly) NSManagedObjectContext* managedObjectContext;

- (void) loadManagedDocumentWithCompletionHandler:(void(^)(BOOL success))handler;

+ (CoreDataStoreController *) sharedInstance;

@end
