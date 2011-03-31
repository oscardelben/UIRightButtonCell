//
//  CustomCell.m
//  CellWithRightButton
//
//  Created by Oscar Del Ben on 3/21/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import "CustomCell.h"

#define padding 10
#define fontSize 12

#define kRightButtonStateNormal 0
#define kRightButtonStateSelected 1
#define kRightButtonStateDone 2

@implementation CustomCell

@synthesize delegate;
@synthesize rightButtonState;
@synthesize buttons;
@synthesize buttonStateNormal, buttonStateSelected, buttonStateDone;
@synthesize doneSelector;

- (void)dealloc
{
    [delegate release];

    [buttons release];
    
    [buttonStateNormal release];
    [buttonStateSelected release];
    [buttonStateDone release];
    
    [super dealloc];
}

- (void)switchViewsFromState:(int)fromState toState:(int)toState
{
    UIButton *button1 = [buttons objectAtIndex:fromState];
    UIButton *button2 = [buttons objectAtIndex:toState];
    
    rightButtonState = toState;
    
    button1.hidden = YES;
    button2.hidden = NO;
}

- (void)configureButtons:(NSArray *)views
{
    for (UIButton *button in views)
    {
        // calculate frame
        int width = button.frame.size.width;
        int height = button.frame.size.height;

        int x = self.frame.size.width - width - padding * 2;
        int y = (self.frame.size.height - height) / 2;
        
        button.frame = CGRectMake(x, y, width, height);
        button.hidden = YES;
        
        [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // Check if we already have the buttons
    if (self.buttons)
        return;
    
    self.buttons = [NSArray arrayWithObjects:buttonStateNormal, buttonStateSelected, buttonStateDone, nil];
    [self configureButtons:buttons];
    
    // Should set this if null (but we don't have null for integers right?). Maybe it's already 0 by default
    self.rightButtonState = kRightButtonStateNormal;
    
    UIButton *button = (UIButton *)[buttons objectAtIndex:rightButtonState];
    button.hidden = NO;
        
    [self addSubview:buttonStateNormal];
    [self addSubview:buttonStateSelected];
    [self addSubview:buttonStateDone];
}

- (void)buttonTouched:(id)sender
{
    switch (rightButtonState) 
    {
        case kRightButtonStateNormal:
            [self switchViewsFromState:kRightButtonStateNormal toState:kRightButtonStateSelected];
            break;

        case kRightButtonStateDone:
            // do nothing
            break;
            
        case kRightButtonStateSelected:
            [self switchViewsFromState:kRightButtonStateSelected toState:kRightButtonStateDone];
            if (delegate) {
                NSIndexPath *indexPath = [(UITableView *)self.superview indexPathForCell: self];
                [delegate performSelector:doneSelector withObject:self withObject:indexPath];
            }
            break;
    }
}

// Cell was touched
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (rightButtonState) 
    {
        case kRightButtonStateNormal:
            // do nothing
            break;
            
        case kRightButtonStateDone:
            // do nothing
            break;
            
        case kRightButtonStateSelected:
            [self switchViewsFromState:kRightButtonStateSelected toState:kRightButtonStateNormal];
            break;
    }
}

@end
