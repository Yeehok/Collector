//
//  DataItemStore.h
//  Collector
//
//  Created by Yeehok on 2016/10/21.
//  Copyright © 2016年 Yeehok. All rights reserved.
//

#import "DataItem.h"

@interface DataItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)getInstance;

- (DataItem *)createItem;

@end
