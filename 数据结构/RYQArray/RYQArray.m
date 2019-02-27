//
//  RYQArray.m
//  算法Demoemo
//
//  Created by 橘子 on 2019/2/20.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "RYQArray.h"

static NSUInteger const defaultCapacity = 10;
typedef id _Nullable (*RFUNC)(id _Nonnull, SEL _Nonnull, ...);
typedef void *AnyObject;

@interface RYQArray () {
    
@private
    
    AnyObject *_array;
    NSUInteger _size;
    NSUInteger _capacity;
    
}

@end

@implementation RYQArray

- (instancetype)init {
    
    if (self = [super init]) {
        _size = 0;
        _capacity = defaultCapacity;
        _array = (AnyObject *)calloc(_capacity, sizeof(AnyObject));
    }
    
    return self;
}

+ (instancetype)array {
    return [[RYQArray alloc] initWithCapacity:defaultCapacity];
}

+ (instancetype)arrayWithCapacity:(NSUInteger)numItems {
    return [[RYQArray alloc] initWithCapacity:numItems];
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    _capacity = numItems;
    _array = (AnyObject *)calloc(_capacity, sizeof(AnyObject));
    _size = 0;
    return self;
}

#pragma mark - 数组的添加插入操作

/**
 数组中的添加元素操作
 */
- (void)addObject:(id)anObject {
    [self insertObject:anObject atIndex:_size];
}
/**
 将一个元素插入到数组中的某个位置
 */
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index{
    
    //元素值不能为null
    if (!anObject) {
        @throw [NSException exceptionWithName:@"元素插入出现错误了" reason:@"元素值不能为null" userInfo:nil];
        return;
    }
    //判断数组越界
    if (index > _size) {
        @throw [NSException exceptionWithName:@"元素插入出现错误了" reason:@"你的数组已经越界了" userInfo:nil];
        return;
    }
    if (_size == _capacity) {
        //判断原来的数组是否已经满了 如果满了就需要增加数组长度
        [self resize:2 * _capacity];
    }
    //交换索引位置
    if (self.count > 0) {
        for (NSInteger i = _size - 1; i >= index; i--) {
            _array[i + 1] = _array[i];
        }
    }
    
    self->_array[index] = (__bridge_retained AnyObject)(anObject);
    _size++;
}

#pragma mark - 数组的删除清空操作

/**
 清空所有元素
 */
- (void)removeAllObjects {
    AnyObject *oldArray = _array;
    NSInteger i = _size - 1;
    while (i >= 0) {
        AnyObject *obj = oldArray[i];
        CFRelease(obj);
        i--;
    }
    if (oldArray != NULL) {
        free(oldArray);
        oldArray = NULL;
    }
    _size = 0;
    _capacity = defaultCapacity;
    _array = (AnyObject *)calloc(_capacity, sizeof(AnyObject));
}
/**
 移除某个下标下的元素
 */
- (void)removeObjectAtIndex:(NSUInteger)index {
    //判断数组越界
    if (index > _size) {
        @throw [NSException exceptionWithName:@"元素插入出现错误了" reason:@"你的数组已经越界了" userInfo:nil];
        return;
    }
    AnyObject object = (_array[index]);
    CFRelease(object);
    for (NSUInteger i = index + 1; i < _size; i++)
        _array[i-1] = _array[i];
    _size--;
    _array[_size] = NULL;
    //对数组空间进行缩减
    if (_size == _capacity * 0.25 && (_capacity * 0.25 != 0)) {
        [self resize:_capacity/2];
    }
}
/**
 移除某个元素
 */
- (void)removeObject:(id)anObject {
    NSInteger index = [self indexOfObject:anObject];
    if (index == NSNotFound) {
        return;
    }
    [self removeObjectAtIndex:index];
}
/**
 移除最后一个元素
 */
- (void)removeLastObject{
    if ([self isEmpty]) {
        return;
    }
    [self removeObjectAtIndex:_size-1];
}
/**
 对数组进行扩容
 */
