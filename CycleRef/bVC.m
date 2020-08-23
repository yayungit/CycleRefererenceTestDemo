//
//  bVC.m
//  CycleRef
//
//  Created by 何亚运 on 2020/8/23.
//  Copyright © 2020 yayun.he. All rights reserved.
//

#import "bVC.h"

@interface bVC ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic, copy) NSString *str;

@end

@implementation bVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _str = @"hello";
}

- (IBAction)BackClick:(id)sender {
    // 不会循环引用
//    self.blcok(@"bVC --- >Hello");
//    self.blcok(self.str);
    
    self.blcok(self.label.text);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc{
    NSLog(@"========bvc dealloc===========");
}

@end
