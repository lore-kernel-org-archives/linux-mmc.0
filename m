From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/2] mmc_test: fix memory allocation segment limits
Date: Thu, 23 Sep 2010 14:51:29 +0300
Message-ID: <20100923115129.18000.59696.sendpatchset@ahunter-work.research.nokia.com>
References: <20100923115122.18000.46750.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46551 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab0IWLv5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 07:51:57 -0400
In-Reply-To: <20100923115122.18000.46750.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>

>From aad98716cd9e8f83831721010d58d2a9f8ea2d2b Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 23 Sep 2010 12:55:15 +0300
Subject: [PATCH 1/2] mmc_test: fix memory allocation segment limits

Correctly allocate memory to meet the host controller
driver's maximum segment size and count limits.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/mmc_test.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 6580af7..5874040 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -318,8 +318,8 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 
 	if (max_page_cnt > limit)
 		max_page_cnt = limit;
-	if (max_page_cnt < min_page_cnt)
-		max_page_cnt = min_page_cnt;
+	if (min_page_cnt > max_page_cnt)
+		min_page_cnt = max_page_cnt;
 
 	if (max_seg_page_cnt > max_page_cnt)
 		max_seg_page_cnt = max_page_cnt;
@@ -359,13 +359,13 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 		mem->cnt += 1;
 		if (max_page_cnt <= (1UL << order))
 			break;
+		max_page_cnt -= 1UL << order;
+		page_cnt += 1UL << order;
 		if (mem->cnt >= max_segs) {
 			if (page_cnt < min_page_cnt)
 				goto out_free;
 			break;
 		}
-		max_page_cnt -= 1UL << order;
-		page_cnt += 1UL << order;
 	}
 
 	return mem;
@@ -1470,12 +1470,12 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 		t->max_tfr = t->max_segs * t->max_seg_sz;
 
 	/*
-	 * Try to allocate enough memory for the whole area.  Less is OK
+	 * Try to allocate enough memory for a max. sized transfer.  Less is OK
 	 * because the same memory can be mapped into the scatterlist more than
 	 * once.  Also, take into account the limits imposed on scatterlist
 	 * segments by the host driver.
 	 */
-	t->mem = mmc_test_alloc_mem(min_sz, t->max_sz, t->max_segs,
+	t->mem = mmc_test_alloc_mem(min_sz, t->max_tfr, t->max_segs,
 				    t->max_seg_sz);
 	if (!t->mem)
 		return -ENOMEM;
-- 
1.7.0.4

