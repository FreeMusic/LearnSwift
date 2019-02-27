//
//  RYQArray.h
//  算法Demoemo
//
//  Created by 橘子 on 2019/2/20.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 实现一个数组
 */
@interface RYQArray <ObjectType> : NSObject <NSCopying, NSMutableCopying, NSFastEnumeration>

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)array;//默认容量是10  可动态扩容或缩减数组长度
+ (instancetype)arrayWithCapacity:(NSUInteger)numItems;//数组的扩容
- (instancetype)initWithCapacity:(NSUInteger)numItems;//数组的扩容

- (ObjectType)objectAtIndex:(NSUInteger)index;//通过下标取值
- (NSUInteger)indexOfObject:(ObjectType)anObject;//通过值 获取相应的下标
- (BOOL)containsObject:(ObjectType)anObject;//数组中是否包含该元素

- (void)addObject:(ObjectType)anObject;//在数组的第0个位置插入元素
- (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;//将一个元素插入到数组中的某个位置
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;//将某个下标的元素替换

- (void)removeAllObjects;//清空所有元素
- (void)removeLastObject;//移除最后一个元素
- (void)removeObjectAtIndex:(NSUInteger)index;//移除某个下标下的元素
- (void)removeObject:(ObjectType)anObject;//移除某个元素

/**
 拷贝一个新数组 使新数组的内容 和 原来数组内容一样
 */
- (RYQArray *)copyNewArray;

@property (readonly) NSUInteger count;
@property (nullable, nonatomic, readonly) ObjectType firstObject;
@property (nullable, nonatomic, readonly) ObjectType lastObject;

NS_ASSUME_NONNULL_END

@end
