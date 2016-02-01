From: Abhilash Jindal <klock.android@gmail.com>
Subject: [PATCH] mmc: mmc-test: y2038, use boottime to compare time
Date: Sun, 31 Jan 2016 22:43:08 -0500
Message-ID: <1454298188-17174-1-git-send-email-klock.android@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36868 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbcBADnL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Jan 2016 22:43:11 -0500
Received: by mail-ig0-f171.google.com with SMTP id 5so2790353igt.0
        for <linux-mmc@vger.kernel.org>; Sun, 31 Jan 2016 19:43:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Abhilash Jindal <klock.android@gmail.com>

Wall time obtained from getnstimeofday gives 32 bit timeval which can only
represent time until January 2038. This patch moves to ktime_t, a 64-bit time.

Also, wall time is susceptible to sudden jumps due to user setting the time or
due to NTP.  Boot time is constantly increasing time better suited for
subtracting two timestamps.

Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
---
 drivers/mmc/card/mmc_test.c |  113 +++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 58 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 7fc9174..d04d446 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -97,7 +97,7 @@ struct mmc_test_transfer_result {
 	struct list_head link;
 	unsigned int count;
 	unsigned int sectors;
-	struct timespec ts;
+	ktime_t tm;
 	unsigned int rate;
 	unsigned int iops;
 };
@@ -487,13 +487,9 @@ static int mmc_test_map_sg_max_scatter(struct mmc_test_mem *mem,
 /*
  * Calculate transfer rate in bytes per second.
  */
-static unsigned int mmc_test_rate(uint64_t bytes, struct timespec *ts)
+static unsigned int mmc_test_rate(uint64_t bytes, ktime_t tm)
 {
-	uint64_t ns;
-
-	ns = ts->tv_sec;
-	ns *= 1000000000;
-	ns += ts->tv_nsec;
+	uint64_t ns = ktime_to_ns(tm);
 
 	bytes *= 1000000000;
 
@@ -514,7 +510,7 @@ static unsigned int mmc_test_rate(uint64_t bytes, struct timespec *ts)
  * Save transfer results for future usage
  */
 static void mmc_test_save_transfer_result(struct mmc_test_card *test,
-	unsigned int count, unsigned int sectors, struct timespec ts,
+	unsigned int count, unsigned int sectors, ktime_t tm,
 	unsigned int rate, unsigned int iops)
 {
 	struct mmc_test_transfer_result *tr;
@@ -528,7 +524,7 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
 
 	tr->count = count;
 	tr->sectors = sectors;
-	tr->ts = ts;
+	tr->tm = tm;
 	tr->rate = rate;
 	tr->iops = iops;
 
@@ -539,15 +535,14 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
  * Print the transfer rate.
  */
 static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
-				struct timespec *ts1, struct timespec *ts2)
+				ktime_t tm1, ktime_t tm2)
 {
 	unsigned int rate, iops, sectors = bytes >> 9;
-	struct timespec ts;
-
-	ts = timespec_sub(*ts2, *ts1);
+	ktime_t tm = ktime_sub(tm1, tm2);
+	struct timespec ts = ktime_to_timespec(tm);
 
-	rate = mmc_test_rate(bytes, &ts);
-	iops = mmc_test_rate(100, &ts); /* I/O ops per sec x 100 */
+	rate = mmc_test_rate(bytes, tm);
+	iops = mmc_test_rate(100, tm); /* I/O ops per sec x 100 */
 
 	pr_info("%s: Transfer of %u sectors (%u%s KiB) took %lu.%09lu "
 			 "seconds (%u kB/s, %u KiB/s, %u.%02u IOPS)\n",
@@ -556,24 +551,23 @@ static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
 			 (unsigned long)ts.tv_nsec, rate / 1000, rate / 1024,
 			 iops / 100, iops % 100);
 
-	mmc_test_save_transfer_result(test, 1, sectors, ts, rate, iops);
+	mmc_test_save_transfer_result(test, 1, sectors, tm, rate, iops);
 }
 
 /*
  * Print the average transfer rate.
  */
 static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
-				    unsigned int count, struct timespec *ts1,
-				    struct timespec *ts2)
+				    unsigned int count, ktime_t tm1,
+				    ktime_t tm2)
 {
 	unsigned int rate, iops, sectors = bytes >> 9;
 	uint64_t tot = bytes * count;
-	struct timespec ts;
-
-	ts = timespec_sub(*ts2, *ts1);
+	ktime_t tm = ktime_sub(tm2, tm1);
+	struct timespec ts = ktime_to_timespec(tm);
 
-	rate = mmc_test_rate(tot, &ts);
-	iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
+	rate = mmc_test_rate(tot, tm);
+	iops = mmc_test_rate(count * 100, tm); /* I/O ops per sec x 100 */
 
 	pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
 			 "%lu.%09lu seconds (%u kB/s, %u KiB/s, "
@@ -584,7 +578,7 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
 			 rate / 1000, rate / 1024, iops / 100, iops % 100,
 			 test->area.sg_len);
 
