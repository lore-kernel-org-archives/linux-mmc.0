From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 2/3] mmc_test: add tests to measure random I/O operations per second
Date: Tue,  8 Feb 2011 13:41:02 +0200
Message-ID: <1297165263-656-3-git-send-email-adrian.hunter@nokia.com>
References: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:51029 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753517Ab1BHLla (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Feb 2011 06:41:30 -0500
In-Reply-To: <1297165263-656-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

Existing performance tests measure single or sequential I/O speed.
Add two random I/O tests:
        33. Random read performance by transfer size
        34. Random write performance by transfer size

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/mmc_test.c |  139 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 128 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index ec6060c..d1aa57a 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -88,6 +88,7 @@ struct mmc_test_area {
  * @sectors: amount of sectors to check in one group
  * @ts: time values of transfer
  * @rate: calculated transfer rate
+ * @iops: I/O operations per second (times 100)
  */
 struct mmc_test_transfer_result {
 	struct list_head link;
@@ -95,6 +96,7 @@ struct mmc_test_transfer_result {
 	unsigned int sectors;
 	struct timespec ts;
 	unsigned int rate;
+	unsigned int iops;
 };
 
 /**
@@ -495,7 +497,7 @@ static unsigned int mmc_test_rate(uint64_t bytes, struct timespec *ts)
  */
 static void mmc_test_save_transfer_result(struct mmc_test_card *test,
 	unsigned int count, unsigned int sectors, struct timespec ts,
-	unsigned int rate)
+	unsigned int rate, unsigned int iops)
 {
 	struct mmc_test_transfer_result *tr;
 
@@ -510,6 +512,7 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
 	tr->sectors = sectors;
 	tr->ts = ts;
 	tr->rate = rate;
+	tr->iops = iops;
 
 	list_add_tail(&tr->link, &test->gr->tr_lst);
 }
@@ -520,20 +523,22 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
 static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
 				struct timespec *ts1, struct timespec *ts2)
 {
-	unsigned int rate, sectors = bytes >> 9;
+	unsigned int rate, iops, sectors = bytes >> 9;
 	struct timespec ts;
 
 	ts = timespec_sub(*ts2, *ts1);
 
 	rate = mmc_test_rate(bytes, &ts);
+	iops = mmc_test_rate(100, &ts); /* I/O ops per sec x 100 */
 
 	printk(KERN_INFO "%s: Transfer of %u sectors (%u%s KiB) took %lu.%09lu "
-			 "seconds (%u kB/s, %u KiB/s)\n",
+			 "seconds (%u kB/s, %u KiB/s, %u.%02u IOPS)\n",
 			 mmc_hostname(test->card->host), sectors, sectors >> 1,
 			 (sectors & 1 ? ".5" : ""), (unsigned long)ts.tv_sec,
-			 (unsigned long)ts.tv_nsec, rate / 1000, rate / 1024);
+			 (unsigned long)ts.tv_nsec, rate / 1000, rate / 1024,
+			 iops / 100, iops % 100);
 
-	mmc_test_save_transfer_result(test, 1, sectors, ts, rate);
+	mmc_test_save_transfer_result(test, 1, sectors, ts, rate, iops);
 }
 
 /*
@@ -543,22 +548,24 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
 				    unsigned int count, struct timespec *ts1,
 				    struct timespec *ts2)
 {
-	unsigned int rate, sectors = bytes >> 9;
+	unsigned int rate, iops, sectors = bytes >> 9;
 	uint64_t tot = bytes * count;
 	struct timespec ts;
 
 	ts = timespec_sub(*ts2, *ts1);
 
 	rate = mmc_test_rate(tot, &ts);
+	iops = mmc_test_rate(count * 100, &ts); /* I/O ops per sec x 100 */
 
 	printk(KERN_INFO "%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
-			 "%lu.%09lu seconds (%u kB/s, %u KiB/s)\n",
+			 "%lu.%09lu seconds (%u kB/s, %u KiB/s, "
+			 "%u.%02u IOPS)\n",
 			 mmc_hostname(test->card->host), count, sectors, count,
 			 sectors >> 1, (sectors & 1 ? ".5" : ""),
 			 (unsigned long)ts.tv_sec, (unsigned long)ts.tv_nsec,
-			 rate / 1000, rate / 1024);
+			 rate / 1000, rate / 1024, iops / 100, iops % 100);
 
