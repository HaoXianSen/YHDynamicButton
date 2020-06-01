//
//  NSString+YHSize.m
//  Kiwi
//
//  Created by harry on 2020/6/1.
//

#import "NSString+YHSize.h"

@implementation NSString (YHSize)

- (CGFloat)widthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight {
    return [self sizeWithFont:font maxWidth:0 maxHeight:maxHeight].width;
}

- (CGFloat)heightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return [self sizeWithFont:font maxWidth:maxWidth maxHeight:0].height;
}

- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight {
    
    CGSize size = CGSizeZero;
    
    if (maxWidth > 0) {
        size = CGSizeMake(maxWidth, CGFLOAT_MAX);
    } else if (maxHeight > 0) {
        size = CGSizeMake(CGFLOAT_MAX, maxHeight);
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize returnSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle} context:nil].size;
    
    return returnSize;
}

@end
