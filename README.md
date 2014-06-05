**Drupal8 iOS SDK**
=====================


#Introduction
Drupal8 iOS SDK is a library for native iOS applications to communicate with Drupal web servers. 

Currently library is using [AFNetworking](https://github.com/AFNetworking/AFNetworking "AFNetworking") for communication with server. 

Main purpose of this library is to make communication with Drupal 8 - based servers as easy and intuitive as possible. 


----------

##Main features
###1. Requests are binded to entities

You can simply call
```
[DrupalEntity pushToServer];         // to post data to server.
[DrupalEntity pullFromServer];       // to pull data from server.
[DrupalEntity deleteFromServer];     // to remove data from server.
[DrupalEntity patchServerData];      // to patch  patch data to server.
```

###2. Object serialization/deserialization
Library automatically serializes/deserializes objects, including attached objects and arrays of objects. Because objective c does not support strongly typed arrays you have to implement method: ```- (Class)classOfItems:(NSString *)propertyName``` and return class of objects of array by a property name.

    - (Class)classOfItems:(NSString *)propertyName 
    {
        if ([propertyName isEqualToString:@"someArrayPropertyName"])
            return [MyDrupalEntity class];      //  Array of MyDrupalEntity objects
        return nil;                             //  Array of not DrupalEntity objects
    }

To configure serialized data you can override method ```- (NSDictionary *)toJSONDictionary``` of ```DrupalEntity``` class and return needed content. This method is called before each not-safe request.

    - (NSDictionary *)toJSONDictionary 
    {
        // Do custom entity serialization here
    }

###3. Responses are not binded to entities only
Besides of entity api provides few more handy structures: NSArray / NSDictionary can manage drupal and non-drupal entities, providing them with all DrupalEntity methods like post, push, pull, delete.

###4. Other details
####ResponseData
```DrupalEntity``` object or array of objects (depends on response).
####DrupalAPIManager
Object, containing server base URL and is responsible for server request generation and posting to server. You have to set ```DrupalAPIManager.baseURL``` before making action with DrupalEntity instance.
####AFHTTPRequestOperationManager+DrupalLib.h
Category extends manager of ```AFNetworking``` and is used in DrupalAPIManager. Will be imporoved and extended to support login scheme.
####Transient fields

If field should not be serialized or deserialized override method ```- (BOOL)isPropertyTransient:(NSString *)propertyName``` and return YES for needed property name.

###5. Code samples
####1. Implement DrupalEntity:
In order to implement drupal entity you just have to extend ```DrupalEntity``` and implement following methods:

#####path
this method will return relative path to entity on the server.

    - (NSString *)path 
    {
        return [NSString stringWithFormat:@"node/%@", self.nid];
    }

#####requestGETParams
this method will return item get parameters if needed. 

    - (NSDictionary *)requestGETParams 
    {
        return @{@"page": self.page};
    }

####2. Set server url

    [DrupalAPIManager sharedDrupalAPIManager].baseURL = [NSURL URLWithString:@"http://myserver.com"];

####3. Instantiate DrupalEntity

    BlogPage *bp = [BlogPage new];
    bp.page = @(page);
    [bp pullFromServer:nil];


## Installation

LSDrupalSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "LSDrupalSDK"

## Usage

To run the sample project; clone the repo, and run `pod install` from the SampleApp directory first.

## License

LSDrupalSDK is available under the MIT license. See the LICENSE file for more info.
