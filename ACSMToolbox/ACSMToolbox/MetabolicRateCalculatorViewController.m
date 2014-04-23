//
//  MetabolicRateCalculatorViewController.m
//  ACSMToolbox
//
//  Created by cdann on 4/22/14.
//
//

#import "MetabolicRateCalculatorViewController.h"
#import "UIView+FindFirstResponder.h"

@interface MetabolicRateCalculatorViewController ()
@property (nonatomic,strong) UITextField* lastCalculatedField;
@end

@implementation MetabolicRateCalculatorViewController

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateMetabolicRateCalculationWithValue:[textField.text stringByReplacingCharactersInRange:range withString:string] fromField:textField];
    }];

    return YES;
}

- (IBAction) clear:(id)sender {
    
    self.speedTextField.text = @"";
    self.gradeTextField.text = @"";
    self.vo2TextField.text = @"";
    self.stepHeightTextField.text = @"";
    self.stepRateTextField.text = @"";
    self.bodyMassTextField.text = @"";
    self.workRateTextField.text = @"";
    
    self.lastCalculatedField = nil;
    
    [[self.view findFirstResponder] resignFirstResponder];
}

- (void) updateMetabolicRateCalculationWithValue:(NSString*)value fromField:(UITextField*) textField {

    if (![value length] > 0)
        return;
    
    if ([self.speedTextField isEqual:textField]) {
        float speed = [value floatValue];
        switch (self.calculationType) {
            case MetabolicCalculationTypeWalking:
            {
                if ([self.gradeTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.gradeTextField]) {
                    float grade = [self.gradeTextField.text floatValue] / 100.0f;
                    float vo2 = 0.1f * speed + 1.8f * speed * grade + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float grade = (vo2 - 3.5f - 0.1f * speed) / (1.8f * speed);
                    self.gradeTextField.text = [NSString stringWithFormat:@"%0.2f", grade * 100.0f];
                    self.lastCalculatedField = self.gradeTextField;
                }
            }
                break;
            case MetabolicCalculationTypeRunning:
            {
                if ([self.gradeTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.gradeTextField]) {
                    float grade = [self.gradeTextField.text floatValue] / 100.0f;
                    float vo2 = 0.2f * speed + 0.9f * speed * grade + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float grade = (vo2 - 3.5f - 0.2f * speed) / (0.9f * speed);
                    self.gradeTextField.text = [NSString stringWithFormat:@"%0.2f", grade * 100.0f];
                    self.lastCalculatedField = self.gradeTextField;
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([self.gradeTextField isEqual:textField]) {
        float grade = [value floatValue] / 100.0f;
        switch (self.calculationType) {
            case MetabolicCalculationTypeWalking:
            {
                if ([self.speedTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.speedTextField]) {
                    float speed = [self.speedTextField.text floatValue];
                    float vo2 = 0.1f * speed + 1.8f * speed * grade + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float speed = ( (vo2 - 3.5f) / (0.1f + (1.8f * grade) ) );
                    self.speedTextField.text = [NSString stringWithFormat:@"%0.2f", speed];
                    self.lastCalculatedField = self.speedTextField;
                }
            }
                break;
            case MetabolicCalculationTypeRunning:
            {
                if ([self.speedTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.speedTextField]) {
                    float speed = [self.speedTextField.text floatValue];
                    float vo2 = 0.2f * speed + 0.9f * speed * grade + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float speed = ( (vo2 - 3.5f) / (0.2f + (0.9f * grade) ) );
                    self.speedTextField.text = [NSString stringWithFormat:@"%0.2f", speed];
                    self.lastCalculatedField = self.speedTextField;
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([self.stepRateTextField isEqual:textField]) {
        float stepRate = [value floatValue];
        switch (self.calculationType) {
            case MetabolicCalculationTypeStepping:
            {
                if ([self.stepHeightTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.stepHeightTextField]) {
                    float stepHeight = [self.stepHeightTextField.text floatValue];
                    float vo2 = 0.2f * stepRate + 1.33f * 1.8f * stepHeight * stepRate + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float stepHeight = ((vo2 - (0.2f * stepRate) - 3.5f) / (1.33f * 1.8f * stepRate));
                    self.stepHeightTextField.text = [NSString stringWithFormat:@"%0.2f", stepHeight];
                    self.lastCalculatedField = self.stepHeightTextField;
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([self.stepHeightTextField isEqual:textField]) {
        float stepHeight = [value floatValue];
        switch (self.calculationType) {
            case MetabolicCalculationTypeStepping:
            {
                if ([self.stepRateTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.stepRateTextField]) {
                    float stepRate = [self.stepRateTextField.text floatValue];
                    float vo2 = 0.2f * stepRate + 1.33f * 1.8f * stepHeight * stepRate + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float stepRate = ((vo2 - 3.5f) / (0.2f + (1.33f * 1.8f * stepHeight)));
                    self.stepRateTextField.text = [NSString stringWithFormat:@"%0.2f", stepRate];
                    self.lastCalculatedField = self.stepRateTextField;
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([self.workRateTextField isEqual:textField]) {
        float workRate = [value floatValue];
        switch (self.calculationType) {
            case MetabolicCalculationTypeLegErgometry:
            {
                if ([self.bodyMassTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.bodyMassTextField]) {
                    float bodyMass = [self.bodyMassTextField.text floatValue];
                    float vo2 = ( (1.8f * workRate) / bodyMass ) + 7.0f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float bodyMass = (1.8f * workRate) / (vo2 - 7.0f);
                    self.bodyMassTextField.text = [NSString stringWithFormat:@"%0.2f", bodyMass];
                    self.lastCalculatedField = self.bodyMassTextField;
                }
            }
                break;
            case MetabolicCalculationTypeArmErgometry:
            {
                if ([self.bodyMassTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.bodyMassTextField]) {
                    float bodyMass = [self.bodyMassTextField.text floatValue];
                    float vo2 = ( (3.0f * workRate) / bodyMass ) + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float bodyMass = (3.0f * workRate) / (vo2 - 3.5f);
                    self.bodyMassTextField.text = [NSString stringWithFormat:@"%0.2f", bodyMass];
                    self.lastCalculatedField = self.bodyMassTextField;
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([self.bodyMassTextField isEqual:textField]) {
        float bodyMass = [value floatValue];
        switch (self.calculationType) {
            case MetabolicCalculationTypeLegErgometry:
            {
                if ([self.workRateTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.workRateTextField]) {
                    float workRate = [self.workRateTextField.text floatValue];
                    float vo2 = ( (1.8f * workRate) / bodyMass ) + 7.0f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float workRate = (bodyMass * (vo2 - 7.0f) ) / 1.8f;
                    self.workRateTextField.text = [NSString stringWithFormat:@"%0.2f", workRate];
                    self.lastCalculatedField = self.workRateTextField;
                }
            }
                break;
            case MetabolicCalculationTypeArmErgometry:
            {
                if ([self.workRateTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.workRateTextField]) {
                    float workRate = [self.workRateTextField.text floatValue];
                    float vo2 = ( (3.0f * workRate) / bodyMass ) + 3.5f;
                    self.vo2TextField.text = [NSString stringWithFormat:@"%0.2f", vo2];
                    self.lastCalculatedField = self.vo2TextField;
                }
                else if ([self.vo2TextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.vo2TextField]) {
                    float vo2 = [self.vo2TextField.text floatValue];
                    float workRate = (bodyMass * (vo2 - 3.5f) ) / 3.0f;
                    self.workRateTextField.text = [NSString stringWithFormat:@"%0.2f", workRate];
                    self.lastCalculatedField = self.workRateTextField;
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([self.vo2TextField isEqual:textField]) {
        float vo2 = [value floatValue];
        switch (self.calculationType) {
            case MetabolicCalculationTypeWalking:
            {
                if ([self.speedTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.speedTextField]) {
                    float speed = [self.speedTextField.text floatValue];
                    float grade = (vo2 - 3.5f - 0.1f * speed) / (1.8f * speed);
                    self.gradeTextField.text = [NSString stringWithFormat:@"%0.2f", grade * 100.0f];
                    self.lastCalculatedField = self.gradeTextField;
                }
                else if ([self.gradeTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.gradeTextField]) {
                    float grade = [self.gradeTextField.text floatValue] / 100.0f;
                    float speed = ((vo2 - 3.5f) / (0.1f + (1.8f * grade)));
                    self.speedTextField.text = [NSString stringWithFormat:@"%0.2f", speed];
                    self.lastCalculatedField = self.speedTextField;
                }
            }
                break;
            case MetabolicCalculationTypeRunning:
            {
                if ([self.speedTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.speedTextField]) {
                    float speed = [self.speedTextField.text floatValue];
                    float grade = (vo2 - 3.5f - 0.2f * speed) / (0.9f * speed);
                    self.gradeTextField.text = [NSString stringWithFormat:@"%0.2f", grade * 100.0f];
                    self.lastCalculatedField = self.gradeTextField;
                }
                else if ([self.gradeTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.gradeTextField]) {
                    float grade = [self.gradeTextField.text floatValue];
                    float speed = ( (vo2 - 3.5f) / (0.2f + (0.9 * grade) ) );
                    self.speedTextField.text = [NSString stringWithFormat:@"%0.2f", speed];
                    self.lastCalculatedField = self.speedTextField;
                }
            }
                break;
            case MetabolicCalculationTypeStepping:
            {
                if ([self.stepHeightTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.stepHeightTextField]) {
                    float stepHeight = [self.stepHeightTextField.text floatValue];
                    float stepRate = ((vo2 - 3.5f) / (0.2f + (1.33f * 1.8f * stepHeight)));
                    self.stepRateTextField.text = [NSString stringWithFormat:@"%0.2f", stepRate];
                    self.lastCalculatedField = self.stepRateTextField;
                }
                else if ([self.stepRateTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.stepRateTextField]) {
                    float stepRate = [self.stepRateTextField.text floatValue];
                    float stepHeight = ((vo2 - (0.2f * stepRate) - 3.5f) / (1.33f * 1.8f * stepRate));
                    self.stepHeightTextField.text = [NSString stringWithFormat:@"%0.2f", stepHeight];
                    self.lastCalculatedField = self.stepHeightTextField;
                }
            }
                break;
            case MetabolicCalculationTypeLegErgometry:
            {
                if ([self.workRateTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.workRateTextField]) {
                    float workRate = [self.workRateTextField.text floatValue];
                    float bodyMass = (1.8f * workRate) / (vo2 - 7.0f);
                    self.bodyMassTextField.text = [NSString stringWithFormat:@"%0.2f", bodyMass];
                    self.lastCalculatedField = self.bodyMassTextField;
                }
                else if ([self.bodyMassTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.bodyMassTextField]) {
                    float bodyMass = [self.bodyMassTextField.text floatValue];
                    float workRate = (bodyMass * (vo2 - 7.0f) ) / 1.8f;
                    self.workRateTextField.text = [NSString stringWithFormat:@"%0.2f", workRate];
                    self.lastCalculatedField = self.workRateTextField;
                }
            }
                break;
            case MetabolicCalculationTypeArmErgometry:
            {
                if ([self.workRateTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.workRateTextField]) {
                    float workRate = [self.workRateTextField.text floatValue];
                    float bodyMass = (3.0f * workRate) / (vo2 - 3.5f);
                    self.bodyMassTextField.text = [NSString stringWithFormat:@"%0.2f", bodyMass];
                    self.lastCalculatedField = self.bodyMassTextField;
                }
                else if ([self.bodyMassTextField.text length] > 0 && ![self.lastCalculatedField isEqual:self.bodyMassTextField]) {
                    float bodyMass = [self.bodyMassTextField.text floatValue];
                    float workRate = (bodyMass * (vo2 - 3.5f) ) / 3.0f;
                    self.workRateTextField.text = [NSString stringWithFormat:@"%0.2f", workRate];
                    self.lastCalculatedField = self.workRateTextField;
                }
            }
                break;
            default:
                break;
        }
    }
}

@end
