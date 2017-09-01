//
//  YSCountDown.h
//  YSCountDownDemo
//
//  Created by FDC-iOS on 2017/4/21.
//  Copyright © 2017年 meilun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YSCountDown : NSObject

- (void)destoryTimer;

///每秒走一次，回调block
- (void)countDownWithPER_SEC :(UITableView*)tableView :(NSArray*)dataList;

/// 滑动过快的时候时间不会闪  (tableViewcell数据源方法里实现即可)
- (NSString *)countDownWithPER_SEC :(NSIndexPath *)indexPath;

- (instancetype)initWith :(UITableView*)tableView :(NSArray*)dataList;

@property (nonatomic,assign)BOOL isPlusTime;

@end
