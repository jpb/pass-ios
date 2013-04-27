#ifndef crypto_stream_H
#define crypto_stream_H

#include "crypto_stream_aes128ctr.h"

#define crypto_stream crypto_stream_aes128ctr
#define crypto_stream_xor crypto_stream_aes128ctr_xor
#define crypto_stream_beforenm crypto_stream_aes128ctr_beforenm
#define crypto_stream_afternm crypto_stream_aes128ctr_afternm
#define crypto_stream_xor_afternm crypto_stream_aes128ctr_xor_afternm
#define crypto_stream_KEYBYTES crypto_stream_aes128ctr_KEYBYTES
#define crypto_stream_NONCEBYTES crypto_stream_aes128ctr_NONCEBYTES
#define crypto_stream_BEFORENMBYTES crypto_stream_aes128ctr_BEFORENMBYTES
#define crypto_stream_PRIMITIVE "aes128ctr"
#define crypto_stream_IMPLEMENTATION crypto_stream_aes128ctr_IMPLEMENTATION
#define crypto_stream_VERSION crypto_stream_aes128ctr_VERSION

#endif
