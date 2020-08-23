//
//  bVC.h
//  CycleRef
//
//  Created by 何亚运 on 2020/8/23.
//  Copyright © 2020 yayun.he. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MyBlcok)(NSString *str);

@interface bVC : UIViewController
@property (nonatomic, copy) MyBlcok blcok;
@end

NS_ASSUME_NONNULL_END
