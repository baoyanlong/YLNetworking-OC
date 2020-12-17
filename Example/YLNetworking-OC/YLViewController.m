//
//  YLViewController.m
//  YLNetworking-OC
//
//  Created by 674934875@qq.com on 12/17/2020.
//  Copyright (c) 2020 674934875@qq.com. All rights reserved.
//

#import "YLViewController.h"
#import <YLNetworking_OC/YLNetworkManager.h>

@interface YLViewController ()

@end

@implementation YLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [[YLNetworkManager shareInstance] getUrl:@"https://base.lpswish.com/api/app/base/app/version" params:nil success:^(id  _Nullable responseObject) {
//        NSLog(@"success");
//        } failure:^(NSError * _Nullable error) {
//            NSLog(@"error");
//        } showLoading:YES];
    [[YLNetworkManager shareInstance] postUrl:nil params:nil success:^(id  _Nullable responseObject) {
        NSLog(@"success");
        } failure:^(NSError * _Nullable error) {
            NSLog(@"error");
        } showLoading:YES];
}
@end
