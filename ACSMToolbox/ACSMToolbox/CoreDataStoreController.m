//
//  CoreDataStoreController.m
//
//  Created by cdann on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataStoreController.h"

@interface CoreDataStoreController ()

@property (retain, nonatomic) UIManagedDocument* managedDocument;

@end


@implementation CoreDataStoreController

static CoreDataStoreController *_instance = nil;

+ (CoreDataStoreController *) sharedInstance {
    
    if (_instance == nil)
    {
        static dispatch_once_t onceToken;        // Lock
        dispatch_once(&onceToken, ^{             // This code is called at most once per app
            _instance = [[CoreDataStoreController alloc] init];
        });
    }
    
    return _instance;
}

- (void) loadManagedDocumentWithCompletionHandler:(void(^)(BOOL success))handler {

    static dispatch_once_t onceToken;        // Lock
    __block BOOL dispatched = false;         // Did we dispatch?
    dispatch_once(&onceToken, ^{             // This code is called at most once per app
        dispatched = true;

        _instance = [[CoreDataStoreController alloc] init];
        
        NSURL* url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Datastore"];
        
        _instance.managedDocument = [[UIManagedDocument alloc] initWithFileURL:url];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
            [_instance.managedDocument openWithCompletionHandler:^(BOOL success) {
                if (success) {
                    if (handler)
                        handler(success);
                }
                else {
                    NSLog(@"ERROR: Failed to open document at URL: %@", url);
                }
            }];
        }
        else {
            [_instance.managedDocument saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                if (success) {
                    if (handler)
                        handler(success);
                }
                else {
                    NSLog(@"ERROR: Failed to create document at URL: %@", url);
                }
            }];
        }
    });

    if (!dispatched) {
        handler(_instance.managedDocument.documentState == UIDocumentStateNormal);
    }
}

#pragma mark - Managed Document for Core Data Access
- (NSManagedObjectContext*) managedObjectContext
{
    if (self.managedDocument.documentState == UIDocumentStateNormal) {
        return self.managedDocument.managedObjectContext;
    }
    
    return nil;
}

@end
