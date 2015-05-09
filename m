From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] mmc: card: mmc_test: Simplify a trivial if-return sequence
Date: Sat,  9 May 2015 18:44:49 -0300
Message-ID: <1431207891-21448-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35624 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbEIVpS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 May 2015 17:45:18 -0400
Received: by qgej70 with SMTP id j70so52005265qge.2
        for <linux-mmc@vger.kernel.org>; Sat, 09 May 2015 14:45:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Simplify a trivial if-return sequence. Possibly combine with a
preceding function call.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/simple_return.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/card/mmc_test.c | 100 +++++++-------------------------------------
 1 file changed, 15 insertions(+), 85 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 53b7413..5e90b3f 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -268,8 +268,6 @@ static int mmc_test_wait_busy(struct mmc_test_card *test)
 static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 	u8 *buffer, unsigned addr, unsigned blksz, int write)
 {
-	int ret;
-
 	struct mmc_request mrq = {0};
 	struct mmc_command cmd = {0};
 	struct mmc_command stop = {0};
@@ -292,11 +290,7 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 	if (data.error)
 		return data.error;
 
-	ret = mmc_test_wait_busy(test);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_wait_busy(test);
 }
 
 static void mmc_test_free_mem(struct mmc_test_mem *mem)
@@ -994,11 +988,7 @@ static int mmc_test_basic_write(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	ret = mmc_test_simple_transfer(test, &sg, 1, 0, 1, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_simple_transfer(test, &sg, 1, 0, 1, 512, 1);
 }
 
 static int mmc_test_basic_read(struct mmc_test_card *test)
@@ -1012,44 +1002,29 @@ static int mmc_test_basic_read(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	ret = mmc_test_simple_transfer(test, &sg, 1, 0, 1, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_simple_transfer(test, &sg, 1, 0, 1, 512, 0);
 }
 
 static int mmc_test_verify_write(struct mmc_test_card *test)
 {
-	int ret;
 	struct scatterlist sg;
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
 }
 
 static int mmc_test_verify_read(struct mmc_test_card *test)
 {
-	int ret;
 	struct scatterlist sg;
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
 }
 
 static int mmc_test_multi_write(struct mmc_test_card *test)
 {
-	int ret;
 	unsigned int size;
 	struct scatterlist sg;
 
@@ -1066,16 +1041,11 @@ static int mmc_test_multi_write(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, size);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
 }
 
 static int mmc_test_multi_read(struct mmc_test_card *test)
 {
-	int ret;
 	unsigned int size;
 	struct scatterlist sg;
 
@@ -1092,11 +1062,7 @@ static int mmc_test_multi_read(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, size);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
 }
 
 static int mmc_test_pow2_write(struct mmc_test_card *test)
@@ -1263,11 +1229,7 @@ static int mmc_test_xfersize_write(struct mmc_test_card *test)
 	if (ret)
 		return ret;
 
-	ret = mmc_test_broken_transfer(test, 1, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_broken_transfer(test, 1, 512, 1);
 }
 
 static int mmc_test_xfersize_read(struct mmc_test_card *test)
@@ -1278,11 +1240,7 @@ static int mmc_test_xfersize_read(struct mmc_test_card *test)
 	if (ret)
 		return ret;
 
-	ret = mmc_test_broken_transfer(test, 1, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_broken_transfer(test, 1, 512, 0);
 }
 
 static int mmc_test_multi_xfersize_write(struct mmc_test_card *test)
@@ -1296,11 +1254,7 @@ static int mmc_test_multi_xfersize_write(struct mmc_test_card *test)
 	if (ret)
 		return ret;
 
-	ret = mmc_test_broken_transfer(test, 2, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_broken_transfer(test, 2, 512, 1);
 }
 
 static int mmc_test_multi_xfersize_read(struct mmc_test_card *test)
@@ -1314,48 +1268,33 @@ static int mmc_test_multi_xfersize_read(struct mmc_test_card *test)
 	if (ret)
 		return ret;
 
-	ret = mmc_test_broken_transfer(test, 2, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_broken_transfer(test, 2, 512, 0);
 }
 
 #ifdef CONFIG_HIGHMEM
 
 static int mmc_test_write_high(struct mmc_test_card *test)
 {
-	int ret;
 	struct scatterlist sg;
 
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, 512, 0);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
 }
 
 static int mmc_test_read_high(struct mmc_test_card *test)
 {
-	int ret;
 	struct scatterlist sg;
 
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, 512, 0);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
 }
 
 static int mmc_test_multi_write_high(struct mmc_test_card *test)
 {
-	int ret;
 	unsigned int size;
 	struct scatterlist sg;
 
@@ -1373,16 +1312,11 @@ static int mmc_test_multi_write_high(struct mmc_test_card *test)
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, size, 0);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
 }
 
 static int mmc_test_multi_read_high(struct mmc_test_card *test)
 {
-	int ret;
 	unsigned int size;
 	struct scatterlist sg;
 
@@ -1400,11 +1334,7 @@ static int mmc_test_multi_read_high(struct mmc_test_card *test)
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, size, 0);
 
-	ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
 }
 
 #else
-- 
1.9.1