-	mmc_test_save_transfer_result(test, count, sectors, ts, rate);
+	mmc_test_save_transfer_result(test, count, sectors, ts, rate, iops);
 }
 
 /*
@@ -1768,6 +1775,102 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 	return 0;
 }
 
+static unsigned int rnd_next = 1;
+
+static unsigned int mmc_test_rnd_num(unsigned int rnd_cnt)
+{
+	uint64_t r;
+
+	rnd_next = rnd_next * 1103515245 + 12345;
+	r = (rnd_next >> 16) & 0x7fff;
+	return (r * rnd_cnt) >> 15;
+}
+
+static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
+			     unsigned long sz)
+{
+	unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0, ea;
+	unsigned int ssz;
+	struct timespec ts1, ts2, ts;
+	int ret;
+
+	ssz = sz >> 9;
+
+	rnd_addr = mmc_test_capacity(test->card) / 4;
+	range1 = rnd_addr / test->card->pref_erase;
+	range2 = range1 / ssz;
+
+	getnstimeofday(&ts1);
+	for (cnt = 0; cnt < UINT_MAX; cnt++) {
+		getnstimeofday(&ts2);
+		ts = timespec_sub(ts2, ts1);
+		if (ts.tv_sec >= 10)
+			break;
+		ea = mmc_test_rnd_num(range1);
+		if (ea == last_ea)
+			ea -= 1;
+		last_ea = ea;
+		dev_addr = rnd_addr + test->card->pref_erase * ea +
+			   ssz * mmc_test_rnd_num(range2);
+		ret = mmc_test_area_io(test, sz, dev_addr, write, 0, 0);
+		if (ret)
+			return ret;
+	}
+	if (print)
+		mmc_test_print_avg_rate(test, sz, cnt, &ts1, &ts2);
+	return 0;
+}
+
+static int mmc_test_random_perf(struct mmc_test_card *test, int write)
+{
+	unsigned int next;
+	unsigned long sz;
+	int ret;
+
+	for (sz = 512; sz < test->area.max_tfr; sz <<= 1) {
+		/*
+		 * When writing, try to get more consistent results by running
+		 * the test twice with exactly the same I/O but outputting the
+		 * results only for the 2nd run.
+		 */
+		if (write) {
+			next = rnd_next;
+			ret = mmc_test_rnd_perf(test, write, 0, sz);
+			if (ret)
+				return ret;
+			rnd_next = next;
+		}
+		ret = mmc_test_rnd_perf(test, write, 1, sz);
+		if (ret)
+			return ret;
+	}
+	sz = test->area.max_tfr;
+	if (write) {
+		next = rnd_next;
+		ret = mmc_test_rnd_perf(test, write, 0, sz);
+		if (ret)
+			return ret;
+		rnd_next = next;
+	}
+	return mmc_test_rnd_perf(test, write, 1, sz);
+}
+
+/*
+ * Random read performance by transfer size.
+ */
+static int mmc_test_random_read_perf(struct mmc_test_card *test)
+{
+	return mmc_test_random_perf(test, 0);
+}
+
+/*
+ * Random write performance by transfer size.
+ */
+static int mmc_test_random_write_perf(struct mmc_test_card *test)
+{
+	return mmc_test_random_perf(test, 1);
+}
+
 static const struct mmc_test_case mmc_test_cases[] = {
 	{
 		.name = "Basic write (no data verification)",
@@ -2007,6 +2110,20 @@ static const struct mmc_test_case mmc_test_cases[] = {
 		.cleanup = mmc_test_area_cleanup,
 	},
 
+	{
+		.name = "Random read performance by transfer size",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_random_read_perf,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
+	{
+		.name = "Random write performance by transfer size",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_random_write_perf,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
 };
 
 static DEFINE_MUTEX(mmc_test_lock);
@@ -2150,11 +2267,11 @@ static int mtf_test_show(struct seq_file *sf, void *data)
 		seq_printf(sf, "Test %d: %d\n", gr->testcase + 1, gr->result);
 
 		list_for_each_entry(tr, &gr->tr_lst, link) {
-			seq_printf(sf, "%u %d %lu.%09lu %u\n",
+			seq_printf(sf, "%u %d %lu.%09lu %u %u.%02u\n",
 				tr->count, tr->sectors,
 				(unsigned long)tr->ts.tv_sec,
 				(unsigned long)tr->ts.tv_nsec,
-				tr->rate);
+				tr->rate, tr->iops / 100, tr->iops % 100);
 		}
 	}
 
-- 
1.7.0.4

