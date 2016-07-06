//
//  TYButtonProgress
//  CareU
//
//  Created by tiny on 16/5/9.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "TYButtonProgress.h"

@interface UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end

@implementation UIColor (HexColor)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end




@interface TYButtonProgress ()

@property (nonatomic,strong)CAShapeLayer *shapelayer;
@property (nonatomic,strong)CAShapeLayer *bottomlayer;
@property (nonatomic,assign)BOOL isClockWise;


@end

@implementation TYButtonProgress


-(instancetype)initWithFrame:(CGRect)frame WithClockWise:(BOOL)clockWise
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialize:clockWise];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initialize:YES];
}

-(void)initialize:(BOOL)clockWise
{
    //默认值
    _bottomRingColor = [UIColor clearColor];
    _isClockWise = clockWise;
    _progress = 0;
    self.layer.cornerRadius = self.frame.size.width*0.5;
    self.clipsToBounds = YES;
    _borderWidth = 2.5f;
    //初始化圆环
    [self initbottomRing];
    [self initRoundButton];
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    
    self.shapelayer.strokeStart = 0;
    self.shapelayer.strokeEnd = _progress;
}

-(void)setColor:(UIColor *)color
{
    _shapelayer.strokeColor = color.CGColor;
}


-(void)setBorderWidth:(CGFloat)borderWidth
{
    _shapelayer.lineWidth = borderWidth;
    _bottomlayer.lineWidth = borderWidth;
}

-(void)setBottomRingColor:(UIColor *)bottomRingColor
{
    self.bottomlayer.strokeColor = bottomRingColor.CGColor;
}

-(void)initRoundButton
{
    _shapelayer = [CAShapeLayer layer];
    _shapelayer.frame = self.bounds;
    _shapelayer.lineWidth = self.borderWidth;
    _shapelayer.strokeColor = [UIColor colorWithHexString:@"#1af2ff"].CGColor;
    _shapelayer.position = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height *0.5);
    _shapelayer.fillColor = [UIColor clearColor].CGColor;
    
    CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height *0.5);  //设置圆心位置
    CGFloat radius = self.bounds.size.width*0.5-2.0;  //设置半径
    CGFloat startA =  -M_PI_2;  //圆起点位置
    CGFloat endA = 0;
    if (!self.isClockWise) {
        endA =  - M_PI * 2-M_PI_2 ;  //圆终点位置
    }
    else
    {
        endA = -M_PI_2 +  M_PI * 2; //圆终点位置
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:self.isClockWise];
    
    self.shapelayer.path = path.CGPath;
    
    [self.layer addSublayer:_shapelayer];
}


-(void)initbottomRing
{
  CAShapeLayer*  shapelayer = [CAShapeLayer layer];
    shapelayer.frame = self.bounds;
    shapelayer.lineWidth = self.borderWidth;
    shapelayer.strokeColor = _bottomRingColor.CGColor;
    shapelayer.position = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height *0.5);
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    
    CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height *0.5);  //设置圆心位置
    CGFloat radius = self.bounds.size.width*0.5-2.0;  //设置半径
    CGFloat startA =  -M_PI_2;  //圆起点位置
    CGFloat endA = -M_PI_2 +  M_PI * 2; //圆终点位置;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];

    shapelayer.path = path.CGPath;
    self.bottomlayer = shapelayer;
    [self.layer addSublayer:shapelayer];

}


//-(void)drawRect:(CGRect)rect
//{
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
//    
//    CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height *0.5);  //设置圆心位置
//    CGFloat radius = self.bounds.size.width*0.5-2.2;  //设置半径
//    CGFloat startA = - M_PI_2;  //圆起点位置
//    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //圆终点位置
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
//    
//    CGContextSetLineWidth(ctx, 2.5); //设置线条宽度
//    [[UIColor colorWithHexString:@"#1af2ff"] setStroke]; //设置描边颜色
//    
//    CGContextAddPath(ctx, path.CGPath); //把路径添加到上下文
//    
//    CGContextStrokePath(ctx);  //渲染
//
//}
@end
