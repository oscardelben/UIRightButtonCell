//
//  CustomCell.h
//  CellWithRightButton
//
//  Created by Oscar Del Ben on 3/21/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell {}

@property (nonatomic, assign) int rightButtonState;

@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) NSArray *buttons;

@property (nonatomic, retain) UIButton *buttonStateNormal;
@property (nonatomic, retain) UIButton *buttonStateSelected;
@property (nonatomic, retain) UIButton *buttonStateDone;

@property (nonatomic, assign) SEL doneSelector;

@end
