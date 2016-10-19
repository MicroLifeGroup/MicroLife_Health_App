//
//  SkeletonPickerView.m
//  Microlife
//
//  Created by 曾偉亮 on 2016/10/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "SkeletonPickerView.h"

@implementation SkeletonPickerView {
    
    NSMutableArray *ary_skeletonData;
    
}

-(id)initWithSkeletonPickerView:(CGRect)frame {
    
    self = [super init];
    
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];

    
    //ary_skeleton
    NSMutableArray *ary_skeleton = [[NSMutableArray alloc] init];
    float skeletonPlus = 0.1;
    for (float skeletonFloat = 0.5; skeletonFloat <= 8.0; skeletonPlus++) {
        
        [ary_skeleton addObject:[NSString stringWithFormat:@"%.1f",skeletonFloat]];
        
        skeletonFloat += 0.1;
    }
    
    //ary_unit
    NSArray *ary_unit = [NSArray arrayWithObjects:@"kg",@"lb" ,nil];
    

    //ary_skeletonData
    ary_skeletonData = [NSMutableArray arrayWithObjects:
                        [NSArray arrayWithObjects:@" ", nil],
                        ary_skeleton,
                        ary_unit, nil];
    
    return self;
}


#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
//----------------------------------------------------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return ary_skeletonData.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_skeletonData[component]];
    NSInteger count = ary.count;
    
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *ary = [[NSArray alloc] initWithArray:ary_skeletonData[component]];
    NSString *title = [NSString stringWithFormat:@"%@",ary[row]];
    
    return title;
}



@end
