From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/3] mmc_test: make performance test area size about 4MiB
Date: Tue,  8 Feb 2011 13:41:01 +0200
Message-ID: <1297165263-656-2-git-send-email-adrian.hunter@nokia.com>
References: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:51032 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab1BHLla (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Feb 2011 06:41:30 -0500
In-Reply-To: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

The test area size was set to the preferred erase size
but for comparison purposes it is better if it is the
same size for different devices.  Make it a multiple
of preferred erase size that is greater than or equal
to 4MiB.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/mmc_test.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0131c6c..ec6060c 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -1426,28 +1426,29 @@ static int mmc_test_area_cleanup(struct mmc_test_card *test)
 }
 
 /*
- * Initialize an area for testing large transfers.  The size of the area is the
- * preferred erase size which is a good size for optimal transfer speed.  Note
- * that is typically 4MiB for modern cards.  The test area is set to the middle
- * of the card because cards may have different charateristics at the front
- * (for FAT file system optimization).  Optionally, the area is erased (if the
- * card supports it) which may improve write performance.  Optionally, the area
- * is filled with data for subsequent read tests.
+ * Initialize an area for testing large transfers.  The test area is set to the
+ * middle of the card because cards may have different charateristics at the
+ * front (for FAT file system optimization).  Optionally, the area is erased
+ * (if the card supports it) which may improve write performance.  Optionally,
+ * the area is filled with data for subsequent read tests.
  */
 static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 {
 	struct mmc_test_area *t = &test->area;
-	unsigned long min_sz = 64 * 1024;
+	unsigned long min_sz = 64 * 1024, sz;
 	int ret;
 
 	ret = mmc_test_set_blksize(test, 512);
 	if (ret)
 		return ret;
 
-	if (test->card->pref_erase > TEST_AREA_MAX_SIZE >> 9)
-		t->max_sz = TEST_AREA_MAX_SIZE;
-	else
-		t->max_sz = (unsigned long)test->card->pref_erase << 9;
+	/* Make the test area size about 4MiB */
+	sz = (unsigned long)test->card->pref_erase << 9;
+	t->max_sz = sz;
+	while (t->max_sz < 4 * 1024 * 1024)
+		t->max_sz += sz;
+	while (t->max_sz > TEST_AREA_MAX_SIZE && t->max_sz > sz)
+		t->max_sz -= sz;
 
 	t->max_segs = test->card->host->max_segs;
 	t->max_seg_sz = test->card->host->max_seg_size;
-- 
1.7.0.4