-	mmc_test_save_transfer_result(test, count, sectors, ts, rate, iops);
+	mmc_test_save_transfer_result(test, count, sectors, tm, rate, iops);
 }
 
 /*
@@ -1391,7 +1385,7 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
 				int max_scatter, int timed, int count,
 				bool nonblock, int min_sg_len)
 {
-	struct timespec ts1, ts2;
+	ktime_t tm1, tm2;
 	int ret = 0;
 	int i;
 	struct mmc_test_area *t = &test->area;
@@ -1417,7 +1411,7 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
 		return ret;
 
 	if (timed)
-		getnstimeofday(&ts1);
+		tm1 = ktime_get_boottime();
 	if (nonblock)
 		ret = mmc_test_nonblock_transfer(test, t->sg, t->sg_len,
 				 dev_addr, t->blocks, 512, write, count);
@@ -1431,10 +1425,10 @@ static int mmc_test_area_io_seq(struct mmc_test_card *test, unsigned long sz,
 		return ret;
 
 	if (timed)
-		getnstimeofday(&ts2);
+		tm2 = ktime_get_boottime();
 
 	if (timed)
-		mmc_test_print_avg_rate(test, sz, count, &ts1, &ts2);
+		mmc_test_print_avg_rate(test, sz, count, tm1, tm2);
 
 	return 0;
 }
@@ -1689,7 +1683,7 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 	struct mmc_test_area *t = &test->area;
 	unsigned long sz;
 	unsigned int dev_addr;
-	struct timespec ts1, ts2;
+	ktime_t tm1, tm2;
 	int ret;
 
 	if (!mmc_can_trim(test->card))
@@ -1700,20 +1694,20 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 
 	for (sz = 512; sz < t->max_sz; sz <<= 1) {
 		dev_addr = t->dev_addr + (sz >> 9);
-		getnstimeofday(&ts1);
+		tm1 = ktime_get_boottime();
 		ret = mmc_erase(test->card, dev_addr, sz >> 9, MMC_TRIM_ARG);
 		if (ret)
 			return ret;
-		getnstimeofday(&ts2);
-		mmc_test_print_rate(test, sz, &ts1, &ts2);
+		tm2 = ktime_get_boottime();
+		mmc_test_print_rate(test, sz, tm1, tm2);
 	}
 	dev_addr = t->dev_addr;
-	getnstimeofday(&ts1);
+	tm1 = ktime_get_boottime();
 	ret = mmc_erase(test->card, dev_addr, sz >> 9, MMC_TRIM_ARG);
 	if (ret)
 		return ret;
-	getnstimeofday(&ts2);
-	mmc_test_print_rate(test, sz, &ts1, &ts2);
+	tm2 = ktime_get_boottime();
+	mmc_test_print_rate(test, sz, tm1, tm2);
 	return 0;
 }
 
@@ -1721,20 +1715,20 @@ static int mmc_test_seq_read_perf(struct mmc_test_card *test, unsigned long sz)
 {
 	struct mmc_test_area *t = &test->area;
 	unsigned int dev_addr, i, cnt;
-	struct timespec ts1, ts2;
+	ktime_t tm1, tm2;
 	int ret;
 
 	cnt = t->max_sz / sz;
 	dev_addr = t->dev_addr;
-	getnstimeofday(&ts1);
+	tm1 = ktime_get_boottime();
 	for (i = 0; i < cnt; i++) {
 		ret = mmc_test_area_io(test, sz, dev_addr, 0, 0, 0);
 		if (ret)
 			return ret;
 		dev_addr += (sz >> 9);
 	}
-	getnstimeofday(&ts2);
-	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+	tm2 = ktime_get_boottime();
+	mmc_test_print_avg_rate(test, sz, cnt, tm1, tm2);
 	return 0;
 }
 
@@ -1760,7 +1754,7 @@ static int mmc_test_seq_write_perf(struct mmc_test_card *test, unsigned long sz)
 {
 	struct mmc_test_area *t = &test->area;
 	unsigned int dev_addr, i, cnt;
-	struct timespec ts1, ts2;
+	ktime_t tm1, tm2;
 	int ret;
 
 	ret = mmc_test_area_erase(test);
@@ -1768,15 +1762,15 @@ static int mmc_test_seq_write_perf(struct mmc_test_card *test, unsigned long sz)
 		return ret;
 	cnt = t->max_sz / sz;
 	dev_addr = t->dev_addr;
-	getnstimeofday(&ts1);
+	tm1 = ktime_get_boottime();
 	for (i = 0; i < cnt; i++) {
 		ret = mmc_test_area_io(test, sz, dev_addr, 1, 0, 0);
 		if (ret)
 			return ret;
 		dev_addr += (sz >> 9);
 	}
-	getnstimeofday(&ts2);
-	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+	tm2 = ktime_get_boottime();
+	mmc_test_print_avg_rate(test, sz, cnt, tm1, tm2);
 	return 0;
 }
 
@@ -1806,7 +1800,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 	struct mmc_test_area *t = &test->area;
 	unsigned long sz;
 	unsigned int dev_addr, i, cnt;
-	struct timespec ts1, ts2;
+	ktime_t tm1, tm2;
 	int ret;
 
 	if (!mmc_can_trim(test->card))
@@ -1824,7 +1818,7 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 			return ret;
 		cnt = t->max_sz / sz;
 		dev_addr = t->dev_addr;
-		getnstimeofday(&ts1);
+		tm1 = ktime_get_boottime();
 		for (i = 0; i < cnt; i++) {
 			ret = mmc_erase(test->card, dev_addr, sz >> 9,
 					MMC_TRIM_ARG);
@@ -1832,8 +1826,8 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 				return ret;
 			dev_addr += (sz >> 9);
 		}
-		getnstimeofday(&ts2);
-		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+		tm2 = ktime_get_boottime();
+		mmc_test_print_avg_rate(test, sz, cnt, tm1, tm2);
 	}
 	return 0;
 }
@@ -1854,7 +1848,8 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
 {
 	unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0, ea;
 	unsigned int ssz;
-	struct timespec ts1, ts2, ts;
+	ktime_t tm1, tm2, tm;
+	struct timespec ts;
 	int ret;
 
 	ssz = sz >> 9;
@@ -1863,10 +1858,11 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
 	range1 = rnd_addr / test->card->pref_erase;
 	range2 = range1 / ssz;
 
-	getnstimeofday(&ts1);
+	tm1 = ktime_get_boottime();
 	for (cnt = 0; cnt < UINT_MAX; cnt++) {
-		getnstimeofday(&ts2);
-		ts = timespec_sub(ts2, ts1);
+		tm2 = ktime_get_boottime();
+		tm = ktime_sub(tm2, tm1);
+		ts = ktime_to_timespec(tm);
 		if (ts.tv_sec >= 10)
 			break;
 		ea = mmc_test_rnd_num(range1);
@@ -1880,7 +1876,7 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
 			return ret;
 	}
 	if (print)
-		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+		mmc_test_print_avg_rate(test, sz, cnt, tm1, tm2);
 	return 0;
 }
 
@@ -1940,7 +1936,7 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
 {
 	struct mmc_test_area *t = &test->area;
 	unsigned int dev_addr, i, cnt, sz, ssz;
-	struct timespec ts1, ts2;
+	ktime_t tm1, tm2;
 	int ret;
 
 	sz = t->max_tfr;
@@ -1967,7 +1963,7 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
 	cnt = tot_sz / sz;
 	dev_addr &= 0xffff0000; /* Round to 64MiB boundary */
 
