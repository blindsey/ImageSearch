//
//  Google.m
//  ImageSearch
//
//  Created by Ben Lindsey on 10/25/13.
//  Copyright (c) 2013 Ben Lindsey. All rights reserved.
//

#import "GoogleClient.h"
#import "Image.h"

@implementation GoogleClient

+ (void)imagesWithSearchTerm:(NSString *)searchTerm callback:(void (^)(NSError *error, NSHTTPURLResponse *response, NSArray *results))callback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@", [searchTerm stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
        id results = [JSON valueForKeyPath:@"responseData.results"];
        if ([results isKindOfClass:[NSArray class]]) {
            NSArray *images = [Image imagesFromArray:results];
            callback(nil, response, images);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        callback(error, response, nil);
    }];
    
    [operation start];
}
@end
