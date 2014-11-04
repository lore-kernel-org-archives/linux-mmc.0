From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 15/15] mmc: mmc_test: Extend "Badly aligned" tests for 8-byte alignment
Date: Tue,  4 Nov 2014 12:42:49 +0200
Message-ID: <1415097769-19032-16-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52220 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071AbaKDKpO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:45:14 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The "Badly aligned" tests, test reading/writing with alignments
of 1,2 and 3.  SDHCI now has 64-bit ADMA which has 8-byte
alignment, so extend the tests to test up to 7.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/mmc_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b064343..0a7430f 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -33,6 +33,8 @@
 #define BUFFER_ORDER		2
 #define BUFFER_SIZE		(PAGE_SIZE << BUFFER_ORDER)
 
+#define TEST_ALIGN_END		8
+
 /*
  * Limit the test area size to the maximum MMC HC erase group size.  Note that
  * the maximum SD allocation unit size is just 4MiB.
@@ -1175,7 +1177,7 @@ static int mmc_test_align_write(struct mmc_test_card *test)
 	int ret, i;
 	struct scatterlist sg;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, 512);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
 		if (ret)
@@ -1190,7 +1192,7 @@ static int mmc_test_align_read(struct mmc_test_card *test)
 	int ret, i;
 	struct scatterlist sg;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, 512);
 		ret = mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
 		if (ret)
@@ -1217,7 +1219,7 @@ static int mmc_test_align_multi_write(struct mmc_test_card *test)
 	if (size < 1024)
 		return RESULT_UNSUP_HOST;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
 		ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 1);
 		if (ret)
@@ -1244,7 +1246,7 @@ static int mmc_test_align_multi_read(struct mmc_test_card *test)
 	if (size < 1024)
 		return RESULT_UNSUP_HOST;
 
-	for (i = 1;i < 4;i++) {
+	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
 		ret = mmc_test_transfer(test, &sg, 1, 0, size/512, 512, 0);
 		if (ret)
-- 
1.9.1

