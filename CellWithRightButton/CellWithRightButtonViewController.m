//
//  CellWithRightButtonViewController.m
//  CellWithRightButton
//
//  Created by Oscar Del Ben on 3/21/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "CellWithRightButtonViewController.h"
#import "CustomCell.h"

@implementation CellWithRightButtonViewController

@synthesize tableView;

- (void)dealloc
{
    [tableView release];
    
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#define kRightButtonStateNormal 0
#define kRightButtonStateSelected 1
#define kRightButtonStateDone 2

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    CustomCell *cell = (CustomCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.delegate = self;
    cell.doneSelector = @selector(doneAction:atIndexPath:);

    UIButton *normalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    normalButton.frame = CGRectMake(0, 0, 80, 25);
    [normalButton setTitle:@"Normal" forState:UIControlStateNormal];
    
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    selectedButton.frame = CGRectMake(0, 0, 80, 25);
    [selectedButton setTitle:@"Selected" forState:UIControlStateNormal];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(0, 0, 80, 25);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    
    cell.buttonStateNormal = normalButton;
    cell.buttonStateSelected = selectedButton;
    cell.buttonStateDone = doneButton;
    
    cell.rightButtonState = kRightButtonStateNormal;
    
	cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row];
	return cell;
}

- (void)doneAction:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Done. Row: %i", indexPath.row);
}

@end