-	getnstimeofday(&ts1);
+	tm1 = ktime_get_boottime();
 	for (i = 0; i < cnt; i++) {
 		ret = mmc_test_area_io(test, sz, dev_addr, write,
 				       max_scatter, 0);
@@ -1975,9 +1971,9 @@ static int mmc_test_seq_perf(struct mmc_test_card *test, int write,
 			return ret;
 		dev_addr += ssz;
 	}
-	getnstimeofday(&ts2);
+	tm2 = ktime_get_boottime();
 
-	mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+	mmc_test_print_avg_rate(test, sz, cnt, tm1, tm2);
 
 	return 0;
 }
@@ -2748,10 +2744,11 @@ static int mtf_test_show(struct seq_file *sf, void *data)
 		seq_printf(sf, "Test %d: %d\n", gr->testcase + 1, gr->result);
 
 		list_for_each_entry(tr, &gr->tr_lst, link) {
+			struct timespec ts = ktime_to_timespec(tr->tm);
 			seq_printf(sf, "%u %d %lu.%09lu %u %u.%02u\n",
 				tr->count, tr->sectors,
-				(unsigned long)tr->ts.tv_sec,
-				(unsigned long)tr->ts.tv_nsec,
+				(unsigned long)ts.tv_sec,
+				(unsigned long)ts.tv_nsec,
 				tr->rate, tr->iops / 100, tr->iops % 100);
 		}
 	}
-- 
1.7.9.5

