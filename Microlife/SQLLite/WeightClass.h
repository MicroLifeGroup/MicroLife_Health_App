//
//  WeightClass.h
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "DataBaseClass.h"

@interface WeightClass : DataBaseClass

@property (nonatomic) int weightID;                     //體脂機ID
@property (nonatomic) int accountID;                    //會員ID
@property (nonatomic) int weight;                       //體重
@property (nonatomic) int weightUnit;                   //體重單位 0 : kg 1 : lb
@property (nonatomic) int BMI;                          //身體質量指數
@property (nonatomic) int bodyFat;                      //體脂肪
@property (nonatomic) int water;                        //體水分
@property (nonatomic) int skeleton;                     //骨質量
@property (nonatomic) int muscle;                       //肌肉
@property (nonatomic) int BMR;                          //基礎代謝率
@property (nonatomic) int organFat;                     //內臟脂肪
@property (nonatomic) NSString *date;                   //日期
@property (nonatomic) NSString * weight_PhotoPath;      //筆記照片路徑
@property (nonatomic) NSString * weight_Note;           //筆記內容
@property (nonatomic) NSString * weight_RecordingPath;  //筆記錄音路徑


+(WeightClass*) sharedInstance;

-(NSMutableArray *)selectAllData;
-(NSMutableArray *)selectAllDataAtRange:(int)dataRange count:(int)dataCount;

-(NSMutableArray *)selectData:(NSString *)column range:(int)dataRange count:(int)dataCount;

-(NSMutableArray *)selectSingleDay:(NSString *)column range:(int)dataRange;

-(void)insertData;
- (void)updateData;

@end
