//
//  SimpleSelectionViewController.h
//  ACSMToolbox
//
//  Created by cdann on 5/4/14.
//
//

#import <UIKit/UIKit.h>

@interface SimpleSelectionViewController : UITableViewController
@property (nonatomic,strong) NSArray* options;
@property (nonatomic,strong) NSString* selectedOption;
@end
