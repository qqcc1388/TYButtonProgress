//
//  TYButtonProgress
//  CareU
//
//  Created by tiny on 16/5/9.
//  Copyright © 2016年 tiny. All rights reserved. 
//

#import <UIKit/UIKit.h>

@interface TYButtonProgress : UIButton

/**
 *  初始化圆环的尺寸位置 设置圆环的旋转方向
 *
 *  @param frame     frame
 *  @param clockWise 选择方向 默认顺时针
 *
 *  @return 创建的对象
 */
-(instancetype)initWithFrame:(CGRect)frame WithClockWise:(BOOL)clockWise;

/**
 *  当前进度
 */
@property (nonatomic,assign)float progress;

/**
 *  进度条颜色
 */
@property (nonatomic,strong)UIColor *color;

/**
 *  底部环颜色  默认为clearColor
 */
@property (nonatomic,strong)UIColor *bottomRingColor;

/**
 *  圆环的宽度
 */
@property (nonatomic,assign)CGFloat borderWidth;



@end
