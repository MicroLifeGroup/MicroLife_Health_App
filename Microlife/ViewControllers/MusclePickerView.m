//
//  MusclePickerView.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MusclePickerView.h"

@implementation MusclePickerView {
    
    NSMutableArray *ary_muscleData;
}

-(id)initWithMusclePickerView:(CGRect)frame {
    
    self = [super init];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    //ary_muscle
    NSMutableArray *ary_muscle = [[NSMutableArray alloc] init];
    for (int i = 5; i <= 90; i++) {
        
        [ary_muscle addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    //ary_unit
    NSArray *ary_unit = [NSArray arrayWithObjects:@"'%'", nil];
    
    //ary_muscleData
    ary_muscleData = [NSMutableArray arrayWithObjects:
                      [NSArray arrayWithObjects:@" ", nil],
                      ary_muscle,
                      ary_unit,nil];
    
    return self;
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
//----------------------------------------------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return ary_muscleData.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_muscleData[component]];
    NSInteger count = ary.count;
    
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_muscleData[component]];
    NSString *title = [NSString stringWithFormat:@"%@",ary[row]];
    
    return title;
}



@end
