//
//  AppDelegate.m
//  TabbarImage
//
//  Created by danggui on 16/6/22.
//  Copyright © 2016年 danggui. All rights reserved.
//

#import "AppDelegate.h"
#import "Page1ViewController.h"
#import "Page2ViewController.h"
#import "Page3ViewController.h"
#import "Page4ViewController.h"

@interface AppDelegate ()
{
    dispatch_semaphore_t semaphore;
    NSArray *imageUrls;
    NSMutableArray *images;
    UIView *im;
}

@end

@implementation AppDelegate
@synthesize RootTabBarViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //定位
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [UITabBarController new];
    [self.window makeKeyAndVisible];
    
    im = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    im.backgroundColor = [UIColor colorWithRed:1.0 green:0.502 blue:0.0 alpha:1.0];
    [self.window addSubview:im];
    
    //这里根据自己项目的需要可以和自己的后台通讯 起一个同步的数据请求来获取自己想要的图片链接和对应的title。

    imageUrls = [[NSArray alloc]initWithObjects:@"http://chuantu.biz/t5/11/1466579297x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578512x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578521x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578532x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578541x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578556x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578567x3738746553.png",
                 @"http://chuantu.biz/t5/11/1466578577x3738746553.png",nil];
    images = [[NSMutableArray alloc]init];
    [self setup];
    
    
    return YES;
}

- (void)setup{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        
        for (int i=0; i<imageUrls.count; i++) {
            NSURL *URL = [NSURL URLWithString:[imageUrls objectAtIndex:i]];
            NSError *ERROR;
            NSData *imageData = [NSData dataWithContentsOfURL:URL options:NSDataReadingMappedIfSafe error:&ERROR];
            UIImage *img = [UIImage imageWithData:imageData];
            [images addObject:img];
        }
        
    });
//    dispatch_group_async(group, queue, ^{
//    
//    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{//三个图片全部加载完毕后更新视图

        [im removeFromSuperview];
        //加载页面信息
        Page1ViewController *aa = [[Page1ViewController alloc] init];
        UINavigationController *aaNav = [[UINavigationController alloc] initWithRootViewController:aa];
        UIImage *item1Image = [images objectAtIndex:0];
        UIImage *item1ImageSel =[images objectAtIndex:1];
        item1Image = [item1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item1ImageSel = [item1ImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        aaNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Page1" image:item1Image selectedImage:item1ImageSel];
   
        Page2ViewController *bb = [[Page2ViewController alloc] init];
        UINavigationController *bbNav = [[UINavigationController alloc] initWithRootViewController:bb];
        UIImage *item2Image = [images objectAtIndex:2];
        UIImage *item2ImageSel = [images objectAtIndex:3];
        item2Image = [item2Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item2ImageSel = [item2ImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        bbNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Page2" image:item2Image selectedImage:item2ImageSel];
 
        Page3ViewController *cc = [[Page3ViewController alloc] init];
        UINavigationController *ccNav = [[UINavigationController alloc] initWithRootViewController:cc];
        UIImage *item3Image = [images objectAtIndex:4];
        UIImage *item3ImageSel = [images objectAtIndex:5];
        item3Image = [item3Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item3ImageSel = [item3ImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ccNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Page3" image:item3Image selectedImage:item3ImageSel];

        
        Page4ViewController *dd = [[Page4ViewController alloc] init];
        UINavigationController *ddNav = [[UINavigationController alloc] initWithRootViewController:dd];
        UIImage *item4Image = [images objectAtIndex:6];
        UIImage *item4ImageSel = [images objectAtIndex:7];
        item4Image = [item4Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item4ImageSel = [item4ImageSel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ddNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Page4" image:item4Image selectedImage:item4ImageSel];

        //把navigationController放入数组中
        NSArray *controllerArray = [[NSArray alloc] initWithObjects:aaNav,bbNav,ccNav,ddNav,nil];
        //建立TabBarController,需要在.h中先声明
        RootTabBarViewController = [[UITabBarController alloc] init];
        RootTabBarViewController.delegate = self;
        //把navigationController的数组加入到tabBarController中去
        RootTabBarViewController.viewControllers = controllerArray;
        RootTabBarViewController.selectedIndex = 0;
        RootTabBarViewController.tabBar.barTintColor=[UIColor whiteColor];
        [[UITabBar appearance] setTintColor:[UIColor grayColor]];
        self.window.rootViewController = RootTabBarViewController;
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            NSLog(@"第一次启动");
        }else{
            NSLog(@"已经不是第一次启动了");
        }
        
    });
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
