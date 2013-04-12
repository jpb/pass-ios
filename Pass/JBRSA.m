//
//  JBRSA.m
//  Pass
//
//  Created by James Brennan on 2013-04-06.
//  Copyright (c) 2013 PassAuth. All rights reserved.
//

#import "JBRSA.h"

@implementation JBRSA

- (id)init {
    
    if (self = [super init])
    {
        //TODO Do we need to RAND_add here?
        self.rsa = RSA_generate_key(2048, 65537, NULL, NULL);
        
        if(self.rsa == NULL)
        {
            NSLog(@"RSA_generate_key error: %lu", (unsigned long) ERR_get_error());
        }
        else
        {
            // Extact keys as pems
            BIO *bufio;
            int success;
            int keyLength;
            char *pemKey;
            
            // Get private key pem
            bufio = BIO_new(BIO_s_mem());
            success = PEM_write_bio_RSAPrivateKey(bufio, self.rsa, NULL, NULL, 0, NULL, NULL);
            
            if(success == 0)
            {
                NSLog(@"PEM_write_bio_RSAPrivateKey error: %lu", (unsigned long) ERR_get_error());
            }
            
            keyLength = BIO_pending(bufio);
            pemKey = calloc(keyLength + 1, 1);
            BIO_read(bufio, pemKey, keyLength);
            
            self.privateKey = [NSString stringWithFormat:@"%s", pemKey];
            
            // Get public key pem
            bufio = BIO_new(BIO_s_mem());
            success = PEM_write_bio_RSAPublicKey(bufio, self.rsa);
            
            if(success == 0)
            {
                NSLog(@"PEM_write_bio_RSAPublicKey error: %lu", (unsigned long) ERR_get_error());
            }
            
            keyLength = BIO_pending(bufio);
            pemKey = calloc(keyLength + 1, 1);
            BIO_read(bufio, pemKey, keyLength);
            
            self.publicKey = [NSString stringWithFormat:@"%s", pemKey];
        }
    }
    
    return self;
}

- (id)initWithPrivateKey: (NSString *)privateKey {
    
    if (self = [super init])
    {
        [self loadPrivateKey:privateKey];
        self.privateKey = privateKey;
    }
    
    return self;
}

- (id)initWithPrivateKey: (NSString *)privateKey withPublicKey:(NSString *)publicKey {
    
    if (self = [super init])
    {
        [self loadPrivateKey:privateKey];
        self.privateKey = privateKey;
        
        if( ! [publicKey isEqualToString:@""])
        {
            self.publicKey = publicKey;
            [self loadPublicKey:publicKey];
        }
    }
    
    return self;
}

- (void)loadPublicKey:(NSString*) key {
    const char *p = (char *)[key UTF8String];
    NSUInteger byteCount = [key lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    BIO *bufio = BIO_new_mem_buf((void*)p, byteCount);
    // Cannot send properties by reference - gets 'Address of property expression requested' error
    // Use a local variable instead for self.rsa
    RSA *r = self.rsa;
    
    r = PEM_read_bio_RSAPublicKey(bufio, &r, NULL, NULL);
    
    if(r == NULL)
    {
        NSLog(@"PEM_read_bio_RSAPublicKey error: %lu", (unsigned long) ERR_get_error());
    }
    
    self.rsa = r;
}

- (void)loadPrivateKey:(NSString*) key {
    const char *p = (char *)[key UTF8String];
    NSUInteger byteCount = [key lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    BIO *bufio;
    bufio = BIO_new_mem_buf((void*)p, byteCount);
    // Cannot send properties by reference - gets 'Address of property expression requested' error
    // Use a local variable instead for self.rsa
    RSA *r = self.rsa;
    
    r = PEM_read_bio_RSAPrivateKey(bufio, &r, NULL, NULL);
    
    if(r == NULL)
    {
        NSLog(@"PEM_read_bio_RSAPrivateKey error: %lu", (unsigned long) ERR_get_error());
    }
    
    self.rsa = r;
}


- (NSString *)publicEncrypt:(NSString*)plaintext {
    unsigned char *from = (unsigned char *)[plaintext UTF8String];
    unsigned char *to = malloc(RSA_size(self.rsa));
    
    int success = RSA_public_encrypt((int) plaintext.length, from, to, self.rsa, RSA_PKCS1_PADDING);
    
    if( success == -1)
    {
        NSLog(@"RSA_public_encrypt error: %lu", (unsigned long) ERR_get_error());
    }
    
    return [NSString stringWithFormat:@"%s", to];
}

- (NSString *)privateEncrypt:(NSString*)plaintext {
    unsigned char *from = (unsigned char *)[plaintext UTF8String];
    unsigned char *to = malloc(RSA_size(self.rsa));
    
    int success = RSA_private_encrypt((int) plaintext.length, from, to, self.rsa, RSA_PKCS1_PADDING);
    
    if( success == -1)
    {
        NSLog(@"RSA_private_encrypt error: %lu", (unsigned long) ERR_get_error());
    }
    
    return [NSString stringWithFormat:@"%s", to];
}
@end