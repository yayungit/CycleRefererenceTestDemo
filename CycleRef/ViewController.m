//
//  ViewController.m
//  CycleRef
//
//  Created by 何亚运 on 2020/8/23.
//  Copyright © 2020 yayun.he. All rights reserved.
//

#import "ViewController.h"
#import "TimerCycleRef.h"
#import "BlockVC.h"

@interface ViewController ()

//@property (nonatomic, strong) TimerCycleRef *timerVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
// push Timer VC
- (IBAction)ToTimerVCCLick:(id)sender {
    TimerCycleRef *timerVC  = [[TimerCycleRef alloc] initWithNibName:NSStringFromClass([TimerCycleRef class]) bundle:nil];
    // 此处self持有_timerVC，等到pop时是不会执行dealloc的，没太多意义不做过多解释
//    if (!_timerVC ) {
//          _timerVC  = [[TimerCycleRef alloc] initWithNibName:NSStringFromClass([TimerCycleRef class]) bundle:nil];
//    }
    [self presentViewController:timerVC animated:YES completion:^{
    }];
}

- (IBAction)ToBlockVCClcik:(id)sender {
    BlockVC *blockVC = [[BlockVC alloc] initWithNibName:NSStringFromClass([BlockVC class]) bundle:nil];
    [self presentViewController:blockVC animated:YES completion:^{
        
    }];
}



@end
