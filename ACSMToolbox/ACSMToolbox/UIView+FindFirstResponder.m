//
//  UIView+FindFirstResponder.m
//  ACSMToolbox
//
//  Created by cdann on 4/22/14.
//
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)
- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}
@end
