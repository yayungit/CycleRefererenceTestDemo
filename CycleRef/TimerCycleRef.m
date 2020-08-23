//
//  TimerCycleRef.m
//  CycleRef
//
//  Created by 何亚运 on 2020/8/23.
//  Copyright © 2020 yayun.he. All rights reserved.
//

#import "TimerCycleRef.h"

@interface TimerCycleRef ()
@property (nonatomic ,strong) NSTimer *myTimer;
@end

@implementation TimerCycleRef

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

// 创建Timer
- (IBAction)CreatTimer:(id)sender {
    // 此处self对time引用，_timer又对self引用
    if(_myTimer == nil){
        // 此方法需自行加入runloop
        // 延伸一下
        // DefaultMode：App的默认运行模式，通常主线程是在这个运行模式下运行
        // UITrackingRunLoopMode：跟踪用户交互事件（用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他Mode影响）
        // UIInitializationRunLoopMode：在刚启动App时第进入的第一个 Mode，启动完成后就不再使用
        // GSEventReceiveRunLoopMode：接受系统内部事件，通常用不到
        // kCFRunLoopCommonModes：伪模式，不是一种真正的运行模式

    /*
     * 自动加入default mode模式
     *+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

     + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

     + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
     */
    
    /*
     不会自动加入runloop模式，自定添加
     + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

     + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;

     + (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

     - (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep;

     - (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
     */
    // 有人说timer使用weak修饰，其实没用，亲测
     __weak typeof(self) weakSelf = self;
        //不能解决
        _myTimer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(TimerFun) userInfo:nil repeats:YES];
        //
//        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            // 解决方案一
//            [weakSelf TimerFun];
//        }];
    }
   
           
     [[NSRunLoop mainRunLoop]addTimer:_myTimer forMode:NSRunLoopCommonModes];
}
                
 -(void)TimerFun{
     NSLog(@"timer fun");
    }

- (IBAction)PopVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 不建议在delloc中销毁定时器，因为如果有timer造成循环引用的话dealloc方法是执行不了的
// 因此在VC执行dealloc释放掉
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_myTimer invalidate];// 可以释放掉timer
    _myTimer = nil;
}
-(void)dealloc{
    NSLog(@"============Timer VC dealloc============");
}


@end
