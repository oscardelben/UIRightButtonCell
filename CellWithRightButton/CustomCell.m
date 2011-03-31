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
@synthesize rightButtonTextNormal, rightButtonTextSelected, rightButtonTextDone;
@synthesize rightButtonState;
@synthesize buttons;
@synthesize buttonStateNormal, buttonStateSelected, buttonStateDone;
@synthesize doneSelector;

- (void)dealloc
{
    [delegate release];
    [rightButtonTextNormal release];
    [rightButtonTextSelected release];
    [rightButtonTextDone release];

    [buttons release];
    
    [buttonStateNormal release];
    [buttonStateSelected release];
    [buttonStateDone release];
    
    [super dealloc];
}

- (void)switchViewsFromState:(int)fromState toState:(int)toState
{
    UIView *view1 = [buttons objectAtIndex:fromState];
    UIView *view2 = [buttons objectAtIndex:toState];
    
    rightButtonState = toState;
    
    view1.hidden = YES;
    view2.hidden = NO;
}

- (UIButton *)buttonWithTitle:(NSString *)title;
{
    float textWidth = [title sizeWithFont:[UIFont boldSystemFontOfSize:fontSize]].width;
    
    int width = textWidth + padding * 2;
    int height = self.frame.size.height - padding * 2;
    
    int x = self.frame.size.width - width - padding * 2;
    int y = padding;
    
    CGRect buttonRect = CGRectMake(x, y, width, height);
    
    UIButton *button = [[[UIButton alloc] initWithFrame:buttonRect] autorelease];
    
    [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    button.backgroundColor = [UIColor orangeColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
    // hidden by default
    button.hidden = YES;
    
    return button;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // We already have the buttons
    if (buttons)
        return;

    buttonStateNormal = [self buttonWithTitle:rightButtonTextNormal];
    buttonStateSelected = [self buttonWithTitle:rightButtonTextSelected];
    buttonStateDone = [self buttonWithTitle:rightButtonTextDone];
    
    self.buttons = [NSArray arrayWithObjects:buttonStateNormal, buttonStateSelected, buttonStateDone, nil];
    
    // Should set this if null (but we don't have null for integers right?). Maybe it's already 0 by default
    rightButtonState = kRightButtonStateNormal;
    
    UIButton *button = (UIButton *)[buttons objectAtIndex:rightButtonState];
    button.hidden = NO;
    
    [self addSubview:buttonStateNormal];
    [self addSubview:buttonStateSelected];
    [self addSubview:buttonStateDone];
}

// TODO: add callbacks for changing state
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
                [delegate performSelector:doneSelector];
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
