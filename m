From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: mmc_test: fix performance tests that go over max_blk_count
Date: Fri, 10 Sep 2010 11:33:45 +0300
Message-ID: <4C89ED69.8000301@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48215 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab0IJIeF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Sep 2010 04:34:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>From dacef4282145d641c1dd410fef08f0292ac147be Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 6 Sep 2010 12:54:06 +0300
Subject: [PATCH] mmc_test: fix performance tests that go over max_blk_count

The host controller driver limits I/O transfers to maximum
transfer size, maximum block count, maximum segment size
and maximum segment count.  The performance tests were
not obeying these limits which meant they would not work
with some drivers.  This patch fixes that.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---



Note that this patch is dependent on patch
"[PATCH] mmc: Remove distinction between hw and phys segments"
from Martin K. Petersen <martin.petersen@oracle.com>



 drivers/mmc/card/mmc_test.c |  183 +++++++++++++++++++++++++++++++-----------
 1 files changed, 135 insertions(+), 48 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5dd8576..b7ac30a 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -56,7 +56,9 @@ struct mmc_test_mem {
  * struct mmc_test_area - information for performance tests.
  * @max_sz: test area size (in bytes)
  * @dev_addr: address on card at which to do performance tests
- * @max_segs: maximum segments in scatterlist @sg
+ * @max_tfr: maximum transfer size allowed by driver (in bytes)
+ * @max_segs: maximum segments allowed by driver in scatterlist @sg
+ * @max_seg_sz: maximum segment size allowed by driver
  * @blocks: number of (512 byte) blocks currently mapped by @sg
  * @sg_len: length of currently mapped scatterlist @sg
  * @mem: allocated memory
@@ -65,7 +67,9 @@ struct mmc_test_mem {
 struct mmc_test_area {
 	unsigned long max_sz;
 	unsigned int dev_addr;
+	unsigned int max_tfr;
 	unsigned int max_segs;
+	unsigned int max_seg_sz;
 	unsigned int blocks;
 	unsigned int sg_len;
 	struct mmc_test_mem *mem;
@@ -245,13 +249,18 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
 
 /*
  * Allocate a lot of memory, preferrably max_sz but at least min_sz.  In case
- * there isn't much memory do not exceed 1/16th total lowmem pages.
+ * there isn't much memory do not exceed 1/16th total lowmem pages.  Also do
+ * not exceed a maximum number of segments and try not to make segments much
+ * bigger than maximum segment size.
  */
 static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
-					       unsigned long max_sz)
+					       unsigned long max_sz,
+					       unsigned int max_segs,
+					       unsigned int max_seg_sz)
 {
 	unsigned long max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
 	unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
+	unsigned long max_seg_page_cnt = DIV_ROUND_UP(max_seg_sz, PAGE_SIZE);
 	unsigned long page_cnt = 0;
 	unsigned long limit = nr_free_buffer_pages() >> 4;
 	struct mmc_test_mem *mem;
@@ -261,11 +270,17 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	if (max_page_cnt < min_page_cnt)
 		max_page_cnt = min_page_cnt;
 
+	if (max_seg_page_cnt > max_page_cnt)
+		max_seg_page_cnt = max_page_cnt;
+
+	if (max_segs > max_page_cnt)
+		max_segs = max_page_cnt;
+
 	mem = kzalloc(sizeof(struct mmc_test_mem), GFP_KERNEL);
 	if (!mem)
 		return NULL;
 
-	mem->arr = kzalloc(sizeof(struct mmc_test_pages) * max_page_cnt,
+	mem->arr = kzalloc(sizeof(struct mmc_test_pages) * max_segs,
 			   GFP_KERNEL);
 	if (!mem->arr)
 		goto out_free;
@@ -276,7 +291,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 		gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
 				__GFP_NORETRY;
 
-		order = get_order(max_page_cnt << PAGE_SHIFT);
+		order = get_order(max_seg_page_cnt << PAGE_SHIFT);
 		while (1) {
 			page = alloc_pages(flags, order);
 			if (page || !order)
@@ -293,6 +308,11 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 		mem->cnt += 1;
 		if (max_page_cnt <= (1UL << order))
 			break;
+		if (mem->cnt >= max_segs) {
+			if (page_cnt < min_page_cnt)
+				goto out_free;
+			break;
+		}
 		max_page_cnt -= 1UL << order;
 		page_cnt += 1UL << order;
 	}
@@ -310,7 +330,8 @@ out_free:
  */
 static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long sz,
 			   struct scatterlist *sglist, int repeat,
-			   unsigned int max_segs, unsigned int *sg_len)
+			   unsigned int max_segs, unsigned int max_seg_sz,
+			   unsigned int *sg_len)
 {
 	struct scatterlist *sg = NULL;
 	unsigned int i;
@@ -322,8 +343,10 @@ static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long sz,
 		for (i = 0; i < mem->cnt; i++) {
 			unsigned long len = PAGE_SIZE << mem->arr[i].order;
 
-			if (sz < len)
+			if (len > sz)
 				len = sz;
+			if (len > max_seg_sz)
+				len = max_seg_sz;
 			if (sg)
 				sg = sg_next(sg);
 			else
@@ -355,6 +378,7 @@ static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
 				       unsigned long sz,
 				       struct scatterlist *sglist,
 				       unsigned int max_segs,
+				       unsigned int max_seg_sz,
 				       unsigned int *sg_len)
 {
 	struct scatterlist *sg = NULL;
@@ -365,7 +389,7 @@ static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
 	sg_init_table(sglist, max_segs);
 
 	*sg_len = 0;
-	while (sz && i) {
+	while (sz) {
 		base = page_address(mem->arr[--i].page);
 		cnt = 1 << mem->arr[i].order;
 		while (sz && cnt) {
@@ -374,7 +398,9 @@ static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
 				continue;
 			last_addr = addr;
 			len = PAGE_SIZE;
-			if (sz < len)
+			if (len > max_seg_sz)
+				len = max_seg_sz;
+			if (len > sz)
 				len = sz;
 			if (sg)
 				sg = sg_next(sg);
@@ -386,6 +412,8 @@ static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
 			sz -= len;
 			*sg_len += 1;
 		}
+		if (i == 0)
+			i = mem->cnt;
 	}
 
 	if (sg)
@@ -1215,16 +1243,22 @@ static int mmc_test_area_map(struct mmc_test_card *test, unsigned long sz,
 			     int max_scatter)
 {
 	struct mmc_test_area *t = &test->area;
+	int err;
 
 	t->blocks = sz >> 9;
 
 	if (max_scatter) {
-		return mmc_test_map_sg_max_scatter(t->mem, sz, t->sg,
-						   t->max_segs, &t->sg_len);
-	} else {
-		return mmc_test_map_sg(t->mem, sz, t->sg, 1, t->max_segs,
+		err = mmc_test_map_sg_max_scatter(t->mem, sz, t->sg,
+						  t->max_segs, t->max_seg_sz,
 				       &t->sg_len);
+	} else {
+		err = mmc_test_map_sg(t->mem, sz, t->sg, 1, t->max_segs,
+				      t->max_seg_sz, &t->sg_len);
 	}
+	if (err)
+		printk(KERN_INFO "%s: Failed to map sg list\n",
+		       mmc_hostname(test->card->host));
+	return err;
 }
 
 /*
@@ -1249,6 +1283,22 @@ static int mmc_test_area_io(struct mmc_test_card *test, unsigned long sz,
 	struct timespec ts1, ts2;
 	int ret;
 
+	/*
+	 * In the case of a maximally scattered transfer, the maximum transfer
+	 * size is further limited by using PAGE_SIZE segments.
+	 */
+	if (max_scatter) {
+		struct mmc_test_area *t = &test->area;
+		unsigned long max_tfr;
+
+		if (t->max_seg_sz >= PAGE_SIZE)
+			max_tfr = t->max_segs * PAGE_SIZE;
+		else
+			max_tfr = t->max_segs * t->max_seg_sz;
+		if (sz > max_tfr)
+			sz = max_tfr;
+	}
+
 	ret = mmc_test_area_map(test, sz, max_scatter);
 	if (ret)
 		return ret;
@@ -1274,7 +1324,7 @@ static int mmc_test_area_io(struct mmc_test_card *test, unsigned long sz,
  */
 static int mmc_test_area_fill(struct mmc_test_card *test)
 {
-	return mmc_test_area_io(test, test->area.max_sz, test->area.dev_addr,
+	return mmc_test_area_io(test, test->area.max_tfr, test->area.dev_addr,
 				1, 0, 0);
 }
 
@@ -1328,16 +1378,29 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 		t->max_sz = TEST_AREA_MAX_SIZE;
 	else
 		t->max_sz = (unsigned long)test->card->pref_erase << 9;
+
+	t->max_segs = test->card->host->max_segs;
+	t->max_seg_sz = test->card->host->max_seg_size;
+
+	t->max_tfr = t->max_sz;
+	if (t->max_tfr >> 9 > test->card->host->max_blk_count)
+		t->max_tfr = test->card->host->max_blk_count << 9;
+	if (t->max_tfr > test->card->host->max_req_size)
+		t->max_tfr = test->card->host->max_req_size;
+	if (t->max_tfr / t->max_seg_sz > t->max_segs)
+		t->max_tfr = t->max_segs * t->max_seg_sz;
+
 	/*
 	 * Try to allocate enough memory for the whole area.  Less is OK
 	 * because the same memory can be mapped into the scatterlist more than
-	 * once.
+	 * once.  Also, take into account the limits imposed on scatterlist
+	 * segments by the host driver.
 	 */
-	t->mem = mmc_test_alloc_mem(min_sz, t->max_sz);
+	t->mem = mmc_test_alloc_mem(min_sz, t->max_sz, t->max_segs,
+				    t->max_seg_sz);
 	if (!t->mem)
 		return -ENOMEM;
 
-	t->max_segs = DIV_ROUND_UP(t->max_sz, PAGE_SIZE);
 	t->sg = kmalloc(sizeof(struct scatterlist) * t->max_segs, GFP_KERNEL);
 	if (!t->sg) {
 		ret = -ENOMEM;
@@ -1401,7 +1464,7 @@ static int mmc_test_area_prepare_fill(struct mmc_test_card *test)
 static int mmc_test_best_performance(struct mmc_test_card *test, int write,
 				     int max_scatter)
 {
-	return mmc_test_area_io(test, test->area.max_sz, test->area.dev_addr,
+	return mmc_test_area_io(test, test->area.max_tfr, test->area.dev_addr,
 				write, max_scatter, 1);
 }
 
@@ -1446,12 +1509,13 @@ static int mmc_test_profile_read_perf(struct mmc_test_card *test)
 	unsigned int dev_addr;
 	int ret;
 
-	for (sz = 512; sz < test->area.max_sz; sz <<= 1) {
+	for (sz = 512; sz < test->area.max_tfr; sz <<= 1) {
 		dev_addr = test->area.dev_addr + (sz >> 9);
 		ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 1);
 		if (ret)
 			return ret;
 	}
+	sz = test->area.max_tfr;
 	dev_addr = test->area.dev_addr;
 	return mmc_test_area_io(test, sz, dev_addr, 0, 0, 1);
 }
@@ -1468,7 +1532,7 @@ static int mmc_test_profile_write_perf(struct mmc_test_card *test)
 	ret = mmc_test_area_erase(test);
 	if (ret)
 		return ret;
-	for (sz = 512; sz < test->area.max_sz; sz <<= 1) {
+	for (sz = 512; sz < test->area.max_tfr; sz <<= 1) {
 		dev_addr = test->area.dev_addr + (sz >> 9);
 		ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 1);
 		if (ret)
@@ -1477,6 +1541,7 @@ static int mmc_test_profile_write_perf(struct mmc_test_card *test)
 	ret = mmc_test_area_erase(test);
 	if (ret)
 		return ret;
+	sz = test->area.max_tfr;
 	dev_addr = test->area.dev_addr;
 	return mmc_test_area_io(test, sz, dev_addr, 1, 0, 1);
 }
@@ -1516,29 +1581,63 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 	return 0;
 }
 
+static int mmc_test_seq_read_perf(struct mmc_test_card *test, unsigned long sz)
+{
+	unsigned int dev_addr, i, cnt;
+	struct timespec ts1, ts2;
+	int ret;
+
+	cnt = test->area.max_sz / sz;
+	dev_addr = test->area.dev_addr;
+	getnstimeofday(&ts1);
+	for (i = 0; i < cnt; i++) {
+		ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 0);
+		if (ret)
+			return ret;
+		dev_addr += (sz >> 9);
+	}
+	getnstimeofday(&ts2);
+	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+	return 0;
+}
+
 /*
  * Consecutive read performance by transfer size.
  */
 static int mmc_test_profile_seq_read_perf(struct mmc_test_card *test)
 {
 	unsigned long sz;
+	int ret;
+
+	for (sz = 512; sz < test->area.max_tfr; sz <<= 1) {
+		ret = mmc_test_seq_read_perf(test, sz);
+		if (ret)
+			return ret;
+	}
+	sz = test->area.max_tfr;
+	return mmc_test_seq_read_perf(test, sz);
+}
+
+static int mmc_test_seq_write_perf(struct mmc_test_card *test, unsigned long sz)
+{
 	unsigned int dev_addr, i, cnt;
 	struct timespec ts1, ts2;
 	int ret;
 
-	for (sz = 512; sz <= test->area.max_sz; sz <<= 1) {
-		cnt = test->area.max_sz / sz;
-		dev_addr = test->area.dev_addr;
-		getnstimeofday(&ts1);
-		for (i = 0; i < cnt; i++) {
-			ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 0);
-			if (ret)
-				return ret;
-			dev_addr += (sz >> 9);
-		}
-		getnstimeofday(&ts2);
-		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+	ret = mmc_test_area_erase(test);
+	if (ret)
+		return ret;
+	cnt = test->area.max_sz / sz;
+	dev_addr = test->area.dev_addr;
+	getnstimeofday(&ts1);
+	for (i = 0; i < cnt; i++) {
+		ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 0);
+		if (ret)
+			return ret;
+		dev_addr += (sz >> 9);
 	}
+	getnstimeofday(&ts2);
+	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
 	return 0;
 }
 
@@ -1548,27 +1647,15 @@ static int mmc_test_profile_seq_read_perf(struct mmc_test_card *test)
 static int mmc_test_profile_seq_write_perf(struct mmc_test_card *test)
 {
 	unsigned long sz;
-	unsigned int dev_addr, i, cnt;
-	struct timespec ts1, ts2;
 	int ret;
 
-	for (sz = 512; sz <= test->area.max_sz; sz <<= 1) {
-		ret = mmc_test_area_erase(test);
+	for (sz = 512; sz < test->area.max_tfr; sz <<= 1) {
+		ret = mmc_test_seq_write_perf(test, sz);
 		if (ret)
 			return ret;
-		cnt = test->area.max_sz / sz;
-		dev_addr = test->area.dev_addr;
-		getnstimeofday(&ts1);
-		for (i = 0; i < cnt; i++) {
-			ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 0);
-			if (ret)
-				return ret;
-			dev_addr += (sz >> 9);
-		}
-		getnstimeofday(&ts2);
-		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
 	}
-	return 0;
+	sz = test->area.max_tfr;
+	return mmc_test_seq_write_perf(test, sz);
 }
 
 /*
-- 
1.6.3.3
