//
//  OverViewCircleView.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/9/12.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverViewCircleView : UIView


@property (strong, nonatomic) NSString *circleViewTitleString;
@property (strong, nonatomic) NSString *circleViewValueString;
@property (strong, nonatomic) NSString *circleViewUnitString;
@property (strong, nonatomic) UIImageView *circleImgView;

-(void)setString;

@end
