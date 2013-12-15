//
//  LinkedList.m
//  Dogo iOS
//
//  Created by Marcus Westin on 12/14/13.
//  Copyright (c) 2013 Flutterby Labs Inc. All rights reserved.
//

#import "LinkedList.h"

@interface Link : NSObject
@property Link* prev;
@property Link* next;
@property id object;
+ (instancetype)withObject:(id)object;
@end

@implementation Link
+ (instancetype)withObject:(id)object {
    Link* link = [[[self class] alloc] init];
    link.object = object;
    return link;
}
@end

@interface LinkedList ()
@property Link* head;
@property Link* tail;
@end

@implementation LinkedList
- (BOOL)isEmpty {
    return !_head;
}
- (void)push:(id)obj {
    Link* newHead = [Link withObject:obj];
    if ([self isEmpty]) {
        _head = _tail = newHead;
    } else {
        newHead.prev = _head;
        _head.next = newHead;
        _head = newHead;
    }
}
- (void)unshift:(id)obj {
    Link* newTail = [Link withObject:obj];
    if ([self isEmpty]) {
        _head = _tail = newTail;
    } else {
        newTail.next = _tail;
        _tail.prev = newTail;
        _tail = newTail;
    }
}
- (id)first {
    return _tail;
}
- (id)last {
    return _head;
}
- (id)pop {
    id object = _head.object;
    _head = _head.prev;
    return object;
}
- (id)shift {
    id object = _tail.object;
    _tail = _tail.next;
    return object;
}
@end
