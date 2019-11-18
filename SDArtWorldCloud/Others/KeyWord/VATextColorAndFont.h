//
//  VATextColorAndFont.h
//  MeiShuQuan
//
//  Created by 007 on 2016/11/4.
//  Copyright © 2016年 YanSha. All rights reserved.
//

#ifndef VATextColorAndFont_h
#define VATextColorAndFont_h
//全局颜色
#define VAMainAppColor RGBColor(90, 160, 248)// app主色调  (72, 173, 136) (98, 193, 143)(keep)      // 美术世界色值（199，170，128）
#define VASeparatorColor UIColorMake(222, 224, 226)
//背景色
#define VAMainBgColor RGBColor(255, 255, 255) // app背景色
//背景色
#define VAMainBgGrayColor RGBColor(241, 241, 241) // app灰色背景色

//灰色不可用色
#define VAGrayUnUseColor RGBColor(150, 250, 250) // 灰色不可用色
// app主字Label体颜色
#define VAMainTitleColor UIColorGray3 //app主字Label体颜色
// 主体字体大小
#define VAMainTitleFont  UIFontMake(16)// 主体字体大小
// 副标题字体大小
#define VASubTitleFont  UIFontMake(14)// 副标题字体大小

// 主体字体大小
#define VAMainTitleFontSize  16// 主体字体大小
// 副标题字体大小
#define VASubTitleFontSize  14// 主体字体大小
// 副标题颜色
#define VASubTitleColor RGBColor(160, 160, 160) // 副标题颜色
// 导航栏标题字体颜色
#define VANavTitleColor RGBColor(255, 255, 255) // 导航栏标题字体颜色
// 分割线颜色
#define VAMainSepColor RGBColor(244, 244, 244) // 分割线颜色
// 课程段头背景颜色
#define VAVideoSectionBgColor RGBColor(234, 68, 82) // 课程段头背景颜色
// 课程筛选keyWords背景色
#define VAVideoKeyWordsBgColor RGBColor(216, 41, 116) // 课程筛选keyWords背景色
// 边距10 像素
#define VAMarginLength 10// 边距10 像素
/**
 *  颜色
 */
#pragma mark----Color
#define VABlackColor [UIColor blackColor]
#define VABlueColor [UIColor blueColor]
#define VARedColor [UIColor redColor]
#define VAWhiteColor [UIColor whiteColor]
#define VAGrayColor [UIColor grayColor]
#define VADarkGrayColor [UIColor darkGrayColor]
#define VALightGrayColor [UIColor lightGrayColor]
#define VAGreenColor [UIColor greenColor]
#define VACyanColor [UIColor cyanColor]
#define VAYellowColor [UIColor yellowColor]
#define VAMagentaColor [UIColor magentaColor]
#define VAOrangeColor [UIColor orangeColor]
#define VAPurpleColor [UIColor purpleColor]
#define VABrownColor [UIColor brownColor]
#define VAClearColor [UIColor clearColor]
#define UIColorGray1 UIColorMake(53, 60, 70)
#define UIColorGray2 UIColorMake(73, 80, 90)
#define UIColorGray3 UIColorMake(93, 100, 110)
#define UIColorGray4 UIColorMake(113, 120, 130)
#define UIColorGray5 UIColorMake(133, 140, 150)
#define UIColorGray6 UIColorMake(153, 160, 170)
#define UIColorGray7 UIColorMake(173, 180, 190)
#define UIColorGray8 UIColorMake(196, 200, 208)
#define UIColorGray9 UIColorMake(216, 220, 228)

#define UIColorDarkGray1 UIColorMake(218, 220, 224)
#define UIColorDarkGray2 UIColorMake(198, 200, 204)
#define UIColorDarkGray3 UIColorMake(178, 180, 184)
#define UIColorDarkGray4 UIColorMake(158, 160, 164)
#define UIColorDarkGray5 UIColorMake(138, 140, 144)
#define UIColorDarkGray6 UIColorMake(118, 120, 124)
#define UIColorDarkGray7 UIColorMake(98, 100, 104)
#define UIColorDarkGray8 UIColorMake(78, 80, 84)
#define UIColorDarkGray9 UIColorMake(58, 60, 64)

#define UIColorTheme1 UIColorMake(239, 83, 98) // Grapefruit
#define UIColorTheme2 UIColorMake(254, 109, 75) // Bittersweet
#define UIColorTheme3 UIColorMake(255, 207, 71) // Sunflower
#define UIColorTheme4 UIColorMake(159, 214, 97) // Grass
#define UIColorTheme5 UIColorMake(63, 208, 173) // Mint
#define UIColorTheme6 UIColorMake(49, 189, 243) // Aqua
#define UIColorTheme7 UIColorMake(90, 154, 239) // Blue Jeans
#define UIColorTheme8 UIColorMake(172, 143, 239) // Lavender
#define UIColorTheme9 UIColorMake(238, 133, 193) // Pink Rose
#define UIColorTheme10 UIColorMake(39, 192, 243) // Dark
// rgb颜色值
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 颜色(RGB)
#define VAColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif /* VATextColorAndFont_h */