- (void)resize:(NSInteger)capacity {
    
    _capacity = capacity;
    AnyObject *oldArray = _array;
    AnyObject *newArray = (AnyObject *)calloc(_capacity, sizeof(AnyObject));
    size_t size = sizeof(AnyObject) * self.count;
    memcpy(newArray, oldArray, size);//对旧的数组进行值的拷贝
    _array = newArray;
    if (oldArray != NULL) {
        free(oldArray);
        oldArray = NULL;
    }
}

#pragma mark - 修改操作

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    //元素值不能为null
    if (!anObject) {
        @throw [NSException exceptionWithName:@"元素插入出现错误了" reason:@"元素值不能为null" userInfo:nil];
        return;
    }
    //判断越界
    if (index > _size) {
        @throw [NSException exceptionWithName:@"元素插入出现错误了" reason:@"你的数组已经越界了" userInfo:nil];
        return;
    }
    _array[index] = (__bridge AnyObject)(anObject);
}

#pragma mark - 查询操作

- (BOOL)isEmpty {
    return (self->_size == 0);
}

- (BOOL)isFull {
    return (self->_size == self->_capacity-1);
}
/**
 通过下标取值
 */
- (id)objectAtIndex:(NSUInteger)index {
    //判断越界
    if (index > _size) {
        @throw [NSException exceptionWithName:@"元素插入出现错误了" reason:@"你的数组已经越界了" userInfo:nil];
        return nil;
    }
    if ([self isEmpty]) {
        return nil;
    }
    AnyObject obj = _array[index];
    if (obj == NULL) {
        return nil;
    }
    return (__bridge id)(obj);
}
/**
 通过值 获取相应的下标
 */
- (NSUInteger)indexOfObject:(id)anObject {
    for (int i = 0; i<_size; i++) {
        id obj = (__bridge id)(_array[i]);
        if ([anObject isEqual:obj]) {
            return i;
        }
    }
    return NSNotFound;
}
/**
 数组中是否包含该元素
 */
- (BOOL)containsObject:(id)anObject{
    for (int i = 0; i<_size; i++) {
        id obj = (__bridge id)(_array[i]);
        if ([anObject isEqual:obj]) {
            return YES;
        }
    }
    return NO;
}
/**
 第一个元素
 */
- (id)firstObject{
    if ([self isEmpty]) {
        return nil;
    }
    return (__bridge id _Nullable)(_array[0]);
}
/**
 最后一个元素
 */
- (id)lastObject {
    if ([self isEmpty]) {
        return nil;
    }
    return (__bridge id _Nullable)(_array[_size-1]);
}

- (NSUInteger)count{
    return _size;
}

/**
 拷贝一个新的数组 使新数组内容 和 原来数组内容一样
 
 @return RYQArray
 */
- (RYQArray *)copyNewArray {
    AnyObject *oldArray = _array;
    RYQArray *newArray = [RYQArray arrayWithCapacity:_capacity];
    size_t size = sizeof(AnyObject) *_capacity;
    memcpy(newArray->_array, oldArray, size);
    return newArray;
}

- (void)dealloc{
    if (_array != NULL) {
        NSInteger i = _size - 1;
        while (i >= 0) {
            AnyObject *obj = _array[i];
            if (obj != NULL) {
//                CFRelease(obj);
            }
            i--;
        }
        free(_array);
    }
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString stringWithFormat:@"\nRYQArray %p : [ \n", self];
    for (int i = 0; i < _size; i++) {
        AnyObject obj = _array[i];
        [string appendFormat:@"%@", (__bridge id)obj];
        if (i < _size-1) {
            [string appendString:@" , \n"];
        }
    }
    [string appendString:@"\n]\n"];
    
    return string;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len{
    
    NSInteger count;
    
    state->mutationsPtr = (unsigned long *)&state->mutationsPtr;
    count = MIN(len, [self count]-state->state);
    
    if (count > 0) {
        IMP imp = [self methodForSelector:@selector(objectAtIndex:)];
        int p = (int)state->state;
        int i;
        
        for (i = 0; i < count; i++, p++) {
            RFUNC funcPt = (RFUNC)imp;
            id objc = funcPt(self, @selector(objectAtIndex:), p);
            buffer[i] = objc;
        }
        state->state += count;
    }else{
        count = 0;
    }
    state->itemsPtr = buffer;
    
    return count;
}

@end
