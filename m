From: Roman Pen <r.peniaev@gmail.com>
Subject: [PATCH 1/2] mmc-utils: RPMB: add HMAC SHA256 support
Date: Mon, 21 Jul 2014 21:53:44 +0900
Message-ID: <1405947225-6347-2-git-send-email-r.peniaev@gmail.com>
References: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64168 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbaGUMx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jul 2014 08:53:57 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so9771708pac.4
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jul 2014 05:53:56 -0700 (PDT)
In-Reply-To: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Roman Pen <r.peniaev@gmail.com>

RPMB requires digital signature of the message.
Take the implementation of HMAC SHA256 from this
place https://github.com/ogay/hmac.git

Actually this is BSD license, IANAL but according
to my understanding nothing terrible will happen
if we provide all the original copyrights.

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 3rdparty/hmac_sha/hmac_sha2.c | 544 ++++++++++++++++++++++++
 3rdparty/hmac_sha/hmac_sha2.h | 140 +++++++
 3rdparty/hmac_sha/sha2.c      | 949 ++++++++++++++++++++++++++++++++++++++++++
 3rdparty/hmac_sha/sha2.h      | 108 +++++
 Makefile                      |   8 +-
 5 files changed, 1747 insertions(+), 2 deletions(-)
 create mode 100644 3rdparty/hmac_sha/hmac_sha2.c
 create mode 100644 3rdparty/hmac_sha/hmac_sha2.h
 create mode 100644 3rdparty/hmac_sha/sha2.c
 create mode 100644 3rdparty/hmac_sha/sha2.h

