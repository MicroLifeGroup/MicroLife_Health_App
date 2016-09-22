//
//  HistoryListTableView.h
//  Microlife
//
//  Created by Rex on 2016/8/30.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryListDelegate <NSObject>

-(void)hideListButtonTapped;

@end

@interface HistoryListTableView : UIView<UITableViewDelegate, UITableViewDataSource>{
    
    float imgScale;
    
}

@property (nonatomic, strong) UITableView *historyList;
@property (nonatomic, strong) UIView *hideListBtn;
@property (nonatomic) int listType;
@property (weak) id<HistoryListDelegate> delegate;

@end
