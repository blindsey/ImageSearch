//
//  Image.h
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

- (id)initWithDictionary:(NSDictionary *)data;

@property (assign, nonatomic, readonly) NSInteger thumbHeight;
@property (assign, nonatomic, readonly) NSInteger thumbWidth;
@property (strong, nonatomic, readonly) NSString *thumbUrl;

@property (strong, nonatomic, readonly) NSString *url;
@property (strong, nonatomic, readonly) NSString *originalContextUrl;

+ (NSArray *)imagesFromArray:(NSArray *)array;

@end
