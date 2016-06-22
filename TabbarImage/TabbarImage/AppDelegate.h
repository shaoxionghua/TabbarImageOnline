//
//  AppDelegate.h
//  TabbarImage
//
//  Created by danggui on 16/6/22.
//  Copyright © 2016年 danggui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *RootTabBarViewController;

@end

