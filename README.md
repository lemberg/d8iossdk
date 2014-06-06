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
Library automatically serializes/deserializes objects, including attached objects and arrays of objects. 

**Note:** all properties of your ```DrupalEntity``` subclass should not be primitives. 

Because objective c does not support strongly typed arrays you have to implement method: ```- (Class)classOfItems:(NSString *)propertyName``` and return class of objects of array by a property name.

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
Besides of entity api provides few more handy structures: NSArray, NSDictionary, NSString and NSNumber and can manage drupal and non-drupal entities.

If you need to pull list of objects from server in one request you just should use completion handler (```void (^EntityActionHandler)(id result)```). To get a list of objects of another ```DrupalEntity``` subclass return items' class in ```- (Class)classOfItems:(NSString *)propertyName``` method. 

For example to pull blog posts by pages we have two classes: ```BlogPage``` and ```BlogPostPreview``` that are inherited from ```DrupalEntity``` (see SampleApp project).
```BlogPage``` class has a property ```NSNumber *page``` that indicates number of page and overrides method:

    - (Class)classOfItems:(NSString *)propertyName {
        return [BlogPostPreview class];
    }

Pulling ```BlogPostPreview``` objects from server:

    BlogPage *bp = [BlogPage new];
    bp.page = @(1);
    [bp pullFromServer:^(NSArray *result) {
        if (result) {
            //  Do something with an array of BlogPostPreview objects
        }
    }];
    
When server returns a list of objects library calls ```classOfItems``` for item's type and deserializes it. If you don't override this method or return nil, library will just use the class of called entity.

###4. DrupalAPIManager
Object, containing server base URL and is responsible for server request generation and posting to server. You have to set ```DrupalAPIManager.baseURL``` before making action with DrupalEntity instance.

Additional methods that you can use to implement custom workflow:

    - (void)getEntity:(DrupalEntity *)entity completeHandler:(CompleteHandler)block;     //  Get entity from server 
    - (void)postEntity:(DrupalEntity *)entity completeHandler:(CompleteHandler)block;     //  Post entity to server
    
    typedef void (^CompletionHandler)(id response, NSError *error);
    
Example:

        [[DrupalAPIManager sharedDrupalAPIManager] postEntity:someEntity completeHandler:^(id object, NSError *error) {
                                              if (error) {
                                                  //    Something went wrong, log error
                                              } else {
                                                  //    Do something with object
                                              }
                                          }];

###5. Other details
####ResponseData
```DrupalEntity``` object or array of objects (depends on response). 
####AFHTTPRequestOperationManager+DrupalLib.h
Category extends manager of ```AFNetworking``` and is used in DrupalAPIManager. Will be imporoved and extended to support login scheme.
####Transient fields

If field should not be serialized or deserialized override method ```- (BOOL)isPropertyTransient:(NSString *)propertyName``` and return YES of transient property by name:

    - (BOOL)isPropertyTransient:(NSString *)propertyName
    {
        if ([propertyName isEqualToString:@"somePropertyName"])
            return YES;     //  Property is transient and won't be serialized.
        return NO;
    }
    
**Note:** you can override ```- (NSDictionary *)toJSONDictionary``` method and return custom serialized object.

###6. Code samples
####1. Implement DrupalEntity:
In order to implement drupal entity you just have to extend ```DrupalEntity```, declare properties and implement following methods:

#####path
this method should return relative path to entity on the server:

    - (NSString *)path 
    {
        return [NSString stringWithFormat:@"node/%@", self.nodeId];
    }

#####requestGETParams
this method should return get parameters: 

    - (NSDictionary *)requestGETParams 
    {
        return @{@"page": self.page};       //  Path will be http://myserver.com/?page=10 if self.page value is 10
    }

####2. Set server url

Set base url of server before first action with ```DrupalEntity``` object:

    [DrupalAPIManager sharedDrupalAPIManager].baseURL = [NSURL URLWithString:@"http://myserver.com"];

####3. Instantiate DrupalEntity

    BlogPage *bp = [BlogPage new];
    bp.page = @(page);
    [bp pullFromServer:nil];
    
####4. Using completion block

Completion block is defined as: ```typedef void (^EntityActionHandler)(id result);```. If response was gotten and deserialized result is an ```DrupalEntity``` object otherwise ```nil```.

    [bp pullFromServer:^(id result) {
        if (!result) {
            //  Something went wrong, object was not pulled from server
        } else {
            //  Do something with object
        }
    }];
    

## Installation

LSDrupalSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'LSDrupalSDK', '0.1.0'

## Usage

To run the sample project; clone the repo, and run `pod install` from the SampleApp directory first.

## License

LSDrupalSDK is available under the MIT license. See the LICENSE file for more info.
