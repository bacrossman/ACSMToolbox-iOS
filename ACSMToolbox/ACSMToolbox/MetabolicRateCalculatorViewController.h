//
//  MetabolicRateCalculatorViewController.h
//  ACSMToolbox
//
//  Created by cdann on 4/22/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    MetabolicCalculationTypeNone = 0,
    MetabolicCalculationTypeWalking,
    MetabolicCalculationTypeRunning,
    MetabolicCalculationTypeStepping,
    MetabolicCalculationTypeLegErgometry,
    MetabolicCalculationTypeArmErgometry
} MetabolicCalculationType;

@interface MetabolicRateCalculatorViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITextField* speedTextField;
@property (nonatomic,strong) IBOutlet UITextField* gradeTextField;
@property (nonatomic,strong) IBOutlet UITextField* vo2TextField;
@property (nonatomic,strong) IBOutlet UITextField* stepRateTextField;
@property (nonatomic,strong) IBOutlet UITextField* stepHeightTextField;
@property (nonatomic,strong) IBOutlet UITextField* bodyMassTextField;
@property (nonatomic,strong) IBOutlet UITextField* workRateTextField;

@property (nonatomic) MetabolicCalculationType calculationType;

@end
