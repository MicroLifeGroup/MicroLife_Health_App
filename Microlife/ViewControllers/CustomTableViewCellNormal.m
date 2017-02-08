//
//  CustomTableViewCellNormal.m
//  MicroLifeSetting
//
//  Created by 曾偉亮 on 2016/12/30.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "CustomTableViewCellNormal.h"

@implementation CustomTableViewCellNormal {
    
    UILabel *cell_titleLabel;
}

@synthesize titleStr;

#pragma mark - cell initialization =======================
-(id)initWithFrameCustomCellNormal:(CGRect)frame {
    
    self = [super init];
    if (!self) return nil;
    
    self.frame = frame;
    
    [self initWithCellParam];
    
    return self;
}

-(void)initWithCellParam {
    
    cell_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height)];
    cell_titleLabel.font = [UIFont systemFontOfSize:cell_titleLabel.frame.size.height * 0.68];
    [self.contentView addSubview:cell_titleLabel];
    
}


#pragma mark - 更新 cell 資料 =======================
-(void)refreshMessage {
    
    cell_titleLabel.text = titleStr;
}

#pragma mark - Xcode Origin Function =======================
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
