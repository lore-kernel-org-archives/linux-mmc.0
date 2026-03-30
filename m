Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com [101.71.155.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABE1E5B70;
	Mon, 30 Mar 2026 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774841342; cv=none; b=gSqVmskxSoB4Ue8rniH3cyb2KTVWuU/bQCnWBMcxh9GrdC1SokplawAbLgy9cQDYRl7Yt7+k3UW5EY3orU2EwMCNrYwm7E40ab7jh1p/JIeXvVJkDNMRG1vplPU/86OeCDDXyCzXAHL4kXxVCz5hi+YYDYqg8WrRUpipK7hutaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774841342; c=relaxed/simple;
	bh=a/qXiOrC3r7pBweKNSZ0Nrf8q4W1HTAVOZIGUZN6gvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kyq2UFNPPaHkrC+dkLmCyneUWAJDOlMxwBa6dq0IylaSQVaYcb4oYeoOEPl2d6ZqBfq0JuexoJwVK9dlYwLzx8PTog7Kf1gX8spFSDaMm49bvmK6UKBaDffsmrSToOK2Eu3zxEYXD28/xetArVysqHg21HeoeM7EZ0h/cNh4lGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dCVkJqWU; arc=none smtp.client-ip=101.71.155.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dCVkJqWU"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38c2332d1;
	Mon, 30 Mar 2026 11:28:48 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] mmc: mmc_test: Replace hard-coded values with macros and consolidate test parameters
Date: Mon, 30 Mar 2026 11:28:31 +0800
Message-Id: <1774841312-92409-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d3cc972f109cckunmd82a3513dfee6f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxDH1ZMQ0kfSB9ITEtJTUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dCVkJqWU+jZh3CsaMLoOvBqvYnMmsnSwHc+Q5dMHherZOlPdSRUKZ6rTD1XpWcUE32TvfimvnseL42eciHvPvfPhHf0zJ21lHJ1TTaFchq0evfsWz0tL9kFKHs5teMCn4A2MjCFVvr5b/mn36IaLSfOqQ8Lj9MH4YSJD7gZOFrQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=SgtCjbBznjfVBC51np7tLPNDBQwKtzfM1Zq7tzDEf5M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Replacing hard-coded values with standardized macros to improve code clarity,
simplify future maintenance.

Meanwhile, introduce global bs and sg_len arrays for block sizes and SG lengths,
eliminating redundant local definitions in multiple test functions.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/mmc_test.c | 83 ++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index f5c5428..ab38e4c 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -37,7 +37,7 @@
  * Limit the test area size to the maximum MMC HC erase group size.  Note that
  * the maximum SD allocation unit size is just 4MiB.
  */
-#define TEST_AREA_MAX_SIZE (128 * 1024 * 1024)
+#define TEST_AREA_MAX_SIZE SZ_128M
 
 /**
  * struct mmc_test_pages - pages allocated by 'alloc_pages()'.
@@ -169,6 +169,11 @@ struct mmc_test_multiple_rw {
 	enum mmc_test_prep_media prepare;
 };
 
+static unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
+			    1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
+
+static unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
+				1 << 7, 1 << 8, 1 << 9};
 /*******************************************************************/
 /*  General helper functions                                       */
 /*******************************************************************/
@@ -502,7 +507,7 @@ static unsigned int mmc_test_rate(uint64_t bytes, struct timespec64 *ts)
 	uint64_t ns;
 
 	ns = timespec64_to_ns(ts);
