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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)oneGroupClick {
    [self.navigationController pushViewController:[OneSectionTabController new] animated:YES];
}

- (IBAction)moreGropClick {
    [self.navigationController pushViewController:[MoreGroupTabController new] animated:YES];
}

@end
