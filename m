From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/5] mmc: mmc-test: add eMMC hardware reset test
Date: Mon, 29 Aug 2011 16:42:14 +0300
Message-ID: <1314625335-11638-5-git-send-email-adrian.hunter@intel.com>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab1H2Nm3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 09:42:29 -0400
In-Reply-To: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

MMC core provides a checking function that checks if the reset
has happended.  Add a test to use that function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/mmc_test.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 2bf229a..9cdce63 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2328,6 +2328,31 @@ static int mmc_test_profile_sglen_r_nonblock_perf(struct mmc_test_card *test)
 	return mmc_test_rw_multiple_sg_len(test, &test_data);
 }
 
+/*
+ * eMMC hardware reset.
+ */
+static int mmc_test_hw_reset(struct mmc_test_card *test)
+{
+	struct mmc_card *card = test->card;
+	struct mmc_host *host = card->host;
+	int err;
+
+	err = mmc_hw_reset_check(host);
+	if (!err)
+		return RESULT_OK;
+
+	if (err == -ENOSYS)
+		return RESULT_FAIL;
+
+	if (err != -EOPNOTSUPP)
+		return err;
+
+	if (!mmc_can_reset(card))
+		return RESULT_UNSUP_CARD;
+
+	return RESULT_UNSUP_HOST;
+}
+
 static const struct mmc_test_case mmc_test_cases[] = {
 	{
 		.name = "Basic write (no data verification)",
@@ -2650,6 +2675,11 @@ static const struct mmc_test_case mmc_test_cases[] = {
 		.run = mmc_test_profile_sglen_r_nonblock_perf,
 		.cleanup = mmc_test_area_cleanup,
 	},
+
+	{
+		.name = "eMMC hardware reset",
+		.run = mmc_test_hw_reset,
+	},
 };
 
 static DEFINE_MUTEX(mmc_test_lock);
-- 
1.7.6

