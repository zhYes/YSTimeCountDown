//
//  OneSectionTabController.m
//  YSCountDownDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import "OneSectionTabController.h"
#import "OneSectionCell.h"
#import "YSCountDown.h"

@interface OneSectionTabController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataList;

@end

@implementation OneSectionTabController {
    YSCountDown * countDown;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    UINib*nib = [UINib nibWithNibName:@"OneSectionCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"one"];
    self.tableView.rowHeight = 110;
    
    /// 1.初始化 传入当前视图和数据数组
    countDown = [[YSCountDown alloc] initWith:self.tableView :self.dataList];
    countDown.isPlusTime = self.isPlusTime;
}

- (void)dealloc {
    /// 2.销毁
    [countDown destoryTimer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneSectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    
    /// 3.绑定tag
    cell.tag = indexPath.row;
    cell.endTimeLabel.tag = 1314;
    cell.endTimeLabel.text = [countDown countDownWithPER_SEC:indexPath];
    if (_isPlusTime) {
        cell.endTimeLabel.textColor = [UIColor whiteColor];
        cell.subTitleLabel.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    /*
    NSDate * datenow = [NSDate date];
    NSString*timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSTimeZone*zone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate*localeDate = [datenow dateByAddingTimeInterval:interval];
    NSString*timeSpp = [NSString stringWithFormat:@"%f", [localeDate timeIntervalSince1970]];
    NSLog(@"%@",timeSp);
    NSLog(@"%@",timeSpp);
    */
    
    return cell;
}






///  假数据
- (NSArray *)dataList {
    if (_isPlusTime) {
        NSMutableArray * nmArr;
        if (_dataList == nil) {
            _dataList = [NSArray array];
            
            nmArr = [NSMutableArray array];
            NSArray *arr = [NSArray array];
            NSDate * datenow = [NSDate date];
            NSString*timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            NSInteger nowInteger = [timeSp integerValue];
            for (int i = 0; i < 50; i ++) {
                NSString *str = [NSString stringWithFormat:@"%zd",nowInteger - arc4random()%100000  ];
                NSString *str1 = [NSString stringWithFormat:@"%zd",nowInteger - arc4random()%1000 ];
                NSString *str2 = [NSString stringWithFormat:@"%zd",nowInteger + arc4random()%50 ];
                arr = @[str,str1,str2];
                [nmArr addObjectsFromArray:arr];
            }
            _dataList = nmArr.copy;
        }
        self.tableView.backgroundColor = [UIColor blackColor];
        return _dataList;

    }else {
        
        NSMutableArray * nmArr;
        if (_dataList == nil) {
            _dataList = [NSArray array];
            
            nmArr = [NSMutableArray array];
            NSArray *arr = [NSArray array];
            NSDate * datenow = [NSDate date];
            NSString*timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            NSInteger nowInteger = [timeSp integerValue];
            for (int i = 0; i < 50; i ++) {
                NSString *str = [NSString stringWithFormat:@"%zd",arc4random()%100000 + nowInteger];
                NSString *str1 = [NSString stringWithFormat:@"%zd",arc4random()%1000 + nowInteger];
                NSString *str2 = [NSString stringWithFormat:@"%zd",arc4random()%100 + nowInteger];
                arr = @[str,str1,str2];
                [nmArr addObjectsFromArray:arr];
            }
            _dataList = nmArr.copy;
        }
        return _dataList;
    }
}


@end
