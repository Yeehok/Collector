//
//  DataItemModel.h
//  Collector
//
//  Created by Yeehok on 2016/10/31.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "UIBase.h"

#import "DataItemGroup.h"

@interface DataItemModel : NSObject

@property (nonatomic, strong, readonly, getter=allGroups) NSArray *allGroups;

+ (instancetype)getInstance;

- (void)insertGroupWithInitialiseItem:(DataItem *)item atIndex:(NSUInteger)index;

- (void)createGroupWithInitialiseItem:(DataItem *)item;

- (void)removeGroup:(DataItemGroup *)group;

@end
