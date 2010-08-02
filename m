From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] mmc_test: Fix large memory allocation
Date: Mon, 02 Aug 2010 11:17:11 +0300
Message-ID: <4C567F07.2070809@nokia.com>
References: <4C49601B.5070900@nokia.com> <20100726155234.3aca5a83.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50996 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab0HBIRW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2010 04:17:22 -0400
In-Reply-To: <20100726155234.3aca5a83.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>From 665c12a94bd66a96adfad0b83deb6c6a72fb60e9 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 2 Aug 2010 11:15:17 +0300
Subject: [PATCH] mmc_test: Fix large memory allocation

- Fix mmc_test_alloc_mem.
- Use nr_free_buffer_pages() instead of sysinfo.totalram to
determine total lowmem pages.
- Change variables containing memory sizes to unsigned long.
- Limit maximum test area size to 128MiB because that is the
maximum MMC high capacity erase size (the maxmium SD allocation
unit size is just 4MiB)

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/mmc_test.c |   76 ++++++++++++++++++++++++++----------------
 1 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 197f387..5dd8576 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include <linux/scatterlist.h>
+#include <linux/swap.h>		/* For nr_free_buffer_pages() */
 
 #define RESULT_OK		0
 #define RESULT_FAIL		1
@@ -25,6 +26,12 @@
 #define BUFFER_ORDER		2
 #define BUFFER_SIZE		(PAGE_SIZE << BUFFER_ORDER)
 
