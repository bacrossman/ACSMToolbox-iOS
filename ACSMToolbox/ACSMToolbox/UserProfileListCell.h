//
//  UserProfileListCell.h
//  ACSMToolbox
//
//  Created by cdann on 5/4/14.
//
//

#import <UIKit/UIKit.h>

@interface UserProfileListCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIImageView* profileImageView;
@property (nonatomic,strong) IBOutlet UILabel* nameLabel;
@property (nonatomic,strong) IBOutlet UILabel* detailLabel;
@end
