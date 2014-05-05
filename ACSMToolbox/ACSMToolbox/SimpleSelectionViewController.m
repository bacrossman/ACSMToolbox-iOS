//
//  SimpleSelectionViewController.m
//  ACSMToolbox
//
//  Created by cdann on 5/4/14.
//
//

#import "SimpleSelectionViewController.h"

@interface SimpleSelectionViewController ()

@end

@implementation SimpleSelectionViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell* cell;
    
    if ([self.selectedOption isEqualToString:self.options[indexPath.item]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedOption"];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Option"];
    }
    
    cell.textLabel.text = self.options[indexPath.item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.selectedOption = self.options[indexPath.item];
    [self.tableView reloadData];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self performSegueWithIdentifier:@"SimpleSelectionMade" sender:self];
    }];
}

@end
