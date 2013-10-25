//
//  Image.m
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import "Image.h"

@implementation Image

- (id)initWithDictionary:(NSDictionary *)data
{
    self = [self init];
    if (self) {
        _thumbUrl = [data objectForKey:@"tbUrl"];
        _thumbHeight = [[data objectForKey:@"tbHeight"] integerValue];
        _thumbWidth = [[data objectForKey:@"tbWidth"] integerValue];
        _url = [data objectForKey:@"url"];
    }
    return self;
}

+ (NSArray *)imagesFromArray:(NSArray *)array
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        Image *image = [[Image alloc] initWithDictionary:dict];
        [results addObject:image];
    }
    return results;
}

@end
