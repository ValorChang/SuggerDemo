//
//  TableViewCell.h
//  Test
//
//  Created by 常迪 on 15/11/10.
//  Copyright (c) 2015年 常迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface TableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *disImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *likeLabel;

- (void)configureCellWithModel:(Model *)model;
@end
