//
//  YHDynamicButton.h
//  Kiwi
//
//  Created by harry on 2020/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, YHDynamicOptions) {
    YHDynamicWidthOperation = 1 >> 0,
    YHDynamicHeightOperation = 1 >> 1
};

@interface YHDynamicButton : UIButton

@property (nonatomic, assign) YHDynamicOptions option;

@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, assign) CGFloat maxHeight;
@end

NS_ASSUME_NONNULL_END
