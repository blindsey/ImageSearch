//
//  Google.h
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GoogleClient : NSObject

+ (void)imagesWithSearchTerm:(NSString *)searchTerm callback:(void (^)(NSError *error, NSHTTPURLResponse *response, NSArray *results))callback;

@end
