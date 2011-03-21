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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    CustomCell *cell = (CustomCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.rightButtonTextNormal = @"Normal";
    cell.rightButtonTextSelected = @"Tapped";
    cell.rightButtonTextOff = @"Done";
	cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row + 1];
	return cell;
}

@end