diff --git a/3rdparty/hmac_sha/hmac_sha2.c b/3rdparty/hmac_sha/hmac_sha2.c
new file mode 100644
index 0000000..1130ebf
--- /dev/null
+++ b/3rdparty/hmac_sha/hmac_sha2.c
@@ -0,0 +1,544 @@
+/*
+ * HMAC-SHA-224/256/384/512 implementation
+ * Last update: 06/15/2005
+ * Issue date:  06/15/2005
+ *
+ * Copyright (C) 2005 Olivier Gay <olivier.gay@a3.epfl.ch>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the project nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <string.h>
+
+#include "hmac_sha2.h"
+
+/* HMAC-SHA-224 functions */
+
+void hmac_sha224_init(hmac_sha224_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size)
+{
+    unsigned int fill;
+    unsigned int num;
+
+    const unsigned char *key_used;
+    unsigned char key_temp[SHA224_DIGEST_SIZE];
+    int i;
+
+    if (key_size == SHA224_BLOCK_SIZE) {
+        key_used = key;
+        num = SHA224_BLOCK_SIZE;
+    } else {
+        if (key_size > SHA224_BLOCK_SIZE){
+            num = SHA224_DIGEST_SIZE;
+            sha224(key, key_size, key_temp);
+            key_used = key_temp;
+        } else { /* key_size > SHA224_BLOCK_SIZE */
+            key_used = key;
+            num = key_size;
+        }
+        fill = SHA224_BLOCK_SIZE - num;
+
+        memset(ctx->block_ipad + num, 0x36, fill);
+        memset(ctx->block_opad + num, 0x5c, fill);
+    }
+
+    for (i = 0; i < (int) num; i++) {
+        ctx->block_ipad[i] = key_used[i] ^ 0x36;
+        ctx->block_opad[i] = key_used[i] ^ 0x5c;
+    }
+
+    sha224_init(&ctx->ctx_inside);
+    sha224_update(&ctx->ctx_inside, ctx->block_ipad, SHA224_BLOCK_SIZE);
+
+    sha224_init(&ctx->ctx_outside);
+    sha224_update(&ctx->ctx_outside, ctx->block_opad,
+                  SHA224_BLOCK_SIZE);
+
+    /* for hmac_reinit */
+    memcpy(&ctx->ctx_inside_reinit, &ctx->ctx_inside,
+           sizeof(sha224_ctx));
+    memcpy(&ctx->ctx_outside_reinit, &ctx->ctx_outside,
+           sizeof(sha224_ctx));
+}
+
+void hmac_sha224_reinit(hmac_sha224_ctx *ctx)
+{
+    memcpy(&ctx->ctx_inside, &ctx->ctx_inside_reinit,
+           sizeof(sha224_ctx));
+    memcpy(&ctx->ctx_outside, &ctx->ctx_outside_reinit,
+           sizeof(sha224_ctx));
+}
+
+void hmac_sha224_update(hmac_sha224_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len)
+{
+    sha224_update(&ctx->ctx_inside, message, message_len);
+}
+
+void hmac_sha224_final(hmac_sha224_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size)
+{
+    unsigned char digest_inside[SHA224_DIGEST_SIZE];
+    unsigned char mac_temp[SHA224_DIGEST_SIZE];
+
+    sha224_final(&ctx->ctx_inside, digest_inside);
+    sha224_update(&ctx->ctx_outside, digest_inside, SHA224_DIGEST_SIZE);
+    sha224_final(&ctx->ctx_outside, mac_temp);
+    memcpy(mac, mac_temp, mac_size);
+}
+
+void hmac_sha224(const unsigned char *key, unsigned int key_size,
+          const unsigned char *message, unsigned int message_len,
+          unsigned char *mac, unsigned mac_size)
+{
+    hmac_sha224_ctx ctx;
+
+    hmac_sha224_init(&ctx, key, key_size);
+    hmac_sha224_update(&ctx, message, message_len);
+    hmac_sha224_final(&ctx, mac, mac_size);
+}
+
+/* HMAC-SHA-256 functions */
+
+void hmac_sha256_init(hmac_sha256_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size)
+{
+    unsigned int fill;
+    unsigned int num;
+
+    const unsigned char *key_used;
+    unsigned char key_temp[SHA256_DIGEST_SIZE];
+    int i;
+
+    if (key_size == SHA256_BLOCK_SIZE) {
+        key_used = key;
+        num = SHA256_BLOCK_SIZE;
+    } else {
+        if (key_size > SHA256_BLOCK_SIZE){
+            num = SHA256_DIGEST_SIZE;
+            sha256(key, key_size, key_temp);
+            key_used = key_temp;
+        } else { /* key_size > SHA256_BLOCK_SIZE */
+            key_used = key;
+            num = key_size;
+        }
+        fill = SHA256_BLOCK_SIZE - num;
+
+        memset(ctx->block_ipad + num, 0x36, fill);
+        memset(ctx->block_opad + num, 0x5c, fill);
+    }
+
+    for (i = 0; i < (int) num; i++) {
+        ctx->block_ipad[i] = key_used[i] ^ 0x36;
+        ctx->block_opad[i] = key_used[i] ^ 0x5c;
+    }
+
+    sha256_init(&ctx->ctx_inside);
+    sha256_update(&ctx->ctx_inside, ctx->block_ipad, SHA256_BLOCK_SIZE);
+
+    sha256_init(&ctx->ctx_outside);
+    sha256_update(&ctx->ctx_outside, ctx->block_opad,
+                  SHA256_BLOCK_SIZE);
+
+    /* for hmac_reinit */
+    memcpy(&ctx->ctx_inside_reinit, &ctx->ctx_inside,
+           sizeof(sha256_ctx));
+    memcpy(&ctx->ctx_outside_reinit, &ctx->ctx_outside,
+           sizeof(sha256_ctx));
+}
+
+void hmac_sha256_reinit(hmac_sha256_ctx *ctx)
+{
+    memcpy(&ctx->ctx_inside, &ctx->ctx_inside_reinit,
+           sizeof(sha256_ctx));
+    memcpy(&ctx->ctx_outside, &ctx->ctx_outside_reinit,
+           sizeof(sha256_ctx));
+}
+
+void hmac_sha256_update(hmac_sha256_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len)
+{
+    sha256_update(&ctx->ctx_inside, message, message_len);
+}
+
+void hmac_sha256_final(hmac_sha256_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size)
+{
+    unsigned char digest_inside[SHA256_DIGEST_SIZE];
+    unsigned char mac_temp[SHA256_DIGEST_SIZE];
+
+    sha256_final(&ctx->ctx_inside, digest_inside);
+    sha256_update(&ctx->ctx_outside, digest_inside, SHA256_DIGEST_SIZE);
+    sha256_final(&ctx->ctx_outside, mac_temp);
+    memcpy(mac, mac_temp, mac_size);
+}
+
+void hmac_sha256(const unsigned char *key, unsigned int key_size,
+          const unsigned char *message, unsigned int message_len,
+          unsigned char *mac, unsigned mac_size)
+{
+    hmac_sha256_ctx ctx;
+
+    hmac_sha256_init(&ctx, key, key_size);
+    hmac_sha256_update(&ctx, message, message_len);
+    hmac_sha256_final(&ctx, mac, mac_size);
+}
+
+/* HMAC-SHA-384 functions */
+
+void hmac_sha384_init(hmac_sha384_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size)
+{
+    unsigned int fill;
+    unsigned int num;
+
+    const unsigned char *key_used;
+    unsigned char key_temp[SHA384_DIGEST_SIZE];
+    int i;
+
+    if (key_size == SHA384_BLOCK_SIZE) {
+        key_used = key;
+        num = SHA384_BLOCK_SIZE;
+    } else {
+        if (key_size > SHA384_BLOCK_SIZE){
+            num = SHA384_DIGEST_SIZE;
+            sha384(key, key_size, key_temp);
+            key_used = key_temp;
+        } else { /* key_size > SHA384_BLOCK_SIZE */
+            key_used = key;
+            num = key_size;
+        }
+        fill = SHA384_BLOCK_SIZE - num;
+
+        memset(ctx->block_ipad + num, 0x36, fill);
+        memset(ctx->block_opad + num, 0x5c, fill);
+    }
+
+    for (i = 0; i < (int) num; i++) {
+        ctx->block_ipad[i] = key_used[i] ^ 0x36;
+        ctx->block_opad[i] = key_used[i] ^ 0x5c;
+    }
+
+    sha384_init(&ctx->ctx_inside);
+    sha384_update(&ctx->ctx_inside, ctx->block_ipad, SHA384_BLOCK_SIZE);
+
+    sha384_init(&ctx->ctx_outside);
+    sha384_update(&ctx->ctx_outside, ctx->block_opad,
+                  SHA384_BLOCK_SIZE);
+
+    /* for hmac_reinit */
+    memcpy(&ctx->ctx_inside_reinit, &ctx->ctx_inside,
+           sizeof(sha384_ctx));
+    memcpy(&ctx->ctx_outside_reinit, &ctx->ctx_outside,
+           sizeof(sha384_ctx));
+}
+
+void hmac_sha384_reinit(hmac_sha384_ctx *ctx)
+{
+    memcpy(&ctx->ctx_inside, &ctx->ctx_inside_reinit,
+           sizeof(sha384_ctx));
+    memcpy(&ctx->ctx_outside, &ctx->ctx_outside_reinit,
+           sizeof(sha384_ctx));
+}
+
+void hmac_sha384_update(hmac_sha384_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len)
+{
+    sha384_update(&ctx->ctx_inside, message, message_len);
+}
+
+void hmac_sha384_final(hmac_sha384_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size)
+{
+    unsigned char digest_inside[SHA384_DIGEST_SIZE];
+    unsigned char mac_temp[SHA384_DIGEST_SIZE];
+
+    sha384_final(&ctx->ctx_inside, digest_inside);
+    sha384_update(&ctx->ctx_outside, digest_inside, SHA384_DIGEST_SIZE);
+    sha384_final(&ctx->ctx_outside, mac_temp);
+    memcpy(mac, mac_temp, mac_size);
+}
+
+void hmac_sha384(const unsigned char *key, unsigned int key_size,
+          const unsigned char *message, unsigned int message_len,
+          unsigned char *mac, unsigned mac_size)
+{
+    hmac_sha384_ctx ctx;
+
+    hmac_sha384_init(&ctx, key, key_size);
+    hmac_sha384_update(&ctx, message, message_len);
+    hmac_sha384_final(&ctx, mac, mac_size);
+}
+
+/* HMAC-SHA-512 functions */
+
+void hmac_sha512_init(hmac_sha512_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size)
+{
+    unsigned int fill;
+    unsigned int num;
+
+    const unsigned char *key_used;
+    unsigned char key_temp[SHA512_DIGEST_SIZE];
+    int i;
+
+    if (key_size == SHA512_BLOCK_SIZE) {
+        key_used = key;
+        num = SHA512_BLOCK_SIZE;
+    } else {
+        if (key_size > SHA512_BLOCK_SIZE){
+            num = SHA512_DIGEST_SIZE;
+            sha512(key, key_size, key_temp);
+            key_used = key_temp;
+        } else { /* key_size > SHA512_BLOCK_SIZE */
+            key_used = key;
+            num = key_size;
+        }
+        fill = SHA512_BLOCK_SIZE - num;
+
+        memset(ctx->block_ipad + num, 0x36, fill);
+        memset(ctx->block_opad + num, 0x5c, fill);
+    }
+
+    for (i = 0; i < (int) num; i++) {
+        ctx->block_ipad[i] = key_used[i] ^ 0x36;
+        ctx->block_opad[i] = key_used[i] ^ 0x5c;
+    }
+
+    sha512_init(&ctx->ctx_inside);
+    sha512_update(&ctx->ctx_inside, ctx->block_ipad, SHA512_BLOCK_SIZE);
+
+    sha512_init(&ctx->ctx_outside);
+    sha512_update(&ctx->ctx_outside, ctx->block_opad,
+                  SHA512_BLOCK_SIZE);
+
+    /* for hmac_reinit */
+    memcpy(&ctx->ctx_inside_reinit, &ctx->ctx_inside,
+           sizeof(sha512_ctx));
+    memcpy(&ctx->ctx_outside_reinit, &ctx->ctx_outside,
+           sizeof(sha512_ctx));
+}
+
+void hmac_sha512_reinit(hmac_sha512_ctx *ctx)
+{
+    memcpy(&ctx->ctx_inside, &ctx->ctx_inside_reinit,
+           sizeof(sha512_ctx));
+    memcpy(&ctx->ctx_outside, &ctx->ctx_outside_reinit,
+           sizeof(sha512_ctx));
+}
+
+void hmac_sha512_update(hmac_sha512_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len)
+{
+    sha512_update(&ctx->ctx_inside, message, message_len);
+}
+
+void hmac_sha512_final(hmac_sha512_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size)
+{
+    unsigned char digest_inside[SHA512_DIGEST_SIZE];
+    unsigned char mac_temp[SHA512_DIGEST_SIZE];
+
+    sha512_final(&ctx->ctx_inside, digest_inside);
+    sha512_update(&ctx->ctx_outside, digest_inside, SHA512_DIGEST_SIZE);
+    sha512_final(&ctx->ctx_outside, mac_temp);
+    memcpy(mac, mac_temp, mac_size);
+}
+
+void hmac_sha512(const unsigned char *key, unsigned int key_size,
+          const unsigned char *message, unsigned int message_len,
+          unsigned char *mac, unsigned mac_size)
+{
+    hmac_sha512_ctx ctx;
+
+    hmac_sha512_init(&ctx, key, key_size);
+    hmac_sha512_update(&ctx, message, message_len);
+    hmac_sha512_final(&ctx, mac, mac_size);
+}
+
+#ifdef TEST_VECTORS
+
+/* IETF Validation tests */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+void test(const char *vector, unsigned char *digest,
+          unsigned int digest_size)
+{
+    char output[2 * SHA512_DIGEST_SIZE + 1];
+    int i;
+
+    output[2 * digest_size] = '\0';
+
+    for (i = 0; i < (int) digest_size ; i++) {
+       sprintf(output + 2*i, "%02x", digest[i]);
+    }
+
+    printf("H: %s\n", output);
+    if (strcmp(vector, output)) {
+        fprintf(stderr, "Test failed.\n");
+        exit(1);
+    }
+}
+
+int main(void)
+{
+    static const char *vectors[] =
+    {
+        /* HMAC-SHA-224 */
+        "896fb1128abbdf196832107cd49df33f47b4b1169912ba4f53684b22",
+        "a30e01098bc6dbbf45690f3a7e9e6d0f8bbea2a39e6148008fd05e44",
+        "7fb3cb3588c6c1f6ffa9694d7d6ad2649365b0c1f65d69d1ec8333ea",
+        "6c11506874013cac6a2abc1bb382627cec6a90d86efc012de7afec5a",
+        "0e2aea68a90c8d37c988bcdb9fca6fa8",
+        "95e9a0db962095adaebe9b2d6f0dbce2d499f112f2d2b7273fa6870e",
+        "3a854166ac5d9f023f54d517d0b39dbd946770db9c2b95c9f6f565d1",
+        /* HMAC-SHA-256 */
+        "b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7",
+        "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843",
+        "773ea91e36800e46854db8ebd09181a72959098b3ef8c122d9635514ced565fe",
+        "82558a389a443c0ea4cc819899f2083a85f0faa3e578f8077a2e3ff46729665b",
+        "a3b6167473100ee06e0c796c2955552b",
+        "60e431591ee0b67f0d8a26aacbf5b77f8e0bc6213728c5140546040f0ee37f54",
+        "9b09ffa71b942fcb27635fbcd5b0e944bfdc63644f0713938a7f51535c3a35e2",
+        /* HMAC-SHA-384 */
+        "afd03944d84895626b0825f4ab46907f15f9dadbe4101ec682aa034c7cebc59c"
+        "faea9ea9076ede7f4af152e8b2fa9cb6",
+        "af45d2e376484031617f78d2b58a6b1b9c7ef464f5a01b47e42ec3736322445e"
+        "8e2240ca5e69e2c78b3239ecfab21649",
+        "88062608d3e6ad8a0aa2ace014c8a86f0aa635d947ac9febe83ef4e55966144b"
+        "2a5ab39dc13814b94e3ab6e101a34f27",
+        "3e8a69b7783c25851933ab6290af6ca77a9981480850009cc5577c6e1f573b4e"
+        "6801dd23c4a7d679ccf8a386c674cffb",
+        "3abf34c3503b2a23a46efc619baef897",
+        "4ece084485813e9088d2c63a041bc5b44f9ef1012a2b588f3cd11f05033ac4c6"
+        "0c2ef6ab4030fe8296248df163f44952",
+        "6617178e941f020d351e2f254e8fd32c602420feb0b8fb9adccebb82461e99c5"
+        "a678cc31e799176d3860e6110c46523e",
+        /* HMAC-SHA-512 */
+        "87aa7cdea5ef619d4ff0b4241a1d6cb02379f4e2ce4ec2787ad0b30545e17cde"
+        "daa833b7d6b8a702038b274eaea3f4e4be9d914eeb61f1702e696c203a126854",
+        "164b7a7bfcf819e2e395fbe73b56e0a387bd64222e831fd610270cd7ea250554"
+        "9758bf75c05a994a6d034f65f8f0e6fdcaeab1a34d4a6b4b636e070a38bce737",
+        "fa73b0089d56a284efb0f0756c890be9b1b5dbdd8ee81a3655f83e33b2279d39"
+        "bf3e848279a722c806b485a47e67c807b946a337bee8942674278859e13292fb",
+        "b0ba465637458c6990e5a8c5f61d4af7e576d97ff94b872de76f8050361ee3db"
+        "a91ca5c11aa25eb4d679275cc5788063a5f19741120c4f2de2adebeb10a298dd",
+        "415fad6271580a531d4179bc891d87a6",
+        "80b24263c7c1a3ebb71493c1dd7be8b49b46d1f41b4aeec1121b013783f8f352"
+        "6b56d037e05f2598bd0fd2215d6a1e5295e64f73f63f0aec8b915a985d786598",
+        "e37b6a775dc87dbaa4dfa9f96e5e3ffddebd71f8867289865df5a32d20cdc944"
+        "b6022cac3c4982b10d5eeb55c3e4de15134676fb6de0446065c97440fa8c6a58"
+    };
+
+    static char *messages[] =
+    {
+        "Hi There",
+        "what do ya want for nothing?",
+        NULL,
+        NULL,
+        "Test With Truncation",
+        "Test Using Larger Than Block-Size Key - Hash Key First",
+        "This is a test using a larger than block-size key "
+        "and a larger than block-size data. The key needs"
+        " to be hashed before being used by the HMAC algorithm."
+    };
+
+    unsigned char mac[SHA512_DIGEST_SIZE];
+    unsigned char *keys[7];
+    unsigned int keys_len[7] = {20, 4, 20, 25, 20, 131, 131};
+    unsigned int messages2and3_len = 50;
+    unsigned int mac_224_size, mac_256_size, mac_384_size, mac_512_size;
+    int i;
+
+    for (i = 0; i < 7; i++) {
+        keys[i] = malloc(keys_len[i]);
+        if (keys[i] == NULL) {
+            fprintf(stderr, "Can't allocate memory\n");
+            return 1;
+        }
+    }
+
+    memset(keys[0], 0x0b, keys_len[0]);
+    strcpy((char *) keys[1], "Jefe");
+    memset(keys[2], 0xaa, keys_len[2]);
+    for (i = 0; i < (int) keys_len[3]; i++)
+        keys[3][i] = (unsigned char) i + 1;
+    memset(keys[4], 0x0c, keys_len[4]);
+    memset(keys[5], 0xaa, keys_len[5]);
+    memset(keys[6], 0xaa, keys_len[6]);
+
+    messages[2] = malloc(messages2and3_len + 1);
+    messages[3] = malloc(messages2and3_len + 1);
+
+    if (messages[2] == NULL || messages[3] == NULL) {
+        fprintf(stderr, "Can't allocate memory\n");
+        return 1;
+    }
+
+    messages[2][messages2and3_len] = '\0';
+    messages[3][messages2and3_len] = '\0';
+
+    memset(messages[2], 0xdd, messages2and3_len);
+    memset(messages[3], 0xcd, messages2and3_len);
+
+    printf("HMAC-SHA-2 IETF Validation tests\n\n");
+
+    for (i = 0; i < 7; i++) {
+        if (i != 4) {
+            mac_224_size = SHA224_DIGEST_SIZE;
+            mac_256_size = SHA256_DIGEST_SIZE;
+            mac_384_size = SHA384_DIGEST_SIZE;
+            mac_512_size = SHA512_DIGEST_SIZE;
+        } else {
+            mac_224_size = 128 / 8; mac_256_size = 128 / 8;
+            mac_384_size = 128 / 8; mac_512_size = 128 / 8;
+        }
+
+        printf("Test %d:\n", i + 1);
+
+        hmac_sha224(keys[i], keys_len[i], (unsigned char *) messages[i],
+                    strlen(messages[i]), mac, mac_224_size);
+        test(vectors[i], mac, mac_224_size);
+        hmac_sha256(keys[i], keys_len[i], (unsigned char *) messages[i],
+                    strlen(messages[i]), mac, mac_256_size);
+        test(vectors[7 + i], mac, mac_256_size);
+        hmac_sha384(keys[i], keys_len[i], (unsigned char *) messages[i],
+                    strlen(messages[i]), mac, mac_384_size);
+        test(vectors[14 + i], mac, mac_384_size);
+        hmac_sha512(keys[i], keys_len[i], (unsigned char *) messages[i],
+                    strlen(messages[i]), mac, mac_512_size);
+        test(vectors[21 + i], mac, mac_512_size);
+    }
+
+    printf("All tests passed.\n");
+
+    return 0;
+}
+
+#endif /* TEST_VECTORS */
+
diff --git a/3rdparty/hmac_sha/hmac_sha2.h b/3rdparty/hmac_sha/hmac_sha2.h
new file mode 100644
index 0000000..64b0202
--- /dev/null
+++ b/3rdparty/hmac_sha/hmac_sha2.h
@@ -0,0 +1,140 @@
+/*
+ * HMAC-SHA-224/256/384/512 implementation
+ * Last update: 06/15/2005
+ * Issue date:  06/15/2005
+ *
+ * Copyright (C) 2005 Olivier Gay <olivier.gay@a3.epfl.ch>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the project nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef HMAC_SHA2_H
+#define HMAC_SHA2_H
+
+#include "sha2.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct {
+    sha224_ctx ctx_inside;
+    sha224_ctx ctx_outside;
+
+    /* for hmac_reinit */
+    sha224_ctx ctx_inside_reinit;
+    sha224_ctx ctx_outside_reinit;
+
+    unsigned char block_ipad[SHA224_BLOCK_SIZE];
+    unsigned char block_opad[SHA224_BLOCK_SIZE];
+} hmac_sha224_ctx;
+
+typedef struct {
+    sha256_ctx ctx_inside;
+    sha256_ctx ctx_outside;
+
+    /* for hmac_reinit */
+    sha256_ctx ctx_inside_reinit;
+    sha256_ctx ctx_outside_reinit;
+
+    unsigned char block_ipad[SHA256_BLOCK_SIZE];
+    unsigned char block_opad[SHA256_BLOCK_SIZE];
+} hmac_sha256_ctx;
+
+typedef struct {
+    sha384_ctx ctx_inside;
+    sha384_ctx ctx_outside;
+
+    /* for hmac_reinit */
+    sha384_ctx ctx_inside_reinit;
+    sha384_ctx ctx_outside_reinit;
+
+    unsigned char block_ipad[SHA384_BLOCK_SIZE];
+    unsigned char block_opad[SHA384_BLOCK_SIZE];
+} hmac_sha384_ctx;
+
+typedef struct {
+    sha512_ctx ctx_inside;
+    sha512_ctx ctx_outside;
+
+    /* for hmac_reinit */
+    sha512_ctx ctx_inside_reinit;
+    sha512_ctx ctx_outside_reinit;
+
+    unsigned char block_ipad[SHA512_BLOCK_SIZE];
+    unsigned char block_opad[SHA512_BLOCK_SIZE];
+} hmac_sha512_ctx;
+
+void hmac_sha224_init(hmac_sha224_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size);
+void hmac_sha224_reinit(hmac_sha224_ctx *ctx);
+void hmac_sha224_update(hmac_sha224_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len);
+void hmac_sha224_final(hmac_sha224_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size);
+void hmac_sha224(const unsigned char *key, unsigned int key_size,
+                 const unsigned char *message, unsigned int message_len,
+                 unsigned char *mac, unsigned mac_size);
+
+void hmac_sha256_init(hmac_sha256_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size);
+void hmac_sha256_reinit(hmac_sha256_ctx *ctx);
+void hmac_sha256_update(hmac_sha256_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len);
+void hmac_sha256_final(hmac_sha256_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size);
+void hmac_sha256(const unsigned char *key, unsigned int key_size,
+                 const unsigned char *message, unsigned int message_len,
+                 unsigned char *mac, unsigned mac_size);
+
+void hmac_sha384_init(hmac_sha384_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size);
+void hmac_sha384_reinit(hmac_sha384_ctx *ctx);
+void hmac_sha384_update(hmac_sha384_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len);
+void hmac_sha384_final(hmac_sha384_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size);
+void hmac_sha384(const unsigned char *key, unsigned int key_size,
+                 const unsigned char *message, unsigned int message_len,
+                 unsigned char *mac, unsigned mac_size);
+
+void hmac_sha512_init(hmac_sha512_ctx *ctx, const unsigned char *key,
+                      unsigned int key_size);
+void hmac_sha512_reinit(hmac_sha512_ctx *ctx);
+void hmac_sha512_update(hmac_sha512_ctx *ctx, const unsigned char *message,
+                        unsigned int message_len);
+void hmac_sha512_final(hmac_sha512_ctx *ctx, unsigned char *mac,
+                       unsigned int mac_size);
+void hmac_sha512(const unsigned char *key, unsigned int key_size,
+                 const unsigned char *message, unsigned int message_len,
+                 unsigned char *mac, unsigned mac_size);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* !HMAC_SHA2_H */
+
diff --git a/3rdparty/hmac_sha/sha2.c b/3rdparty/hmac_sha/sha2.c
new file mode 100644
index 0000000..0fe4c37
--- /dev/null
+++ b/3rdparty/hmac_sha/sha2.c
@@ -0,0 +1,949 @@
+/*
+ * FIPS 180-2 SHA-224/256/384/512 implementation
+ * Last update: 02/02/2007
+ * Issue date:  04/30/2005
+ *
+ * Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the project nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#if 0
+#define UNROLL_LOOPS /* Enable loops unrolling */
+#endif
+
+#include <string.h>
+
+#include "sha2.h"
+
+#define SHFR(x, n)    (x >> n)
+#define ROTR(x, n)   ((x >> n) | (x << ((sizeof(x) << 3) - n)))
+#define ROTL(x, n)   ((x << n) | (x >> ((sizeof(x) << 3) - n)))
+#define CH(x, y, z)  ((x & y) ^ (~x & z))
+#define MAJ(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
+
+#define SHA256_F1(x) (ROTR(x,  2) ^ ROTR(x, 13) ^ ROTR(x, 22))
+#define SHA256_F2(x) (ROTR(x,  6) ^ ROTR(x, 11) ^ ROTR(x, 25))
+#define SHA256_F3(x) (ROTR(x,  7) ^ ROTR(x, 18) ^ SHFR(x,  3))
+#define SHA256_F4(x) (ROTR(x, 17) ^ ROTR(x, 19) ^ SHFR(x, 10))
+
+#define SHA512_F1(x) (ROTR(x, 28) ^ ROTR(x, 34) ^ ROTR(x, 39))
+#define SHA512_F2(x) (ROTR(x, 14) ^ ROTR(x, 18) ^ ROTR(x, 41))
+#define SHA512_F3(x) (ROTR(x,  1) ^ ROTR(x,  8) ^ SHFR(x,  7))
+#define SHA512_F4(x) (ROTR(x, 19) ^ ROTR(x, 61) ^ SHFR(x,  6))
+
+#define UNPACK32(x, str)                      \
+{                                             \
+    *((str) + 3) = (uint8) ((x)      );       \
+    *((str) + 2) = (uint8) ((x) >>  8);       \
+    *((str) + 1) = (uint8) ((x) >> 16);       \
+    *((str) + 0) = (uint8) ((x) >> 24);       \
+}
+
+#define PACK32(str, x)                        \
+{                                             \
+    *(x) =   ((uint32) *((str) + 3)      )    \
+           | ((uint32) *((str) + 2) <<  8)    \
+           | ((uint32) *((str) + 1) << 16)    \
+           | ((uint32) *((str) + 0) << 24);   \
+}
+
+#define UNPACK64(x, str)                      \
+{                                             \
+    *((str) + 7) = (uint8) ((x)      );       \
+    *((str) + 6) = (uint8) ((x) >>  8);       \
+    *((str) + 5) = (uint8) ((x) >> 16);       \
+    *((str) + 4) = (uint8) ((x) >> 24);       \
+    *((str) + 3) = (uint8) ((x) >> 32);       \
+    *((str) + 2) = (uint8) ((x) >> 40);       \
+    *((str) + 1) = (uint8) ((x) >> 48);       \
+    *((str) + 0) = (uint8) ((x) >> 56);       \
+}
+
+#define PACK64(str, x)                        \
+{                                             \
+    *(x) =   ((uint64) *((str) + 7)      )    \
+           | ((uint64) *((str) + 6) <<  8)    \
+           | ((uint64) *((str) + 5) << 16)    \
+           | ((uint64) *((str) + 4) << 24)    \
+           | ((uint64) *((str) + 3) << 32)    \
+           | ((uint64) *((str) + 2) << 40)    \
+           | ((uint64) *((str) + 1) << 48)    \
+           | ((uint64) *((str) + 0) << 56);   \
+}
+
+/* Macros used for loops unrolling */
+
+#define SHA256_SCR(i)                         \
+{                                             \
+    w[i] =  SHA256_F4(w[i -  2]) + w[i -  7]  \
+          + SHA256_F3(w[i - 15]) + w[i - 16]; \
+}
+
+#define SHA512_SCR(i)                         \
+{                                             \
+    w[i] =  SHA512_F4(w[i -  2]) + w[i -  7]  \
+          + SHA512_F3(w[i - 15]) + w[i - 16]; \
+}
+
+#define SHA256_EXP(a, b, c, d, e, f, g, h, j)               \
+{                                                           \
+    t1 = wv[h] + SHA256_F2(wv[e]) + CH(wv[e], wv[f], wv[g]) \
+         + sha256_k[j] + w[j];                              \
+    t2 = SHA256_F1(wv[a]) + MAJ(wv[a], wv[b], wv[c]);       \
+    wv[d] += t1;                                            \
+    wv[h] = t1 + t2;                                        \
+}
+
+#define SHA512_EXP(a, b, c, d, e, f, g ,h, j)               \
+{                                                           \
+    t1 = wv[h] + SHA512_F2(wv[e]) + CH(wv[e], wv[f], wv[g]) \
+         + sha512_k[j] + w[j];                              \
+    t2 = SHA512_F1(wv[a]) + MAJ(wv[a], wv[b], wv[c]);       \
+    wv[d] += t1;                                            \
+    wv[h] = t1 + t2;                                        \
+}
+
+uint32 sha224_h0[8] =
+            {0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
+             0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4};
+
+uint32 sha256_h0[8] =
+            {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
+             0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
+
+uint64 sha384_h0[8] =
+            {0xcbbb9d5dc1059ed8ULL, 0x629a292a367cd507ULL,
+             0x9159015a3070dd17ULL, 0x152fecd8f70e5939ULL,
+             0x67332667ffc00b31ULL, 0x8eb44a8768581511ULL,
+             0xdb0c2e0d64f98fa7ULL, 0x47b5481dbefa4fa4ULL};
+
+uint64 sha512_h0[8] =
+            {0x6a09e667f3bcc908ULL, 0xbb67ae8584caa73bULL,
+             0x3c6ef372fe94f82bULL, 0xa54ff53a5f1d36f1ULL,
+             0x510e527fade682d1ULL, 0x9b05688c2b3e6c1fULL,
+             0x1f83d9abfb41bd6bULL, 0x5be0cd19137e2179ULL};
+
+uint32 sha256_k[64] =
+            {0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
+             0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
+             0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
+             0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
+             0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
+             0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
+             0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
+             0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
+             0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
+             0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
+             0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
+             0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
+             0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
+             0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
+             0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
+             0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
+
+uint64 sha512_k[80] =
+            {0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL,
+             0xb5c0fbcfec4d3b2fULL, 0xe9b5dba58189dbbcULL,
+             0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+             0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL,
+             0xd807aa98a3030242ULL, 0x12835b0145706fbeULL,
+             0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+             0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL,
+             0x9bdc06a725c71235ULL, 0xc19bf174cf692694ULL,
+             0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+             0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL,
+             0x2de92c6f592b0275ULL, 0x4a7484aa6ea6e483ULL,
+             0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+             0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL,
+             0xb00327c898fb213fULL, 0xbf597fc7beef0ee4ULL,
+             0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+             0x06ca6351e003826fULL, 0x142929670a0e6e70ULL,
+             0x27b70a8546d22ffcULL, 0x2e1b21385c26c926ULL,
+             0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+             0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL,
+             0x81c2c92e47edaee6ULL, 0x92722c851482353bULL,
+             0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+             0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL,
+             0xd192e819d6ef5218ULL, 0xd69906245565a910ULL,
+             0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+             0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL,
+             0x2748774cdf8eeb99ULL, 0x34b0bcb5e19b48a8ULL,
+             0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+             0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL,
+             0x748f82ee5defb2fcULL, 0x78a5636f43172f60ULL,
+             0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+             0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL,
+             0xbef9a3f7b2c67915ULL, 0xc67178f2e372532bULL,
+             0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+             0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL,
+             0x06f067aa72176fbaULL, 0x0a637dc5a2c898a6ULL,
+             0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+             0x28db77f523047d84ULL, 0x32caab7b40c72493ULL,
+             0x3c9ebe0a15c9bebcULL, 0x431d67c49c100d4cULL,
+             0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+             0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL};
+
+/* SHA-256 functions */
+
+void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
+                   unsigned int block_nb)
+{
+    uint32 w[64];
+    uint32 wv[8];
+    uint32 t1, t2;
+    const unsigned char *sub_block;
+    int i;
+
+#ifndef UNROLL_LOOPS
+    int j;
+#endif
+
+    for (i = 0; i < (int) block_nb; i++) {
+        sub_block = message + (i << 6);
+
+#ifndef UNROLL_LOOPS
+        for (j = 0; j < 16; j++) {
+            PACK32(&sub_block[j << 2], &w[j]);
+        }
+
+        for (j = 16; j < 64; j++) {
+            SHA256_SCR(j);
+        }
+
+        for (j = 0; j < 8; j++) {
+            wv[j] = ctx->h[j];
+        }
+
+        for (j = 0; j < 64; j++) {
+            t1 = wv[7] + SHA256_F2(wv[4]) + CH(wv[4], wv[5], wv[6])
+                + sha256_k[j] + w[j];
+            t2 = SHA256_F1(wv[0]) + MAJ(wv[0], wv[1], wv[2]);
+            wv[7] = wv[6];
+            wv[6] = wv[5];
+            wv[5] = wv[4];
+            wv[4] = wv[3] + t1;
+            wv[3] = wv[2];
+            wv[2] = wv[1];
+            wv[1] = wv[0];
+            wv[0] = t1 + t2;
+        }
+
+        for (j = 0; j < 8; j++) {
+            ctx->h[j] += wv[j];
+        }
+#else
+        PACK32(&sub_block[ 0], &w[ 0]); PACK32(&sub_block[ 4], &w[ 1]);
+        PACK32(&sub_block[ 8], &w[ 2]); PACK32(&sub_block[12], &w[ 3]);
+        PACK32(&sub_block[16], &w[ 4]); PACK32(&sub_block[20], &w[ 5]);
+        PACK32(&sub_block[24], &w[ 6]); PACK32(&sub_block[28], &w[ 7]);
+        PACK32(&sub_block[32], &w[ 8]); PACK32(&sub_block[36], &w[ 9]);
+        PACK32(&sub_block[40], &w[10]); PACK32(&sub_block[44], &w[11]);
+        PACK32(&sub_block[48], &w[12]); PACK32(&sub_block[52], &w[13]);
+        PACK32(&sub_block[56], &w[14]); PACK32(&sub_block[60], &w[15]);
+
+        SHA256_SCR(16); SHA256_SCR(17); SHA256_SCR(18); SHA256_SCR(19);
+        SHA256_SCR(20); SHA256_SCR(21); SHA256_SCR(22); SHA256_SCR(23);
+        SHA256_SCR(24); SHA256_SCR(25); SHA256_SCR(26); SHA256_SCR(27);
+        SHA256_SCR(28); SHA256_SCR(29); SHA256_SCR(30); SHA256_SCR(31);
+        SHA256_SCR(32); SHA256_SCR(33); SHA256_SCR(34); SHA256_SCR(35);
+        SHA256_SCR(36); SHA256_SCR(37); SHA256_SCR(38); SHA256_SCR(39);
+        SHA256_SCR(40); SHA256_SCR(41); SHA256_SCR(42); SHA256_SCR(43);
+        SHA256_SCR(44); SHA256_SCR(45); SHA256_SCR(46); SHA256_SCR(47);
+        SHA256_SCR(48); SHA256_SCR(49); SHA256_SCR(50); SHA256_SCR(51);
+        SHA256_SCR(52); SHA256_SCR(53); SHA256_SCR(54); SHA256_SCR(55);
+        SHA256_SCR(56); SHA256_SCR(57); SHA256_SCR(58); SHA256_SCR(59);
+        SHA256_SCR(60); SHA256_SCR(61); SHA256_SCR(62); SHA256_SCR(63);
+
+        wv[0] = ctx->h[0]; wv[1] = ctx->h[1];
+        wv[2] = ctx->h[2]; wv[3] = ctx->h[3];
+        wv[4] = ctx->h[4]; wv[5] = ctx->h[5];
+        wv[6] = ctx->h[6]; wv[7] = ctx->h[7];
+
+        SHA256_EXP(0,1,2,3,4,5,6,7, 0); SHA256_EXP(7,0,1,2,3,4,5,6, 1);
+        SHA256_EXP(6,7,0,1,2,3,4,5, 2); SHA256_EXP(5,6,7,0,1,2,3,4, 3);
+        SHA256_EXP(4,5,6,7,0,1,2,3, 4); SHA256_EXP(3,4,5,6,7,0,1,2, 5);
+        SHA256_EXP(2,3,4,5,6,7,0,1, 6); SHA256_EXP(1,2,3,4,5,6,7,0, 7);
+        SHA256_EXP(0,1,2,3,4,5,6,7, 8); SHA256_EXP(7,0,1,2,3,4,5,6, 9);
+        SHA256_EXP(6,7,0,1,2,3,4,5,10); SHA256_EXP(5,6,7,0,1,2,3,4,11);
+        SHA256_EXP(4,5,6,7,0,1,2,3,12); SHA256_EXP(3,4,5,6,7,0,1,2,13);
+        SHA256_EXP(2,3,4,5,6,7,0,1,14); SHA256_EXP(1,2,3,4,5,6,7,0,15);
+        SHA256_EXP(0,1,2,3,4,5,6,7,16); SHA256_EXP(7,0,1,2,3,4,5,6,17);
+        SHA256_EXP(6,7,0,1,2,3,4,5,18); SHA256_EXP(5,6,7,0,1,2,3,4,19);
+        SHA256_EXP(4,5,6,7,0,1,2,3,20); SHA256_EXP(3,4,5,6,7,0,1,2,21);
+        SHA256_EXP(2,3,4,5,6,7,0,1,22); SHA256_EXP(1,2,3,4,5,6,7,0,23);
+        SHA256_EXP(0,1,2,3,4,5,6,7,24); SHA256_EXP(7,0,1,2,3,4,5,6,25);
+        SHA256_EXP(6,7,0,1,2,3,4,5,26); SHA256_EXP(5,6,7,0,1,2,3,4,27);
+        SHA256_EXP(4,5,6,7,0,1,2,3,28); SHA256_EXP(3,4,5,6,7,0,1,2,29);
+        SHA256_EXP(2,3,4,5,6,7,0,1,30); SHA256_EXP(1,2,3,4,5,6,7,0,31);
+        SHA256_EXP(0,1,2,3,4,5,6,7,32); SHA256_EXP(7,0,1,2,3,4,5,6,33);
+        SHA256_EXP(6,7,0,1,2,3,4,5,34); SHA256_EXP(5,6,7,0,1,2,3,4,35);
+        SHA256_EXP(4,5,6,7,0,1,2,3,36); SHA256_EXP(3,4,5,6,7,0,1,2,37);
+        SHA256_EXP(2,3,4,5,6,7,0,1,38); SHA256_EXP(1,2,3,4,5,6,7,0,39);
+        SHA256_EXP(0,1,2,3,4,5,6,7,40); SHA256_EXP(7,0,1,2,3,4,5,6,41);
+        SHA256_EXP(6,7,0,1,2,3,4,5,42); SHA256_EXP(5,6,7,0,1,2,3,4,43);
+        SHA256_EXP(4,5,6,7,0,1,2,3,44); SHA256_EXP(3,4,5,6,7,0,1,2,45);
+        SHA256_EXP(2,3,4,5,6,7,0,1,46); SHA256_EXP(1,2,3,4,5,6,7,0,47);
+        SHA256_EXP(0,1,2,3,4,5,6,7,48); SHA256_EXP(7,0,1,2,3,4,5,6,49);
+        SHA256_EXP(6,7,0,1,2,3,4,5,50); SHA256_EXP(5,6,7,0,1,2,3,4,51);
+        SHA256_EXP(4,5,6,7,0,1,2,3,52); SHA256_EXP(3,4,5,6,7,0,1,2,53);
+        SHA256_EXP(2,3,4,5,6,7,0,1,54); SHA256_EXP(1,2,3,4,5,6,7,0,55);
+        SHA256_EXP(0,1,2,3,4,5,6,7,56); SHA256_EXP(7,0,1,2,3,4,5,6,57);
+        SHA256_EXP(6,7,0,1,2,3,4,5,58); SHA256_EXP(5,6,7,0,1,2,3,4,59);
+        SHA256_EXP(4,5,6,7,0,1,2,3,60); SHA256_EXP(3,4,5,6,7,0,1,2,61);
+        SHA256_EXP(2,3,4,5,6,7,0,1,62); SHA256_EXP(1,2,3,4,5,6,7,0,63);
+
+        ctx->h[0] += wv[0]; ctx->h[1] += wv[1];
+        ctx->h[2] += wv[2]; ctx->h[3] += wv[3];
+        ctx->h[4] += wv[4]; ctx->h[5] += wv[5];
+        ctx->h[6] += wv[6]; ctx->h[7] += wv[7];
+#endif /* !UNROLL_LOOPS */
+    }
+}
+
+void sha256(const unsigned char *message, unsigned int len, unsigned char *digest)
+{
+    sha256_ctx ctx;
+
+    sha256_init(&ctx);
+    sha256_update(&ctx, message, len);
+    sha256_final(&ctx, digest);
+}
+
+void sha256_init(sha256_ctx *ctx)
+{
+#ifndef UNROLL_LOOPS
+    int i;
+    for (i = 0; i < 8; i++) {
+        ctx->h[i] = sha256_h0[i];
+    }
+#else
+    ctx->h[0] = sha256_h0[0]; ctx->h[1] = sha256_h0[1];
+    ctx->h[2] = sha256_h0[2]; ctx->h[3] = sha256_h0[3];
+    ctx->h[4] = sha256_h0[4]; ctx->h[5] = sha256_h0[5];
+    ctx->h[6] = sha256_h0[6]; ctx->h[7] = sha256_h0[7];
+#endif /* !UNROLL_LOOPS */
+
+    ctx->len = 0;
+    ctx->tot_len = 0;
+}
+
+void sha256_update(sha256_ctx *ctx, const unsigned char *message,
+                   unsigned int len)
+{
+    unsigned int block_nb;
+    unsigned int new_len, rem_len, tmp_len;
+    const unsigned char *shifted_message;
+
+    tmp_len = SHA256_BLOCK_SIZE - ctx->len;
+    rem_len = len < tmp_len ? len : tmp_len;
+
+    memcpy(&ctx->block[ctx->len], message, rem_len);
+
+    if (ctx->len + len < SHA256_BLOCK_SIZE) {
+        ctx->len += len;
+        return;
+    }
+
+    new_len = len - rem_len;
+    block_nb = new_len / SHA256_BLOCK_SIZE;
+
+    shifted_message = message + rem_len;
+
+    sha256_transf(ctx, ctx->block, 1);
+    sha256_transf(ctx, shifted_message, block_nb);
+
+    rem_len = new_len % SHA256_BLOCK_SIZE;
+
+    memcpy(ctx->block, &shifted_message[block_nb << 6],
+           rem_len);
+
+    ctx->len = rem_len;
+    ctx->tot_len += (block_nb + 1) << 6;
+}
+
+void sha256_final(sha256_ctx *ctx, unsigned char *digest)
+{
+    unsigned int block_nb;
+    unsigned int pm_len;
+    unsigned int len_b;
+
+#ifndef UNROLL_LOOPS
+    int i;
+#endif
+
+    block_nb = (1 + ((SHA256_BLOCK_SIZE - 9)
+                     < (ctx->len % SHA256_BLOCK_SIZE)));
+
+    len_b = (ctx->tot_len + ctx->len) << 3;
+    pm_len = block_nb << 6;
+
+    memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
+    ctx->block[ctx->len] = 0x80;
+    UNPACK32(len_b, ctx->block + pm_len - 4);
+
+    sha256_transf(ctx, ctx->block, block_nb);
+
+#ifndef UNROLL_LOOPS
+    for (i = 0 ; i < 8; i++) {
+        UNPACK32(ctx->h[i], &digest[i << 2]);
+    }
+#else
+   UNPACK32(ctx->h[0], &digest[ 0]);
+   UNPACK32(ctx->h[1], &digest[ 4]);
+   UNPACK32(ctx->h[2], &digest[ 8]);
+   UNPACK32(ctx->h[3], &digest[12]);
+   UNPACK32(ctx->h[4], &digest[16]);
+   UNPACK32(ctx->h[5], &digest[20]);
+   UNPACK32(ctx->h[6], &digest[24]);
+   UNPACK32(ctx->h[7], &digest[28]);
+#endif /* !UNROLL_LOOPS */
+}
+
+/* SHA-512 functions */
+
+void sha512_transf(sha512_ctx *ctx, const unsigned char *message,
+                   unsigned int block_nb)
+{
+    uint64 w[80];
+    uint64 wv[8];
+    uint64 t1, t2;
+    const unsigned char *sub_block;
+    int i, j;
+
+    for (i = 0; i < (int) block_nb; i++) {
+        sub_block = message + (i << 7);
+
+#ifndef UNROLL_LOOPS
+        for (j = 0; j < 16; j++) {
+            PACK64(&sub_block[j << 3], &w[j]);
+        }
+
+        for (j = 16; j < 80; j++) {
+            SHA512_SCR(j);
+        }
+
+        for (j = 0; j < 8; j++) {
+            wv[j] = ctx->h[j];
+        }
+
+        for (j = 0; j < 80; j++) {
+            t1 = wv[7] + SHA512_F2(wv[4]) + CH(wv[4], wv[5], wv[6])
+                + sha512_k[j] + w[j];
+            t2 = SHA512_F1(wv[0]) + MAJ(wv[0], wv[1], wv[2]);
+            wv[7] = wv[6];
+            wv[6] = wv[5];
+            wv[5] = wv[4];
+            wv[4] = wv[3] + t1;
+            wv[3] = wv[2];
+            wv[2] = wv[1];
+            wv[1] = wv[0];
+            wv[0] = t1 + t2;
+        }
+
+        for (j = 0; j < 8; j++) {
+            ctx->h[j] += wv[j];
+        }
+#else
+        PACK64(&sub_block[  0], &w[ 0]); PACK64(&sub_block[  8], &w[ 1]);
+        PACK64(&sub_block[ 16], &w[ 2]); PACK64(&sub_block[ 24], &w[ 3]);
+        PACK64(&sub_block[ 32], &w[ 4]); PACK64(&sub_block[ 40], &w[ 5]);
+        PACK64(&sub_block[ 48], &w[ 6]); PACK64(&sub_block[ 56], &w[ 7]);
+        PACK64(&sub_block[ 64], &w[ 8]); PACK64(&sub_block[ 72], &w[ 9]);
+        PACK64(&sub_block[ 80], &w[10]); PACK64(&sub_block[ 88], &w[11]);
+        PACK64(&sub_block[ 96], &w[12]); PACK64(&sub_block[104], &w[13]);
+        PACK64(&sub_block[112], &w[14]); PACK64(&sub_block[120], &w[15]);
+
+        SHA512_SCR(16); SHA512_SCR(17); SHA512_SCR(18); SHA512_SCR(19);
+        SHA512_SCR(20); SHA512_SCR(21); SHA512_SCR(22); SHA512_SCR(23);
+        SHA512_SCR(24); SHA512_SCR(25); SHA512_SCR(26); SHA512_SCR(27);
+        SHA512_SCR(28); SHA512_SCR(29); SHA512_SCR(30); SHA512_SCR(31);
+        SHA512_SCR(32); SHA512_SCR(33); SHA512_SCR(34); SHA512_SCR(35);
+        SHA512_SCR(36); SHA512_SCR(37); SHA512_SCR(38); SHA512_SCR(39);
+        SHA512_SCR(40); SHA512_SCR(41); SHA512_SCR(42); SHA512_SCR(43);
+        SHA512_SCR(44); SHA512_SCR(45); SHA512_SCR(46); SHA512_SCR(47);
+        SHA512_SCR(48); SHA512_SCR(49); SHA512_SCR(50); SHA512_SCR(51);
+        SHA512_SCR(52); SHA512_SCR(53); SHA512_SCR(54); SHA512_SCR(55);
+        SHA512_SCR(56); SHA512_SCR(57); SHA512_SCR(58); SHA512_SCR(59);
+        SHA512_SCR(60); SHA512_SCR(61); SHA512_SCR(62); SHA512_SCR(63);
+        SHA512_SCR(64); SHA512_SCR(65); SHA512_SCR(66); SHA512_SCR(67);
+        SHA512_SCR(68); SHA512_SCR(69); SHA512_SCR(70); SHA512_SCR(71);
+        SHA512_SCR(72); SHA512_SCR(73); SHA512_SCR(74); SHA512_SCR(75);
+        SHA512_SCR(76); SHA512_SCR(77); SHA512_SCR(78); SHA512_SCR(79);
+
+        wv[0] = ctx->h[0]; wv[1] = ctx->h[1];
+        wv[2] = ctx->h[2]; wv[3] = ctx->h[3];
+        wv[4] = ctx->h[4]; wv[5] = ctx->h[5];
+        wv[6] = ctx->h[6]; wv[7] = ctx->h[7];
+
+        j = 0;
+
+        do {
+            SHA512_EXP(0,1,2,3,4,5,6,7,j); j++;
+            SHA512_EXP(7,0,1,2,3,4,5,6,j); j++;
+            SHA512_EXP(6,7,0,1,2,3,4,5,j); j++;
+            SHA512_EXP(5,6,7,0,1,2,3,4,j); j++;
+            SHA512_EXP(4,5,6,7,0,1,2,3,j); j++;
+            SHA512_EXP(3,4,5,6,7,0,1,2,j); j++;
+            SHA512_EXP(2,3,4,5,6,7,0,1,j); j++;
+            SHA512_EXP(1,2,3,4,5,6,7,0,j); j++;
+        } while (j < 80);
+
+        ctx->h[0] += wv[0]; ctx->h[1] += wv[1];
+        ctx->h[2] += wv[2]; ctx->h[3] += wv[3];
+        ctx->h[4] += wv[4]; ctx->h[5] += wv[5];
+        ctx->h[6] += wv[6]; ctx->h[7] += wv[7];
+#endif /* !UNROLL_LOOPS */
+    }
+}
+
+void sha512(const unsigned char *message, unsigned int len,
+            unsigned char *digest)
+{
+    sha512_ctx ctx;
+
+    sha512_init(&ctx);
+    sha512_update(&ctx, message, len);
+    sha512_final(&ctx, digest);
+}
+
+void sha512_init(sha512_ctx *ctx)
+{
+#ifndef UNROLL_LOOPS
+    int i;
+    for (i = 0; i < 8; i++) {
+        ctx->h[i] = sha512_h0[i];
+    }
+#else
+    ctx->h[0] = sha512_h0[0]; ctx->h[1] = sha512_h0[1];
+    ctx->h[2] = sha512_h0[2]; ctx->h[3] = sha512_h0[3];
+    ctx->h[4] = sha512_h0[4]; ctx->h[5] = sha512_h0[5];
+    ctx->h[6] = sha512_h0[6]; ctx->h[7] = sha512_h0[7];
+#endif /* !UNROLL_LOOPS */
+
+    ctx->len = 0;
+    ctx->tot_len = 0;
+}
+
+void sha512_update(sha512_ctx *ctx, const unsigned char *message,
+                   unsigned int len)
+{
+    unsigned int block_nb;
+    unsigned int new_len, rem_len, tmp_len;
+    const unsigned char *shifted_message;
+
+    tmp_len = SHA512_BLOCK_SIZE - ctx->len;
+    rem_len = len < tmp_len ? len : tmp_len;
+
+    memcpy(&ctx->block[ctx->len], message, rem_len);
+
+    if (ctx->len + len < SHA512_BLOCK_SIZE) {
+        ctx->len += len;
+        return;
+    }
+
+    new_len = len - rem_len;
+    block_nb = new_len / SHA512_BLOCK_SIZE;
+
+    shifted_message = message + rem_len;
+
+    sha512_transf(ctx, ctx->block, 1);
+    sha512_transf(ctx, shifted_message, block_nb);
+
+    rem_len = new_len % SHA512_BLOCK_SIZE;
+
+    memcpy(ctx->block, &shifted_message[block_nb << 7],
+           rem_len);
+
+    ctx->len = rem_len;
+    ctx->tot_len += (block_nb + 1) << 7;
+}
+
+void sha512_final(sha512_ctx *ctx, unsigned char *digest)
+{
+    unsigned int block_nb;
+    unsigned int pm_len;
+    unsigned int len_b;
+
+#ifndef UNROLL_LOOPS
+    int i;
+#endif
+
+    block_nb = 1 + ((SHA512_BLOCK_SIZE - 17)
+                     < (ctx->len % SHA512_BLOCK_SIZE));
+
+    len_b = (ctx->tot_len + ctx->len) << 3;
+    pm_len = block_nb << 7;
+
+    memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
+    ctx->block[ctx->len] = 0x80;
+    UNPACK32(len_b, ctx->block + pm_len - 4);
+
+    sha512_transf(ctx, ctx->block, block_nb);
+
+#ifndef UNROLL_LOOPS
+    for (i = 0 ; i < 8; i++) {
+        UNPACK64(ctx->h[i], &digest[i << 3]);
+    }
+#else
+    UNPACK64(ctx->h[0], &digest[ 0]);
+    UNPACK64(ctx->h[1], &digest[ 8]);
+    UNPACK64(ctx->h[2], &digest[16]);
+    UNPACK64(ctx->h[3], &digest[24]);
+    UNPACK64(ctx->h[4], &digest[32]);
+    UNPACK64(ctx->h[5], &digest[40]);
+    UNPACK64(ctx->h[6], &digest[48]);
+    UNPACK64(ctx->h[7], &digest[56]);
+#endif /* !UNROLL_LOOPS */
+}
+
+/* SHA-384 functions */
+
+void sha384(const unsigned char *message, unsigned int len,
+            unsigned char *digest)
+{
+    sha384_ctx ctx;
+
+    sha384_init(&ctx);
+    sha384_update(&ctx, message, len);
+    sha384_final(&ctx, digest);
+}
+
+void sha384_init(sha384_ctx *ctx)
+{
+#ifndef UNROLL_LOOPS
+    int i;
+    for (i = 0; i < 8; i++) {
+        ctx->h[i] = sha384_h0[i];
+    }
+#else
+    ctx->h[0] = sha384_h0[0]; ctx->h[1] = sha384_h0[1];
+    ctx->h[2] = sha384_h0[2]; ctx->h[3] = sha384_h0[3];
+    ctx->h[4] = sha384_h0[4]; ctx->h[5] = sha384_h0[5];
+    ctx->h[6] = sha384_h0[6]; ctx->h[7] = sha384_h0[7];
+#endif /* !UNROLL_LOOPS */
+
+    ctx->len = 0;
+    ctx->tot_len = 0;
+}
+
+void sha384_update(sha384_ctx *ctx, const unsigned char *message,
+                   unsigned int len)
+{
+    unsigned int block_nb;
+    unsigned int new_len, rem_len, tmp_len;
+    const unsigned char *shifted_message;
+
+    tmp_len = SHA384_BLOCK_SIZE - ctx->len;
+    rem_len = len < tmp_len ? len : tmp_len;
+
+    memcpy(&ctx->block[ctx->len], message, rem_len);
+
+    if (ctx->len + len < SHA384_BLOCK_SIZE) {
+        ctx->len += len;
+        return;
+    }
+
+    new_len = len - rem_len;
+    block_nb = new_len / SHA384_BLOCK_SIZE;
+
+    shifted_message = message + rem_len;
+
+    sha512_transf(ctx, ctx->block, 1);
+    sha512_transf(ctx, shifted_message, block_nb);
+
+    rem_len = new_len % SHA384_BLOCK_SIZE;
+
+    memcpy(ctx->block, &shifted_message[block_nb << 7],
+           rem_len);
+
+    ctx->len = rem_len;
+    ctx->tot_len += (block_nb + 1) << 7;
+}
+
+void sha384_final(sha384_ctx *ctx, unsigned char *digest)
+{
+    unsigned int block_nb;
+    unsigned int pm_len;
+    unsigned int len_b;
+
+#ifndef UNROLL_LOOPS
+    int i;
+#endif
+
+    block_nb = (1 + ((SHA384_BLOCK_SIZE - 17)
+                     < (ctx->len % SHA384_BLOCK_SIZE)));
+
+    len_b = (ctx->tot_len + ctx->len) << 3;
+    pm_len = block_nb << 7;
+
+    memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
+    ctx->block[ctx->len] = 0x80;
+    UNPACK32(len_b, ctx->block + pm_len - 4);
+
+    sha512_transf(ctx, ctx->block, block_nb);
+
+#ifndef UNROLL_LOOPS
+    for (i = 0 ; i < 6; i++) {
+        UNPACK64(ctx->h[i], &digest[i << 3]);
+    }
+#else
+    UNPACK64(ctx->h[0], &digest[ 0]);
+    UNPACK64(ctx->h[1], &digest[ 8]);
+    UNPACK64(ctx->h[2], &digest[16]);
+    UNPACK64(ctx->h[3], &digest[24]);
+    UNPACK64(ctx->h[4], &digest[32]);
+    UNPACK64(ctx->h[5], &digest[40]);
+#endif /* !UNROLL_LOOPS */
+}
+
+/* SHA-224 functions */
+
+void sha224(const unsigned char *message, unsigned int len,
+            unsigned char *digest)
+{
+    sha224_ctx ctx;
+
+    sha224_init(&ctx);
+    sha224_update(&ctx, message, len);
+    sha224_final(&ctx, digest);
+}
+
+void sha224_init(sha224_ctx *ctx)
+{
+#ifndef UNROLL_LOOPS
+    int i;
+    for (i = 0; i < 8; i++) {
+        ctx->h[i] = sha224_h0[i];
+    }
+#else
+    ctx->h[0] = sha224_h0[0]; ctx->h[1] = sha224_h0[1];
+    ctx->h[2] = sha224_h0[2]; ctx->h[3] = sha224_h0[3];
+    ctx->h[4] = sha224_h0[4]; ctx->h[5] = sha224_h0[5];
+    ctx->h[6] = sha224_h0[6]; ctx->h[7] = sha224_h0[7];
+#endif /* !UNROLL_LOOPS */
+
+    ctx->len = 0;
+    ctx->tot_len = 0;
+}
+
+void sha224_update(sha224_ctx *ctx, const unsigned char *message,
+                   unsigned int len)
+{
+    unsigned int block_nb;
+    unsigned int new_len, rem_len, tmp_len;
+    const unsigned char *shifted_message;
+
+    tmp_len = SHA224_BLOCK_SIZE - ctx->len;
+    rem_len = len < tmp_len ? len : tmp_len;
+
+    memcpy(&ctx->block[ctx->len], message, rem_len);
+
+    if (ctx->len + len < SHA224_BLOCK_SIZE) {
+        ctx->len += len;
+        return;
+    }
+
+    new_len = len - rem_len;
+    block_nb = new_len / SHA224_BLOCK_SIZE;
+
+    shifted_message = message + rem_len;
+
+    sha256_transf(ctx, ctx->block, 1);
+    sha256_transf(ctx, shifted_message, block_nb);
+
+    rem_len = new_len % SHA224_BLOCK_SIZE;
+
+    memcpy(ctx->block, &shifted_message[block_nb << 6],
+           rem_len);
+
+    ctx->len = rem_len;
+    ctx->tot_len += (block_nb + 1) << 6;
+}
+
+void sha224_final(sha224_ctx *ctx, unsigned char *digest)
+{
+    unsigned int block_nb;
+    unsigned int pm_len;
+    unsigned int len_b;
+
+#ifndef UNROLL_LOOPS
+    int i;
+#endif
+
+    block_nb = (1 + ((SHA224_BLOCK_SIZE - 9)
+                     < (ctx->len % SHA224_BLOCK_SIZE)));
+
+    len_b = (ctx->tot_len + ctx->len) << 3;
+    pm_len = block_nb << 6;
+
+    memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
+    ctx->block[ctx->len] = 0x80;
+    UNPACK32(len_b, ctx->block + pm_len - 4);
+
+    sha256_transf(ctx, ctx->block, block_nb);
+
+#ifndef UNROLL_LOOPS
+    for (i = 0 ; i < 7; i++) {
+        UNPACK32(ctx->h[i], &digest[i << 2]);
+    }
+#else
+   UNPACK32(ctx->h[0], &digest[ 0]);
+   UNPACK32(ctx->h[1], &digest[ 4]);
+   UNPACK32(ctx->h[2], &digest[ 8]);
+   UNPACK32(ctx->h[3], &digest[12]);
+   UNPACK32(ctx->h[4], &digest[16]);
+   UNPACK32(ctx->h[5], &digest[20]);
+   UNPACK32(ctx->h[6], &digest[24]);
+#endif /* !UNROLL_LOOPS */
+}
+
+#ifdef TEST_VECTORS
+
+/* FIPS 180-2 Validation tests */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+void test(const char *vector, unsigned char *digest,
+          unsigned int digest_size)
+{
+    char output[2 * SHA512_DIGEST_SIZE + 1];
+    int i;
+
+    output[2 * digest_size] = '\0';
+
+    for (i = 0; i < (int) digest_size ; i++) {
+       sprintf(output + 2 * i, "%02x", digest[i]);
+    }
+
+    printf("H: %s\n", output);
+    if (strcmp(vector, output)) {
+        fprintf(stderr, "Test failed.\n");
+        exit(EXIT_FAILURE);
+    }
+}
+
+int main(void)
+{
+    static const char *vectors[4][3] =
+    {   /* SHA-224 */
+        {
+        "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7",
+        "75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525",
+        "20794655980c91d8bbb4c1ea97618a4bf03f42581948b2ee4ee7ad67",
+        },
+        /* SHA-256 */
+        {
+        "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
+        "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1",
+        "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0",
+        },
+        /* SHA-384 */
+        {
+        "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed"
+        "8086072ba1e7cc2358baeca134c825a7",
+        "09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712"
+        "fcc7c71a557e2db966c3e9fa91746039",
+        "9d0e1809716474cb086e834e310a4a1ced149e9c00f248527972cec5704c2a5b"
+        "07b8b3dc38ecc4ebae97ddd87f3d8985",
+        },
+        /* SHA-512 */
+        {
+        "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a"
+        "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f",
+        "8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018"
+        "501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909",
+        "e718483d0ce769644e2e42c7bc15b4638e1f98b13b2044285632a803afa973eb"
+        "de0ff244877ea60a4cb0432ce577c31beb009c5c2c49aa2e4eadb217ad8cc09b"
+        }
+    };
+
+    static const char message1[] = "abc";
+    static const char message2a[] = "abcdbcdecdefdefgefghfghighijhi"
+                                    "jkijkljklmklmnlmnomnopnopq";
+    static const char message2b[] = "abcdefghbcdefghicdefghijdefghijkefghij"
+                                    "klfghijklmghijklmnhijklmnoijklmnopjklm"
+                                    "nopqklmnopqrlmnopqrsmnopqrstnopqrstu";
+    unsigned char *message3;
+    unsigned int message3_len = 1000000;
+    unsigned char digest[SHA512_DIGEST_SIZE];
+
+    message3 = malloc(message3_len);
+    if (message3 == NULL) {
+        fprintf(stderr, "Can't allocate memory\n");
+        return -1;
+    }
+    memset(message3, 'a', message3_len);
+
+    printf("SHA-2 FIPS 180-2 Validation tests\n\n");
+    printf("SHA-224 Test vectors\n");
+
+    sha224((const unsigned char *) message1, strlen(message1), digest);
+    test(vectors[0][0], digest, SHA224_DIGEST_SIZE);
+    sha224((const unsigned char *) message2a, strlen(message2a), digest);
+    test(vectors[0][1], digest, SHA224_DIGEST_SIZE);
+    sha224(message3, message3_len, digest);
+    test(vectors[0][2], digest, SHA224_DIGEST_SIZE);
+    printf("\n");
+
+    printf("SHA-256 Test vectors\n");
+
+    sha256((const unsigned char *) message1, strlen(message1), digest);
+    test(vectors[1][0], digest, SHA256_DIGEST_SIZE);
+    sha256((const unsigned char *) message2a, strlen(message2a), digest);
+    test(vectors[1][1], digest, SHA256_DIGEST_SIZE);
+    sha256(message3, message3_len, digest);
+    test(vectors[1][2], digest, SHA256_DIGEST_SIZE);
+    printf("\n");
+
+    printf("SHA-384 Test vectors\n");
+
+    sha384((const unsigned char *) message1, strlen(message1), digest);
+    test(vectors[2][0], digest, SHA384_DIGEST_SIZE);
+    sha384((const unsigned char *)message2b, strlen(message2b), digest);
+    test(vectors[2][1], digest, SHA384_DIGEST_SIZE);
+    sha384(message3, message3_len, digest);
+    test(vectors[2][2], digest, SHA384_DIGEST_SIZE);
+    printf("\n");
+
+    printf("SHA-512 Test vectors\n");
+
+    sha512((const unsigned char *) message1, strlen(message1), digest);
+    test(vectors[3][0], digest, SHA512_DIGEST_SIZE);
+    sha512((const unsigned char *) message2b, strlen(message2b), digest);
+    test(vectors[3][1], digest, SHA512_DIGEST_SIZE);
+    sha512(message3, message3_len, digest);
+    test(vectors[3][2], digest, SHA512_DIGEST_SIZE);
+    printf("\n");
+
+    printf("All tests passed.\n");
+
+    return 0;
+}
+
+#endif /* TEST_VECTORS */
+
diff --git a/3rdparty/hmac_sha/sha2.h b/3rdparty/hmac_sha/sha2.h
new file mode 100644
index 0000000..60f52e3
--- /dev/null
+++ b/3rdparty/hmac_sha/sha2.h
@@ -0,0 +1,108 @@
+/*
+ * FIPS 180-2 SHA-224/256/384/512 implementation
+ * Last update: 02/02/2007
+ * Issue date:  04/30/2005
+ *
+ * Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the project nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#ifndef SHA2_H
+#define SHA2_H
+
+#define SHA224_DIGEST_SIZE ( 224 / 8)
+#define SHA256_DIGEST_SIZE ( 256 / 8)
+#define SHA384_DIGEST_SIZE ( 384 / 8)
+#define SHA512_DIGEST_SIZE ( 512 / 8)
+
+#define SHA256_BLOCK_SIZE  ( 512 / 8)
+#define SHA512_BLOCK_SIZE  (1024 / 8)
+#define SHA384_BLOCK_SIZE  SHA512_BLOCK_SIZE
+#define SHA224_BLOCK_SIZE  SHA256_BLOCK_SIZE
+
+#ifndef SHA2_TYPES
+#define SHA2_TYPES
+typedef unsigned char uint8;
+typedef unsigned int  uint32;
+typedef unsigned long long uint64;
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef struct {
+    unsigned int tot_len;
+    unsigned int len;
+    unsigned char block[2 * SHA256_BLOCK_SIZE];
+    uint32 h[8];
+} sha256_ctx;
+
+typedef struct {
+    unsigned int tot_len;
+    unsigned int len;
+    unsigned char block[2 * SHA512_BLOCK_SIZE];
+    uint64 h[8];
+} sha512_ctx;
+
+typedef sha512_ctx sha384_ctx;
+typedef sha256_ctx sha224_ctx;
+
+void sha224_init(sha224_ctx *ctx);
+void sha224_update(sha224_ctx *ctx, const unsigned char *message,
+                   unsigned int len);
+void sha224_final(sha224_ctx *ctx, unsigned char *digest);
+void sha224(const unsigned char *message, unsigned int len,
+            unsigned char *digest);
+
+void sha256_init(sha256_ctx * ctx);
+void sha256_update(sha256_ctx *ctx, const unsigned char *message,
+                   unsigned int len);
+void sha256_final(sha256_ctx *ctx, unsigned char *digest);
+void sha256(const unsigned char *message, unsigned int len,
+            unsigned char *digest);
+
+void sha384_init(sha384_ctx *ctx);
+void sha384_update(sha384_ctx *ctx, const unsigned char *message,
+                   unsigned int len);
+void sha384_final(sha384_ctx *ctx, unsigned char *digest);
+void sha384(const unsigned char *message, unsigned int len,
+            unsigned char *digest);
+
+void sha512_init(sha512_ctx *ctx);
+void sha512_update(sha512_ctx *ctx, const unsigned char *message,
+                   unsigned int len);
+void sha512_final(sha512_ctx *ctx, unsigned char *digest);
+void sha512(const unsigned char *message, unsigned int len,
+            unsigned char *digest);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* !SHA2_H */
+
diff --git a/Makefile b/Makefile
index ae846e2..33d988d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,11 @@
 CC ?= gcc
 AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
 CFLAGS ?= -g -O2
-objects = mmc.o mmc_cmds.o
+objects = \
+	mmc.o \
+	mmc_cmds.o \
+	3rdparty/hmac_sha/hmac_sha2.o \
+	3rdparty/hmac_sha/sha2.o
 
 CHECKFLAGS = -Wall -Werror -Wuninitialized -Wundef
 
@@ -28,7 +32,7 @@ all: $(progs) manpages
 ifdef C
 	$(check) $<
 endif
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(DEPFLAGS) -c $< -o $@
 
 mmc: $(objects)
 	$(CC) $(CFLAGS) -o $@ $(objects) $(LDFLAGS) $(LIBS)
-- 
2.0.0

