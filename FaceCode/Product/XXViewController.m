//
//  XXViewController.m
//  Product


//      http://www.superid.me/developer/index.html
//
//  Created by Sen wang on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXViewController.h"


@interface XXViewController ()<UIAlertViewDelegate>  {

    
    
}



@end



@implementation XXViewController



#pragma mark - 刷脸登录
- (IBAction)faceAction:(UIButton *)sender {
    
    //一登刷脸登录,弹出一登刷脸VC
    //用户参数userInfoModel,有则可传入,没有就置为nil.
    //例:如已知用户手机号,传入手机号参数phone,则用户首次登录时就不用输入手机号
    [SIDCoreLoginKit showLoginViewControllerWithAppUserInfoModel:nil responseBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            //授权登录成功
            NSLog(@"userInfo:%@", result);
            
            NSLog(@"一登登录成功,返回给开发者用户数据:%@",result);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"一登登录成功" message:@"控制台打印一登回传的数据" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alert show];
            
            
            
        }else {
            //授权登录失败
            NSLog(@"Login Fail Error =%ld,%@",(long)[error code],[error localizedDescription]);
        }
    }];

    
}
- (IBAction)logOut:(UIButton *)sender {
    
    [SuperID appUserLogoutCurrentAccount];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"退出登录成功" message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [alert show];

    
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    RootTabBarController *tabBarVc = [[RootTabBarController alloc] init];
    
    NavigationController *NavTabBarVc = [[NavigationController alloc]initWithRootViewController:tabBarVc];
    
    [self presentViewController:NavTabBarVc animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    

    
   }
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [SuperID setupSuperIDDelegate:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
