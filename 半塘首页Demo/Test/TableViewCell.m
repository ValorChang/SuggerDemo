//
//  TableViewCell.m
//  Test
//
//  Created by 常迪 on 15/11/10.
//  Copyright (c) 2015年 常迪. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -初始化,把控件添加到单元格上
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.disImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.likeLabel];
        }
    return self;
}


#pragma mark -给单元格赋值
- (void)configureCellWithModel:(Model *)model{
    
    self.titleLabel.text = model.title;
    [self.disImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.likeLabel.text = model.likes;
//    self.likeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
    self.likeLabel.textAlignment = NSTextAlignmentCenter;
    self.likeLabel.textColor = [UIColor whiteColor];
    self.likeLabel.backgroundColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    self.titleLabel.textColor = [UIColor whiteColor];
//    self.titleLabel.alpha = 0.5;
//    self.titleLabel.backgroundColor = [UIColor lightGrayColor];
    self.disImageView.frame = CGRectMake(10, 5, 375-20, 160);
    self.titleLabel.frame = CGRectMake(20, 135, 375-40, 25);
    self.likeLabel.frame = CGRectMake(315, 15, 50, 20);

    
   
}


#pragma mark -标题栏
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}

#pragma mark -缩略图
-(UIImageView *)disImageView{
    if (!_disImageView) {
        _disImageView = [[UIImageView alloc]init];
        _disImageView.layer.cornerRadius = 5;
        _disImageView.layer.masksToBounds = YES;
        _disImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _disImageView;
    
}

#pragma mark -收藏数
-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc]init];
    }
    return _likeLabel;
}






@end
