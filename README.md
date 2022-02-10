> 传送门:
```
效果展示http://www.jianshu.com/p/3c49b44e45b4
如何使用: [http://www.jianshu.com/p/5b4e0286658a](http://www.jianshu.com/p/5b4e0286658a)
下载地址: [https://github.com/zhYes/YSTimeCountDown](https://github.com/zhYes/YSTimeCountDown)
```



>//2018年03月20日09:48:01更新:
//2018年03月20日09:48:01更新:
//2018年03月20日09:48:01更新:
~
有朋友反映出现了倒计时一万多天的情况,经过几次调试,发现我这里有一个获取当前时间时间戳的接口 用来校准服务器时间和手机当前时间的差值
当这个接口不好用 获取不到的时候就是这个样子了 建议让后台自己做个接口 来替换 `YSCountDown.m`里面的`@"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"`这个接口就好了,即:
![接口位置.jpg](https://upload-images.jianshu.io/upload_images/1914107-cf935766150d219d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>![QQ20180320-095232.gif](https://upload-images.jianshu.io/upload_images/1914107-1fb361d12c5f1264.gif?imageMogr2/auto-orient/strip)
注意:1.时间戳单位这里是秒.2.自己接口取时间戳的key替换.
![最新demo截图](http://upload-images.jianshu.io/upload_images/1914107-19e61d287d49ae4f?imageMogr2/auto-orient/strip)
>2018年03月20日``@end``
>2018年03月20日``@end``
>2018年03月20日``@end``
~


#正文:
> 需求是这样的，对UITableView中的每个Cell 加入一个倒计时器的显示，如下图：

![](http://upload-images.jianshu.io/upload_images/1914107-e4c6ba54b19bbc33.gif?imageMogr2/auto-orient/strip)


 >  一、倒计时的实现 

 首先计时器这块，我第一个会想到是用NSTimer定时器，还是用GCD定时器，或者说CADisplayLink定时呢。
>经过粗略的比较这里采用GCD定时器

``` 
NSTimer是必须要在run loop已经启用的情况下使用的否则无效。而只有主线程是默认启动runLoop的。
我们不能保证自己写的方法不会被人在异步的情况下调用到，所以有时使用NSTimer不是很保险的。
同时 NSTime 的坑比较多，循环应用和 RunLoop 那块的坑都可以开专题啦。
而CADisplayLink相对来说比较适合做界面的不停重绘。
NStimer是在RunLoop的基础上执行的，然而RunLoop是在GCD基础上实现的，所以说GCD可算是更加高级。
```
> 本着封装的思想,工具模型.h这里我们提供一个供外界调用的方法 👇

```
//需要传入 1.显示倒计时的tableView | 2.结束时刻的时间戳字符串数组 
- (void)countDownWithPER_SEC: (UITableView*)tableView :(NSArray*)dataList;
```

>常规代码: 频繁会被调用的计算显示时间方法👇

```
// 传入结束时间 | 计算与当前时间的差值
- (NSString *)getNowTimeWithString:(NSInteger )aTimeString :(NSInteger)startTime{
    
    NSTimeInterval timeInterval = aTimeString - startTime;
    //    NSLog(@"%f",timeInterval);
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}
```
> - 核心代码1: 接口获得真实的服务器返回时间,并计算与当前系统时间差值!   👇

```
- (void)setupLess {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.k780.com:88/?app=life.time&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        //                NSLog(@"%@",responseObject);
        NSString * webCurrentTimeStr = responseObject[@"result"][@"timestamp"];
        NSInteger webCurrentTime = webCurrentTimeStr.longLongValue;
        NSDate * date = [NSDate date];
        NSInteger nowInteger = [date timeIntervalSince1970];
        _less = nowInteger - webCurrentTime;
        NSLog(@" --  与服务器时间的差值 -- %zd",_less);
        
        if (_dataList) {
            [self destoryTimer];
            [self countDownWithPER_SEC:_myTableView :_dataList];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ - 网络错误 ! ",error);
    }];
}
```
> - 核心代码2: 
 - 利用定时器,每秒改变***当前tableView可见cell***需要倒计时时间的显示
 - 利用`[NSDate date] `每秒递增与结束时间做差值,这样每次被GCD定时器调取的时候所显示的值差1s,出现我们想要的倒计时效果
 - 再利用接口获取的当前服务器准确时间与手机系统时间做差值,一次性校准我们的倒计时 ! 而不是频繁调用接口  👇

```
- (void)countDownWithPER_SEC :(UITableView*)tableView :(NSArray*)dataList {
    
    _myTableView = tableView;
    _dataList = dataList;
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray  *cells = tableView.visibleCells; //取出屏幕可见ceLl
                for (UITableViewCell *cell in cells) {
                    
                    NSDate * sjDate = [NSDate date];   //手机时间
                    NSInteger sjInteger = [sjDate timeIntervalSince1970];  // 手机当前时间戳
                    NSString* tempEndTime = dataList[cell.tag];
                    
                    NSInteger endTime = tempEndTime.longLongValue + _less;
                    
                    cell.textLabel.text = [self getNowTimeWithString:endTime :sjInteger];
                    
                    
                    if ([cell.textLabel.text isEqualToString:@"活动已经结束！"]) {
                        cell.textLabel.textColor = [UIColor redColor];
                    }else{
                        cell.textLabel.textColor = [UIColor orangeColor];
                    }
//                    NSLog(@" -------- %@ ----  %@",cell.detailTextLabel.text,cell.textLabel.text);
                }
            });
        });
        dispatch_resume(_timer); // 启动定时器
    }

}

```
> 核心代码3: 当别人想通过修改本地时间 影响倒计时时怎么办?👇

```
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupLess) name:UIApplicationDidBecomeActiveNotification object:nil];
```
> 这里只需通过通知中心监听 我们的APP从后台重新变为前台`UIApplicationDidBecomeActiveNotification`并重新计算`_less`差值  为什么? 
好吧,应该不用解释 

```
/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
```
> 最后一段常规代码: 销毁 👆
<!-- ![IMG_2629](https://user-images.githubusercontent.com/19343447/153402321-38c6f9af-1124-4766-8447-af43b84e30ef.PNG) -->

![改变本地时间依然正确演示](http://upload-images.jianshu.io/upload_images/1914107-f25ebb99f13f806c.gif?imageMogr2/auto-orient/strip)

=========  任何其他问题,欢迎留言,愿与你一起学习😁=====

![动力来源.PNG](https://upload-images.jianshu.io/upload_images/1914107-7c77c7528aa4364e.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
