//
//  NSString+YHSize.h
//  Kiwi
//
//  Created by harry on 2020/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YHSize)

- (CGFloat)widthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;

- (CGFloat)heightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;


@end

NS_ASSUME_NONNULL_END
