//
//  CellWithRightButtonAppDelegate.h
//  CellWithRightButton
//
//  Created by Oscar Del Ben on 3/21/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CellWithRightButtonViewController;

@interface CellWithRightButtonAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CellWithRightButtonViewController *viewController;

@end
