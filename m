From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/8] mmc/core/mmc_test: Add some spaces for better code
 readability
Date: Sun, 8 Jan 2017 22:46:55 +0100
Message-ID: <e9f51945-fe2a-c102-2f40-08635e4f6f69@users.sourceforge.net>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 8 Jan 2017 20:25:39 +0100

Use space characters at some source code places according to
the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/mmc_test.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 848f4f30e343..42aefd3df09b 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -641,11 +641,11 @@ static int __mmc_test_prepare(struct mmc_test_card *test, int write)
 	if (write)
 		memset(test->buffer, 0xDF, 512);
 	else {
-		for (i = 0;i < 512;i++)
+		for (i = 0; i < 512; i++)
 			test->buffer[i] = i;
 	}
 
-	for (i = 0;i < BUFFER_SIZE / 512;i++) {
+	for (i = 0; i < BUFFER_SIZE / 512; i++) {
 		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
@@ -674,7 +674,7 @@ static int mmc_test_cleanup(struct mmc_test_card *test)
 
 	memset(test->buffer, 0, 512);
 
-	for (i = 0;i < BUFFER_SIZE / 512;i++) {
+	for (i = 0; i < BUFFER_SIZE / 512; i++) {
 		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
@@ -946,7 +946,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 	unsigned long flags;
 
 	if (write) {
-		for (i = 0;i < blocks * blksz;i++)
+		for (i = 0; i < blocks * blksz; i++)
 			test->scratch[i] = i;
 	} else {
 		memset(test->scratch, 0, BUFFER_SIZE);
@@ -980,7 +980,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 
 		memset(test->buffer, 0, sectors * 512);
 
-		for (i = 0;i < sectors;i++) {
+		for (i = 0; i < sectors; i++) {
 			ret = mmc_test_buffer_transfer(test,
 				test->buffer + i * 512,
 				dev_addr + i, 512, 0);
@@ -988,12 +988,12 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 				return ret;
 		}
 
-		for (i = 0;i < blocks * blksz;i++) {
+		for (i = 0; i < blocks * blksz; i++) {
 			if (test->buffer[i] != (u8)i)
 				return RESULT_FAIL;
 		}
 
-		for (;i < sectors * 512;i++) {
+		for (; i < sectors * 512; i++) {
 			if (test->buffer[i] != 0xDF)
 				return RESULT_FAIL;
 		}
@@ -1001,7 +1001,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 		local_irq_save(flags);
 		sg_copy_to_buffer(sg, sg_len, test->scratch, BUFFER_SIZE);
 		local_irq_restore(flags);
-		for (i = 0;i < blocks * blksz;i++) {
+		for (i = 0; i < blocks * blksz; i++) {
 			if (test->scratch[i] != (u8)i)
 				return RESULT_FAIL;
 		}
@@ -1086,7 +1086,7 @@ static int mmc_test_multi_write(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, size);
 
-	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
+	return mmc_test_transfer(test, &sg, 1, 0, size / 512, 512, 1);
 }
 
 static int mmc_test_multi_read(struct mmc_test_card *test)
@@ -1107,7 +1107,7 @@ static int mmc_test_multi_read(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, size);
 
-	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
+	return mmc_test_transfer(test, &sg, 1, 0, size / 512, 512, 0);
 }
 
 static int mmc_test_pow2_write(struct mmc_test_card *test)
@@ -1118,7 +1118,7 @@ static int mmc_test_pow2_write(struct mmc_test_card *test)
 	if (!test->card->csd.write_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 1; i < 512;i <<= 1) {
+	for (i = 1; i < 512; i <<= 1) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 1);
 		if (ret)
@@ -1136,7 +1136,7 @@ static int mmc_test_pow2_read(struct mmc_test_card *test)
 	if (!test->card->csd.read_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 1; i < 512;i <<= 1) {
+	for (i = 1; i < 512; i <<= 1) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 0);
 		if (ret)
@@ -1154,7 +1154,7 @@ static int mmc_test_weird_write(struct mmc_test_card *test)
 	if (!test->card->csd.write_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 3; i < 512;i += 7) {
+	for (i = 3; i < 512; i += 7) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 1);
 		if (ret)
@@ -1172,7 +1172,7 @@ static int mmc_test_weird_read(struct mmc_test_card *test)
 	if (!test->card->csd.read_partial)
 		return RESULT_UNSUP_CARD;
 
-	for (i = 3; i < 512;i += 7) {
+	for (i = 3; i < 512; i += 7) {
 		sg_init_one(&sg, test->buffer, i);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, i, 0);
 		if (ret)
@@ -1231,7 +1231,7 @@ static int mmc_test_align_multi_write(struct mmc_test_card *test)
 
 	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
-		ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
+		ret = mmc_test_transfer(test, &sg, 1, 0, size / 512, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -1258,7 +1258,7 @@ static int mmc_test_align_multi_read(struct mmc_test_card *test)
 
 	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
-		ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
+		ret = mmc_test_transfer(test, &sg, 1, 0, size / 512, 512, 0);
 		if (ret)
 			return ret;
 	}
@@ -1357,7 +1357,7 @@ static int mmc_test_multi_write_high(struct mmc_test_card *test)
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, size, 0);
 
-	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
+	return mmc_test_transfer(test, &sg, 1, 0, size / 512, 512, 1);
 }
 
 static int mmc_test_multi_read_high(struct mmc_test_card *test)
@@ -1379,7 +1379,7 @@ static int mmc_test_multi_read_high(struct mmc_test_card *test)
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, size, 0);
 
-	return mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
+	return mmc_test_transfer(test, &sg, 1, 0, size / 512, 512, 0);
 }
 
 #else
@@ -2147,7 +2147,7 @@ static int mmc_test_rw_multiple_sg_len(struct mmc_test_card *test,
 	int i;
 
 	for (i = 0 ; i < rw->len && ret == 0; i++) {
-		ret = mmc_test_rw_multiple(test, rw, 512*1024, rw->size,
+		ret = mmc_test_rw_multiple(test, rw, 512 * 1024, rw->size,
 					   rw->sg_len[i]);
 		if (ret)
 			break;
@@ -2954,7 +2954,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
 
 	mmc_claim_host(test->card->host);
 
-	for (i = 0;i < ARRAY_SIZE(mmc_test_cases);i++) {
+	for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++) {
 		struct mmc_test_general_result *gr;
 
 		if (testcase && ((i + 1) != testcase))
@@ -3165,7 +3165,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
 
 	seq_puts(sf, "0:\tRun all tests\n");
 	for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++)
-		seq_printf(sf, "%d:\t%s\n", i+1, mmc_test_cases[i].name);
+		seq_printf(sf, "%d:\t%s\n", i + 1, mmc_test_cases[i].name);
 
 	mutex_unlock(&mmc_test_lock);
 
-- 
2.11.0
