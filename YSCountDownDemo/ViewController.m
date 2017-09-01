//
//  ViewController.m
//  YSCountDownDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import "ViewController.h"
#import "OneSectionTabController.h"
#import "MoreGroupTabController.h"

@interface ViewController ()

@end

@implementation ViewController {
    BOOL isPlusTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (IBAction)oneGroupClick {
    OneSectionTabController * one = [OneSectionTabController new];
    one.isPlusTime = isPlusTime;
    [self.navigationController pushViewController:one animated:YES];
}

- (IBAction)moreGropClick {
    MoreGroupTabController * group = [MoreGroupTabController new];
    group.isPlusTime = isPlusTime;
    [self.navigationController pushViewController:group animated:YES];
}
- (IBAction)timeBack:(id)sender {

    isPlusTime = isPlusTime==0?1:0;
    
    self.view.backgroundColor = (self.view.backgroundColor == [UIColor whiteColor])?[UIColor blackColor]:[UIColor whiteColor];
    self.navigationController.navigationBar.subviews[0].alpha = self.navigationController.navigationBar.subviews[0].alpha ==0 ? 1 : 0;
}

@end
