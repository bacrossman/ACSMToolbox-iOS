//
//  MetabolicRateCalculatorListViewController.m
//  ACSMToolbox
//
//  Created by cdann on 4/22/14.
//
//

#import "MetabolicRateCalculatorListViewController.h"
#import "MetabolicRateCalculatorViewController.h"

@interface MetabolicRateCalculatorListViewController ()

@end

@implementation MetabolicRateCalculatorListViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Walking"])
    {
        MetabolicRateCalculatorViewController* dest = segue.destinationViewController;
        dest.calculationType = MetabolicCalculationTypeWalking;
    }
    else if ([segue.identifier isEqualToString:@"Running"])
    {
        MetabolicRateCalculatorViewController* dest = [segue destinationViewController];
        dest.calculationType = MetabolicCalculationTypeRunning;
    }
    else if ([segue.identifier isEqualToString:@"Stepping"])
    {
        MetabolicRateCalculatorViewController* dest = [segue destinationViewController];
        dest.calculationType = MetabolicCalculationTypeStepping;
    }
    else if ([segue.identifier isEqualToString:@"LegErgometry"])
    {
        MetabolicRateCalculatorViewController* dest = [segue destinationViewController];
        dest.calculationType = MetabolicCalculationTypeLegErgometry;
    }
    else if ([segue.identifier isEqualToString:@"ArmErgometry"])
    {
        MetabolicRateCalculatorViewController* dest = [segue destinationViewController];
        dest.calculationType = MetabolicCalculationTypeArmErgometry;
    }
}

@end
