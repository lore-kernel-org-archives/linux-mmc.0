Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3iIuWm1"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC4DA6
	for <linux-mmc@vger.kernel.org>; Thu, 14 Dec 2023 01:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702544968; x=1734080968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CkJELtNy2BOKr9Z2E7tJdK9lXGtU85jGdGKOcoRv21E=;
  b=Q3iIuWm1SQhVXMywaMIU4j0qcivXZ7oVtJ0UxIux7BvkOTXf4Dlk8zZ9
   AelEcOuSlKtRh1FxTyMTkNyxpRD/yHfNTSHd25aDvPoSjMSPPBBBHoWfz
   Rd/M2cc8AUzfRMfpZqFFGXoSgqqbSGlA9U1aifyhFVP6QXcaxe7Q5J1nN
   bxQXNP8EC2jRUi9M35WXhN/9R+MWf+4ej7yhxSqmQYzHovexFcHnXq1B3
   bZb9hqSM92dOw7QGn3qI3qm0/9wZARhiZ11xkFtp1JicSejPh7CiOy7RM
   MwsuzlPdh9YCKMD7kMWmb1cgm4J04X+SgGtFj5B3GLSgx0MGDSFcfNQm2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393964696"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="393964696"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:09:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774282091"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="774282091"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.48.119])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 01:09:15 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: jorge@foundries.io,
	avri.altman@wdc.com,
	christian.loehle@arm.com,
	ricardo@foundries.io,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: mmc_test: Add re-tuning test
Date: Thu, 14 Dec 2023 11:09:02 +0200
Message-Id: <20231214090902.43628-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a test to repeatedly re-tune in between random reads.  The test is
non-destructive of data on the card and runs for 30 seconds.  The test
can be repeated to test for longer durations.

If re-tuning is not supported, the test is skipped.

Example:

  # echo 'mmc1:0001' >  /sys/bus/mmc/drivers/mmcblk/unbind
  # echo 'mmc1:0001' > /sys/bus/mmc/drivers/mmc_test/bind
  [   36.642257] mmc_test mmc1:0001: Card claimed for testing.
  # cat /sys/kernel/debug/mmc1/mmc1\:0001/testlist | grep tuning
  52:     Re-tuning reliability
  # echo 52 > /sys/kernel/debug/mmc1/mmc1\:0001/test
  [   91.522555] mmc1: Starting tests of card mmc1:0001...
  [   91.528425] mmc1: Test case 52. Re-tuning reliability...
  [  121.536682] mmc1: Result: OK
  [  121.539572] mmc1: Tests completed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_test.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 0f6a563103fd..8f7f587a0025 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -1904,7 +1904,7 @@ static unsigned int mmc_test_rnd_num(unsigned int rnd_cnt)
 }
 
 static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
-			     unsigned long sz)
+			     unsigned long sz, int secs, int force_retuning)
 {
 	unsigned int dev_addr, cnt, rnd_addr, range1, range2, last_ea = 0, ea;
 	unsigned int ssz;
@@ -1921,7 +1921,7 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
 	for (cnt = 0; cnt < UINT_MAX; cnt++) {
 		ktime_get_ts64(&ts2);
 		ts = timespec64_sub(ts2, ts1);
-		if (ts.tv_sec >= 10)
+		if (ts.tv_sec >= secs)
 			break;
 		ea = mmc_test_rnd_num(range1);
 		if (ea == last_ea)
@@ -1929,6 +1929,8 @@ static int mmc_test_rnd_perf(struct mmc_test_card *test, int write, int print,
 		last_ea = ea;
 		dev_addr = rnd_addr + test->card->pref_erase * ea +
 			   ssz * mmc_test_rnd_num(range2);
+		if (force_retuning)
+			mmc_retune_needed(test->card->host);
 		ret = mmc_test_area_io(test, sz, dev_addr, write, 0, 0);
 		if (ret)
 			return ret;
@@ -1953,24 +1955,35 @@ static int mmc_test_random_perf(struct mmc_test_card *test, int write)
 		 */
 		if (write) {
 			next = rnd_next;
-			ret = mmc_test_rnd_perf(test, write, 0, sz);
+			ret = mmc_test_rnd_perf(test, write, 0, sz, 10, 0);
 			if (ret)
 				return ret;
 			rnd_next = next;
 		}
-		ret = mmc_test_rnd_perf(test, write, 1, sz);
+		ret = mmc_test_rnd_perf(test, write, 1, sz, 10, 0);
 		if (ret)
 			return ret;
 	}
 	sz = t->max_tfr;
 	if (write) {
 		next = rnd_next;
-		ret = mmc_test_rnd_perf(test, write, 0, sz);
+		ret = mmc_test_rnd_perf(test, write, 0, sz, 10, 0);
 		if (ret)
 			return ret;
 		rnd_next = next;
 	}
-	return mmc_test_rnd_perf(test, write, 1, sz);
+	return mmc_test_rnd_perf(test, write, 1, sz, 10, 0);
+}
+
+static int mmc_test_retuning(struct mmc_test_card *test)
+{
+	if (!mmc_can_retune(test->card->host)) {
+		pr_info("%s: No retuning - test skipped\n",
+			mmc_hostname(test->card->host));
+		return RESULT_UNSUP_HOST;
+	}
+
+	return mmc_test_rnd_perf(test, 0, 0, 8192, 30, 1);
 }
 
 /*
@@ -2921,6 +2934,14 @@ static const struct mmc_test_case mmc_test_cases[] = {
 		.run = mmc_test_cmds_during_write_cmd23_nonblock,
 		.cleanup = mmc_test_area_cleanup,
 	},
+
+	{
+		.name = "Re-tuning reliability",
+		.prepare = mmc_test_area_prepare,
+		.run = mmc_test_retuning,
+		.cleanup = mmc_test_area_cleanup,
+	},
+
 };
 
 static DEFINE_MUTEX(mmc_test_lock);
-- 
2.34.1

