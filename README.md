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
- [DrupalEntity pushToServer]       //to post data to server.
- [DrupalEntity pullFromServer]     //to pull data from server.
- [DrupalEntity deleteFromServer]   //to remove data from server.
- [DrupalEntity patchServerData]    //to patch  patch data to server.
```
###2. Responses are not binded to entities only
Besides of entity api provides few more handy structures:
```NSArray``` / ```NSDictionary``` can manage drupal and non-drupal entities, providing them with all DrupalEntity methods like post, push, pull, delete.
###3. Object serialization/deserialization
Library automatically serializes/deserializes objects including attached objects and arrays of objects. Because objective c does not support strongly typed arrays you have to implement method: ```- (Class)classByPropertyName:(NSString *)propertyName;``` and return class of objects of array. If your ```DrupalEntity``` class fetch array of objects with other type, e.g. blog page entity pulls blog posts, you have to implement method: ```- (Class)classOfItems:(NSString *)propertyName;``` and return class of items for deserialization.

###Other details
####ResponseData
```DrupalEntity``` object or array of objects (depend on response).
####DrupalAPIManager
Object, containing server base URL and is responsible for server request generation and posting to server. You have to set ```DrupalAPIManager.baseURL``` before making action with DrupalEntity instance.
####AFHTTPRequestOperationManager+DrupalLib.h
Category extends manager of ```AFNetworking``` and is used in DrupalAPIManager. Will be imporoved and extended to support login scheme.

###Code samples
####1. Implement DrupalEntity:
In order to implement drupal entity you just have to extend ```DrupalEntity``` and implement following methods:

#####path
this method will return relative path to entity on the server.

    - (NSString *)path {
        return [NSString stringWithFormat:@"node/%@", self.nid]
    ;}

#####requestGETParams
this method will return item get parameters if needed. 

    - (NSDictionary *)requestGETParams {
        return @{@"page": self.page};
    }

####2. Set server url

    [DrupalAPIManager sharedDrupalAPIManager].baseURL = [NSURL URLWithString:@"http://myserver.com"];

####3. Instantiate DrupalEntity

    BlogPage *bp = [BlogPage new];
    bp.page = @(page);
    [bp pullFromServer:nil];