//
//  YHDynamicButton.m
//  Kiwi
//
//  Created by harry on 2020/6/1.
//

#import "YHDynamicButton.h"
#import "NSString+YHSize.h"

// 不定文本button解决方式
// 1. 非固定width， 可以采用trailing >= 固定值，调节contentInsets
// 2. 固定width
//  1> 分为纯frame 固定width， 计算width 改变width
//  2> autolayout 固定NSLayoutAttributeWidth， 计算width 改变width

@interface YHDynamicButton()

@property (nonatomic, strong) NSMutableDictionary *cacheDict;

@end

@implementation YHDynamicButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maximumWidth = CGFLOAT_MAX;
        _minimumWidth = 0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _maximumWidth = CGFLOAT_MAX;
        _minimumWidth = 0;
    }
    return self;
}

- (NSMutableDictionary *)cacheDict {
    if (!_cacheDict) {
        _cacheDict = [NSMutableDictionary dictionary];
    }
    return _cacheDict;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self changeSelf];
}

- (void)changeSelf {
    CGFloat imageWidth = self.imageView.frame.size.width;
    UIEdgeInsets edgeInsets = self.contentEdgeInsets;
    CGFloat horizontal = edgeInsets.left + edgeInsets.right;
    CGFloat superViewWidth = self.superview.frame.size.width;
    NSString *text = self.currentTitle;
    CGFloat width = 0;
    
    if (![self.cacheDict objectForKey:text]) {
        width = [text widthWithFont:self.titleLabel.font maxHeight:self.frame.size.height];
        width += imageWidth + horizontal;
        if (superViewWidth == 0) {
            return;
        }
        CGFloat limitedWidth = MIN(self.maximumWidth, superViewWidth - self.frame.origin.x - [self right]);
        width = MAX(self.minimumWidth, MIN(width, limitedWidth));
        [self.cacheDict setValue:@(width) forKey:text];
    } else {
        width = [[self.cacheDict objectForKey:text] floatValue];
    }
    
    if (self.constraints && self.constraints.count) {
        NSLayoutConstraint *constaint = [self layoutConstraintWithAttribute:NSLayoutAttributeWidth];
        if (constaint && constaint.constant != width) {
            constaint.constant = width;
        }
    } else {
        CGRect frame = self.frame;
        if (frame.size.width != width) {
            frame.size.width = width;
            self.frame = frame;
        }
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (!self.constraints || !self.constraints.count) {
        [self changeSelf];
    }
}

- (CGFloat)right {
    __block CGFloat right = 0;
    if (!self.constraints || !self.constraints.count) {
        [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.firstAttribute == NSLayoutAttributeTrailing || obj.firstAttribute == NSLayoutAttributeRight) {
                right = obj.constant;
            }
        }];
    }
    return right > 1 ? right : 1;
}

- (NSLayoutConstraint *)layoutConstraintWithAttribute:(NSLayoutAttribute)attribute {
    __block NSLayoutConstraint *constraint;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == NSLayoutAttributeWidth) {
            constraint = obj;
        }
    }];
    return constraint;
}


@end