-	bytes *= 1000000000;
+	bytes *= NSEC_PER_SEC;
 
 	while (ns > UINT_MAX) {
 		bytes >>= 1;
@@ -548,7 +553,7 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
 static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
 				struct timespec64 *ts1, struct timespec64 *ts2)
 {
-	unsigned int rate, iops, sectors = bytes >> 9;
+	unsigned int rate, iops, sectors = bytes >> SECTOR_SHIFT;
 	struct timespec64 ts;
 
 	ts = timespec64_sub(*ts2, *ts1);
@@ -573,7 +578,7 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
 				    unsigned int count, struct timespec64 *ts1,
 				    struct timespec64 *ts2)
 {
-	unsigned int rate, iops, sectors = bytes >> 9;
+	unsigned int rate, iops, sectors = bytes >> SECTOR_SHIFT;
 	uint64_t tot = bytes * count;
 	struct timespec64 ts;
 
@@ -1374,7 +1379,7 @@ static int mmc_test_area_map(struct mmc_test_card *test, unsigned long sz,
 	int err;
 	unsigned int sg_len = 0;
 
-	t->blocks = sz >> 9;
+	t->blocks = sz >> SECTOR_SHIFT;
 
 	if (max_scatter) {
 		err = mmc_test_map_sg_max_scatter(t->mem, sz, t->sg,
@@ -1457,7 +1462,7 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
 	else
 		for (i = 0; i < count && ret == 0; i++) {
 			ret = mmc_test_area_transfer(test, dev_addr, write);
-			dev_addr += sz >> 9;
+			dev_addr += sz >> SECTOR_SHIFT;
 		}
 
 	if (ret)
@@ -1500,7 +1505,7 @@ static int mmc_test_area_erase(struct mmc_test_card *test)
 	if (!mmc_card_can_erase(test->card))
 		return 0;
 
-	return mmc_erase(test->card, t->dev_addr, t->max_sz >> 9,
+	return mmc_erase(test->card, t->dev_addr, t->max_sz >> SECTOR_SHIFT,
 			 MMC_ERASE_ARG);
 }
 
@@ -1528,7 +1533,7 @@ static int mmc_test_area_cleanup(struct mmc_test_card *test)
 static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 {
 	struct mmc_test_area *t = &test->area;
-	unsigned long min_sz = 64 * 1024, sz;
+	unsigned long min_sz = SZ_64K, sz;
 	int ret;
 
 	ret = mmc_test_set_blksize(test, 512);
@@ -1536,9 +1541,9 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 		return ret;
 
 	/* Make the test area size about 4MiB */
-	sz = (unsigned long)test->card->pref_erase << 9;
+	sz = (unsigned long)test->card->pref_erase << SECTOR_SHIFT;
 	t->max_sz = sz;
-	while (t->max_sz < 4 * 1024 * 1024)
+	while (t->max_sz < SZ_4M)
 		t->max_sz += sz;
 	while (t->max_sz > TEST_AREA_MAX_SIZE && t->max_sz > sz)
 		t->max_sz -= sz;
@@ -1548,8 +1553,8 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 	t->max_seg_sz -= t->max_seg_sz % 512;
 
 	t->max_tfr = t->max_sz;
-	if (t->max_tfr >> 9 > test->card->host->max_blk_count)
-		t->max_tfr = test->card->host->max_blk_count << 9;
+	if (t->max_tfr >> SECTOR_SHIFT > test->card->host->max_blk_count)
+		t->max_tfr = test->card->host->max_blk_count << SECTOR_SHIFT;
 	if (t->max_tfr > test->card->host->max_req_size)
 		t->max_tfr = test->card->host->max_req_size;
 	if (t->max_tfr / t->max_seg_sz > t->max_segs)
@@ -1579,7 +1584,7 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 	}
 
 	t->dev_addr = mmc_test_capacity(test->card) / 2;
-	t->dev_addr -= t->dev_addr % (t->max_sz >> 9);
+	t->dev_addr -= t->dev_addr % (t->max_sz >> SECTOR_SHIFT);
 
 	if (erase) {
 		ret = mmc_test_area_erase(test);
@@ -1684,7 +1689,7 @@ static int mmc_test_profile_read_perf(struct mmc_test_card *test)
 	int ret;
 
 	for (sz = 512; sz < t->max_tfr; sz <<= 1) {
-		dev_addr = t->dev_addr + (sz >> 9);
+		dev_addr = t->dev_addr + (sz >> SECTOR_SHIFT);
 		ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 1);
 		if (ret)
 			return ret;
@@ -1708,7 +1713,7 @@ static int mmc_test_profile_write_perf(struct mmc_test_card *test)
 	if (ret)
 		return ret;
 	for (sz = 512; sz < t->max_tfr; sz <<= 1) {
-		dev_addr = t->dev_addr + (sz >> 9);
+		dev_addr = t->dev_addr + (sz >> SECTOR_SHIFT);
 		ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 1);
 		if (ret)
 			return ret;
@@ -1739,9 +1744,9 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 		return RESULT_UNSUP_HOST;
 
 	for (sz = 512; sz < t->max_sz; sz <<= 1) {
-		dev_addr = t->dev_addr + (sz >> 9);
+		dev_addr = t->dev_addr + (sz >> SECTOR_SHIFT);
 		ktime_get_ts64(&ts1);
-		ret = mmc_erase(test->card, dev_addr, sz >> 9, MMC_TRIM_ARG);
+		ret = mmc_erase(test->card, dev_addr, sz >> SECTOR_SHIFT, MMC_TRIM_ARG);
 		if (ret)
 			return ret;
 		ktime_get_ts64(&ts2);
@@ -1749,7 +1754,7 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 	}
 	dev_addr = t->dev_addr;
 	ktime_get_ts64(&ts1);
-	ret = mmc_erase(test->card, dev_addr, sz >> 9, MMC_TRIM_ARG);
+	ret = mmc_erase(test->card, dev_addr, sz >> SECTOR_SHIFT, MMC_TRIM_ARG);
 	if (ret)
 		return ret;
 	ktime_get_ts64(&ts2);
@@ -1771,7 +1776,7 @@ static int mmc_test_seq_read_perf(struct mmc_test_card *test, unsigned long sz)
 		ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 0);
 		if (ret)
 			return ret;
-		dev_addr += (sz >> 9);
+		dev_addr += (sz >> SECTOR_SHIFT);
 	}
 	ktime_get_ts64(&ts2);
 	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
@@ -1813,7 +1818,7 @@ static int mmc_test_seq_write_perf(struct mmc_test_card *test, unsigned long sz)
 		ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 0);
 		if (ret)
 			return ret;
-		dev_addr += (sz >> 9);
+		dev_addr += (sz >> SECTOR_SHIFT);
 	}
 	ktime_get_ts64(&ts2);
 	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
@@ -1866,11 +1871,11 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 		dev_addr = t->dev_addr;
 		ktime_get_ts64(&ts1);
 		for (i = 0; i < cnt; i++) {
-			ret = mmc_erase(test->card, dev_addr, sz >> 9,
+			ret = mmc_erase(test->card, dev_addr, sz >> SECTOR_SHIFT,
 					MMC_TRIM_ARG);
 			if (ret)
 				return ret;
-			dev_addr += (sz >> 9);
+			dev_addr += (sz >> SECTOR_SHIFT);
 		}
 		ktime_get_ts64(&ts2);
 		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
@@ -1897,7 +1902,7 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
 	struct timespec64 ts1, ts2, ts;
 	int ret;
 
-	ssz = sz >> 9;
+	ssz = sz >> SECTOR_SHIFT;
 
 	rnd_addr = mmc_test_capacity(test->card) / 4;
 	range1 = rnd_addr / test->card->pref_erase;
@@ -2013,10 +2018,10 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
 			sz = max_tfr;
 	}
 
-	ssz = sz >> 9;
+	ssz = sz >> SECTOR_SHIFT;
 	dev_addr = mmc_test_capacity(test->card) / 4;
-	if (tot_sz > dev_addr << 9)
-		tot_sz = dev_addr << 9;
+	if (tot_sz > dev_addr << SECTOR_SHIFT)
+		tot_sz = dev_addr << SECTOR_SHIFT;
 	cnt = tot_sz / sz;
 	dev_addr &= 0xffff0000; /* Round to 64MiB boundary */
 
@@ -2040,17 +2045,17 @@ static int mmc_test_large_seq_perf(struct mmc_test_card *test, int write)
 	int ret, i;
 
 	for (i = 0; i < 10; i++) {
-		ret = mmc_test_seq_perf(test, write, 10 * 1024 * 1024, 1);
+		ret = mmc_test_seq_perf(test, write, 10 * SZ_1M, 1);
 		if (ret)
 			return ret;
 	}
 	for (i = 0; i < 5; i++) {
-		ret = mmc_test_seq_perf(test, write, 100 * 1024 * 1024, 1);
+		ret = mmc_test_seq_perf(test, write, 100 * SZ_1M, 1);
 		if (ret)
 			return ret;
 	}
 	for (i = 0; i < 3; i++) {
-		ret = mmc_test_seq_perf(test, write, 1000 * 1024 * 1024, 1);
+		ret = mmc_test_seq_perf(test, write, 1000 * SZ_1M, 1);
 		if (ret)
 			return ret;
 	}
@@ -2153,7 +2158,7 @@ static int mmc_test_rw_multiple_sg_len(struct mmc_test_card *test,
 	int i;
 
 	for (i = 0 ; i < rw->len && ret == 0; i++) {
-		ret = mmc_test_rw_multiple(test, rw, 512 * 1024, rw->size,
+		ret = mmc_test_rw_multiple(test, rw, SZ_512K, rw->size,
 					   rw->sg_len[i]);
 		if (ret)
 			break;
@@ -2166,8 +2171,6 @@ static int mmc_test_rw_multiple_sg_len(struct mmc_test_card *test,
  */
 static int mmc_test_profile_mult_write_blocking_perf(struct mmc_test_card *test)
 {
-	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
-			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
 	struct mmc_test_multiple_rw test_data = {
 		.bs = bs,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2185,8 +2188,6 @@ static int mmc_test_profile_mult_write_blocking_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_mult_write_nonblock_perf(struct mmc_test_card *test)
 {
-	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
-			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
 	struct mmc_test_multiple_rw test_data = {
 		.bs = bs,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2204,8 +2205,6 @@ static int mmc_test_profile_mult_write_nonblock_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_mult_read_blocking_perf(struct mmc_test_card *test)
 {
-	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
-			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
 	struct mmc_test_multiple_rw test_data = {
 		.bs = bs,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2223,8 +2222,6 @@ static int mmc_test_profile_mult_read_blocking_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_mult_read_nonblock_perf(struct mmc_test_card *test)
 {
-	unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
-			     1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
 	struct mmc_test_multiple_rw test_data = {
 		.bs = bs,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2242,8 +2239,6 @@ static int mmc_test_profile_mult_read_nonblock_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_sglen_wr_blocking_perf(struct mmc_test_card *test)
 {
-	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
-				 1 << 7, 1 << 8, 1 << 9};
 	struct mmc_test_multiple_rw test_data = {
 		.sg_len = sg_len,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2261,8 +2256,6 @@ static int mmc_test_profile_sglen_wr_blocking_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_sglen_wr_nonblock_perf(struct mmc_test_card *test)
 {
-	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
-				 1 << 7, 1 << 8, 1 << 9};
 	struct mmc_test_multiple_rw test_data = {
 		.sg_len = sg_len,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2280,8 +2273,6 @@ static int mmc_test_profile_sglen_wr_nonblock_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_sglen_r_blocking_perf(struct mmc_test_card *test)
 {
-	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
-				 1 << 7, 1 << 8, 1 << 9};
 	struct mmc_test_multiple_rw test_data = {
 		.sg_len = sg_len,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2299,8 +2290,6 @@ static int mmc_test_profile_sglen_r_blocking_perf(struct mmc_test_card *test)
  */
 static int mmc_test_profile_sglen_r_nonblock_perf(struct mmc_test_card *test)
 {
-	unsigned int sg_len[] = {1, 1 << 3, 1 << 4, 1 << 5, 1 << 6,
-				 1 << 7, 1 << 8, 1 << 9};
 	struct mmc_test_multiple_rw test_data = {
 		.sg_len = sg_len,
 		.size = TEST_AREA_MAX_SIZE,
@@ -2452,7 +2441,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	if (ret)
 		goto out_free;
 
-	if (repeat_cmd && (t->blocks + 1) << 9 > t->max_tfr)
+	if (repeat_cmd && (t->blocks + 1) << SECTOR_SHIFT > t->max_tfr)
 		pr_info("%s: %d commands completed during transfer of %u blocks\n",
 			mmc_hostname(test->card->host), count, t->blocks);
 
-- 
2.7.4

