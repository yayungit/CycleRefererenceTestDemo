//
//  BlockVC.m
//  CycleRef
//
//  Created by 何亚运 on 2020/8/23.
//  Copyright © 2020 yayun.he. All rights reserved.
//

#import "BlockVC.h"
#import "bVC.h"


typedef void(^Block)(void);


@interface BlockVC ()
@property (copy, nonatomic) Block myBlock;


@property (weak, nonatomic) IBOutlet UILabel *label;

// 会循环引用的情况



@end

@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    __weak typeof(self) weakSelf = self;
    _myBlock = ^{
        // self持有block，block持有self。
//        NSLog(@"%@",self.view);
        // 此时解决了循环引用，但是，需要在__strong一次，
        __strong typeof(weakSelf) strongSelf = weakSelf;
        // 原因： 存在有一种场景，在block执行开始时self对象还未被释放，
        // 而执行过程中，self被释放了，此时访问self时，就会发生错误。
        NSLog(@"%@",strongSelf.view);
    };

}
- (IBAction)ToBVC:(id)sender {
    /*------------------正常用时不会循环引用的---------------------*/
    // blcok界面传值用法
    // 本身就没有对bvc强引用
//    bVC *bvc = [[bVC alloc] initWithNibName:NSStringFromClass([bVC class]) bundle:nil];
//    // 不会循环引用
//    // 当bvc被pop或者dismiss时 block也销毁了，因此当本VCdismiss时不存在被循环引用
//    bvc.blcok = ^(NSString * _Nonnull str) {
//        // 逆向传值
//        self.label.text = str;
//    };
//    [self presentViewController:bvc animated:YES completion:nil];
    
    /*+=============造成循环引用情况==============**/
    self.myBlock();

    
}


- (IBAction)DissMissVCClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    NSLog(@"========blcok dealloc========");
}


@end
