//
//  Google.h
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleClient : NSObject

// API only returns 8 at a time
+ (void)imagesWithSearchTerm:(NSString *)searchTerm start:(NSUInteger)start callback:(void (^)(NSError *error, NSHTTPURLResponse *response, NSArray *results))callback;

@end
