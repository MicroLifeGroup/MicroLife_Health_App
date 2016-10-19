//
//  MusclePickerView.h
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusclePickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView *m_pickerView;

-(id)initWithMusclePickerView:(CGRect)frame;

@end