+/*
+ * Limit the test area size to the maximum MMC HC erase group size.  Note that
+ * the maximum SD allocation unit size is just 4MiB.
+ */
+#define TEST_AREA_MAX_SIZE (128 * 1024 * 1024)
+
 /**
  * struct mmc_test_pages - pages allocated by 'alloc_pages()'.
  * @page: first page in the allocation
@@ -47,8 +54,8 @@ struct mmc_test_mem {
 
 /**
  * struct mmc_test_area - information for performance tests.
- * @dev_addr: address on card at which to do performance tests
  * @max_sz: test area size (in bytes)
+ * @dev_addr: address on card at which to do performance tests
  * @max_segs: maximum segments in scatterlist @sg
  * @blocks: number of (512 byte) blocks currently mapped by @sg
  * @sg_len: length of currently mapped scatterlist @sg
@@ -56,8 +63,8 @@ struct mmc_test_mem {
  * @sg: scatterlist
  */
 struct mmc_test_area {
+	unsigned long max_sz;
 	unsigned int dev_addr;
-	unsigned int max_sz;
 	unsigned int max_segs;
 	unsigned int blocks;
 	unsigned int sg_len;
@@ -238,20 +245,19 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
 
 /*
  * Allocate a lot of memory, preferrably max_sz but at least min_sz.  In case
- * there isn't much memory do not exceed 1/16th total RAM.
+ * there isn't much memory do not exceed 1/16th total lowmem pages.
  */
-static struct mmc_test_mem *mmc_test_alloc_mem(unsigned int min_sz,
-					       unsigned int max_sz)
+static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
+					       unsigned long max_sz)
 {
-	unsigned int max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
-	unsigned int min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
-	unsigned int page_cnt = 0;
+	unsigned long max_page_cnt = DIV_ROUND_UP(max_sz, PAGE_SIZE);
+	unsigned long min_page_cnt = DIV_ROUND_UP(min_sz, PAGE_SIZE);
+	unsigned long page_cnt = 0;
+	unsigned long limit = nr_free_buffer_pages() >> 4;
 	struct mmc_test_mem *mem;
-	struct sysinfo si;
 
-	si_meminfo(&si);
-	if (max_page_cnt > si.totalram >> 4)
-		max_page_cnt = si.totalram >> 4;
+	if (max_page_cnt > limit)
+		max_page_cnt = limit;
 	if (max_page_cnt < min_page_cnt)
 		max_page_cnt = min_page_cnt;
 
@@ -270,7 +276,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned int min_sz,
 		gfp_t flags = GFP_KERNEL | GFP_DMA | __GFP_NOWARN |
 				__GFP_NORETRY;
 
-		order = get_order(page_cnt << PAGE_SHIFT);
+		order = get_order(max_page_cnt << PAGE_SHIFT);
 		while (1) {
 			page = alloc_pages(flags, order);
 			if (page || !order)
@@ -285,8 +291,10 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned int min_sz,
 		mem->arr[mem->cnt].page = page;
 		mem->arr[mem->cnt].order = order;
 		mem->cnt += 1;
-		max_page_cnt -= 1 << order;
-		page_cnt += 1 << order;
+		if (max_page_cnt <= (1UL << order))
+			break;
+		max_page_cnt -= 1UL << order;
+		page_cnt += 1UL << order;
 	}
 
 	return mem;
@@ -300,7 +308,7 @@ out_free:
  * Map memory into a scatterlist.  Optionally allow the same memory to be
  * mapped more than once.
  */
-static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned int sz,
+static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long sz,
 			   struct scatterlist *sglist, int repeat,
 			   unsigned int max_segs, unsigned int *sg_len)
 {
@@ -312,7 +320,7 @@ static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned int sz,
 	*sg_len = 0;
 	do {
 		for (i = 0; i < mem->cnt; i++) {
-			unsigned int len = PAGE_SIZE << mem->arr[i].order;
+			unsigned long len = PAGE_SIZE << mem->arr[i].order;
 
 			if (sz < len)
 				len = sz;
@@ -344,13 +352,14 @@ static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned int sz,
  * same memory to be mapped more than once.
  */
 static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
-				       unsigned int sz,
+				       unsigned long sz,
 				       struct scatterlist *sglist,
 				       unsigned int max_segs,
 				       unsigned int *sg_len)
 {
 	struct scatterlist *sg = NULL;
-	unsigned int i = mem->cnt, cnt, len;
+	unsigned int i = mem->cnt, cnt;
+	unsigned long len;
 	void *base, *addr, *last_addr = NULL;
 
 	sg_init_table(sglist, max_segs);
@@ -1202,7 +1211,7 @@ static int mmc_test_no_highmem(struct mmc_test_card *test)
 /*
  * Map sz bytes so that it can be transferred.
  */
-static int mmc_test_area_map(struct mmc_test_card *test, unsigned int sz,
+static int mmc_test_area_map(struct mmc_test_card *test, unsigned long sz,
 			     int max_scatter)
 {
 	struct mmc_test_area *t = &test->area;
@@ -1233,7 +1242,7 @@ static int mmc_test_area_transfer(struct mmc_test_card *test,
 /*
  * Map and transfer bytes.
  */
-static int mmc_test_area_io(struct mmc_test_card *test, unsigned int sz,
+static int mmc_test_area_io(struct mmc_test_card *test, unsigned long sz,
 			    unsigned int dev_addr, int write, int max_scatter,
 			    int timed)
 {
@@ -1308,19 +1317,22 @@ static int mmc_test_area_cleanup(struct mmc_test_card *test)
 static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 {
 	struct mmc_test_area *t = &test->area;
-	unsigned int min_sz = 64 * 1024;
+	unsigned long min_sz = 64 * 1024;
 	int ret;
 
 	ret = mmc_test_set_blksize(test, 512);
 	if (ret)
 		return ret;
 
+	if (test->card->pref_erase > TEST_AREA_MAX_SIZE >> 9)
+		t->max_sz = TEST_AREA_MAX_SIZE;
+	else
+		t->max_sz = (unsigned long)test->card->pref_erase << 9;
 	/*
 	 * Try to allocate enough memory for the whole area.  Less is OK
 	 * because the same memory can be mapped into the scatterlist more than
 	 * once.
 	 */
-	t->max_sz = test->card->pref_erase << 9;
 	t->mem = mmc_test_alloc_mem(min_sz, t->max_sz);
 	if (!t->mem)
 		return -ENOMEM;
@@ -1430,7 +1442,8 @@ static int mmc_test_best_write_perf_max_scatter(struct mmc_test_card *test)
  */
 static int mmc_test_profile_read_perf(struct mmc_test_card *test)
 {
-	unsigned int sz, dev_addr;
+	unsigned long sz;
+	unsigned int dev_addr;
 	int ret;
 
 	for (sz = 512; sz < test->area.max_sz; sz <<= 1) {
@@ -1448,7 +1461,8 @@ static int mmc_test_profile_read_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_write_perf(struct mmc_test_card *test)
 {
-	unsigned int sz, dev_addr;
+	unsigned long sz;
+	unsigned int dev_addr;
 	int ret;
 
 	ret = mmc_test_area_erase(test);
@@ -1472,7 +1486,8 @@ static int mmc_test_profile_write_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 {
-	unsigned int sz, dev_addr;
+	unsigned long sz;
+	unsigned int dev_addr;
 	struct timespec ts1, ts2;
 	int ret;
 
@@ -1506,7 +1521,8 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_seq_read_perf(struct mmc_test_card *test)
 {
-	unsigned int sz, dev_addr, i, cnt;
+	unsigned long sz;
+	unsigned int dev_addr, i, cnt;
 	struct timespec ts1, ts2;
 	int ret;
 
@@ -1531,7 +1547,8 @@ static int mmc_test_profile_seq_read_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_seq_write_perf(struct mmc_test_card *test)
 {
-	unsigned int sz, dev_addr, i, cnt;
+	unsigned long sz;
+	unsigned int dev_addr, i, cnt;
 	struct timespec ts1, ts2;
 	int ret;
 
@@ -1559,7 +1576,8 @@ static int mmc_test_profile_seq_write_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 {
-	unsigned int sz, dev_addr, i, cnt;
+	unsigned long sz;
+	unsigned int dev_addr, i, cnt;
 	struct timespec ts1, ts2;
 	int ret;
 
-- 
1.6.3.3
