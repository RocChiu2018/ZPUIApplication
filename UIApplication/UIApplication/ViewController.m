//
//  ViewController.m
//  UIApplication
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 UIApplication在系统中是一个单例，一般用UIApplication单例来做一些系统层级的工作；
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.title = @"第一页";
    
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;  //导航栏和状态栏是黑色背景，白色字
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;  //导航栏和状态栏是白色背景，黑色字
    
    //设置手机上面的APP的icon右上角的推送数字
    [self setupApplicationIconBadgeNumber];
    
    //设置状态栏里面的网络指示器
    [self setupActivityIndicator];
}

#pragma mark ————— 设置推送数字 —————
/**
 iOS8以后要先注册一个用户通知，再设置推送数字才管用。
 */
-(void)setupApplicationIconBadgeNumber
{
    //获取UIApplication的单例
    UIApplication *application = [UIApplication sharedApplication];
    
    //创建用户通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    //注册用户通知
    [application registerUserNotificationSettings:settings];
    
    //设置推送数字
    application.applicationIconBadgeNumber = 12;
}

#pragma mark ————— 设置状态栏中的网络指示器 —————
/**
 当APP在与网络进行交互的时候就要在状态栏上显示一个转动的“菊花”，用来提醒用户此时正在耗费手机的流量。
 */
-(void)setupActivityIndicator
{
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
}

#pragma mark ————— 点击“显示网页”按钮 —————
- (IBAction)buttonClick:(id)sender
{
    /**
     URL叫做资源路径；
     URL的组成：协议头://域名+路径；
     协议头有http,https,file,tel等等，系统会根据不同的协议头来做相应的动作。
     */
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}

#pragma mark ————— iOS7以后设置状态栏显示或隐藏 —————
/**
 iOS7以前用UIApplication单例来控制整个程序的状态栏的显示或隐藏，即在程序中的一处设置了状态栏的显示或隐藏，整个项目就都遵循这个设置，不用再在每个视图控制器中单独设置了；
 iOS7以后默认由当前的视图控制器来控制当前视图的状态栏的显示或隐藏的状态，每个视图控制器只能控制它自己的这个视图的状态栏的状态而不能统一设置整个程序状态栏的状态了。当设置状态栏的状态的时候要确保Info.plist文件中的"View controller-based status bar appearance"键所对应的值是YES，意即用视图控制器来控制状态栏的状态；
 iOS7以后在设置状态栏的时候又要分两种情况，一种情况是本视图控制器没有在导航控制器栈(UINavigationController)中，这种情况下可以通过调用系统的prefersStatusBarHidden方法来设置状态栏的显示或隐藏的状态，通过调用系统的preferredStatusBarStyle方法来设置状态栏的样式（颜色）；另一种情况是本视图控制器处在导航控制器栈中，这种情况下可以通过调用系统的prefersStatusBarHidden方法来设置状态栏的显示或隐藏的状态，但是preferredStatusBarStyle方法不会被调用，除非隐藏导航栏(self.navigationController.navigationBarHidden = YES;)才会被调用了。在上述的第二种情况下还可以不通过preferredStatusBarStyle方法来设置状态栏的颜色，可以通过"self.navigationController.navigationBar.barStyle = UIBarStyleBlack;"代码来设置状态栏的样式（颜色）；
 在iOS7以后如果还想像iOS7以前那样在程序中的一个地方统一设置状态栏的状态的话就需要在Info.plist文件中添加一个"View controller-based status bar appearance"键，并且把它所对应的值设为NO，意即不用视图控制器来控制状态栏的状态。然后有两种方式可以达到目的，第一种方式：在代码中利用UIApplication单例来设置状态栏的显示或隐藏的状态和状态栏的样式（颜色）；第二种方式：在TRAGETS中的General中的Deployment Info中的Status Bar Style中选择状态栏的颜色。上述的两种方式中系统都不会调用prefersStatusBarHidden和preferredStatusBarStyle方法。
 */
-(BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark ————— iOS7以后设置状态栏的样式（颜色） —————
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark ————— 点击“隐藏状态栏”按钮 —————
- (IBAction)hideStatusBar:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];

    //直接隐藏状态栏
//    [application setStatusBarHidden:YES];

    //动画隐藏状态栏
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
