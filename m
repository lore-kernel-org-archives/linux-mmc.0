From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: mmc_test: Ensure command queue is disabled for testing
Date: Fri,  1 Dec 2017 14:55:31 +0200
Message-ID: <1512132931-12380-3-git-send-email-adrian.hunter@intel.com>
References: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbdLAMzy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Dec 2017 07:55:54 -0500
In-Reply-To: <1512132931-12380-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

mmc_test disables the command queue because none of the tests use the
command queue. However the Reset Test will re-enable it, so disable it in
that case too.

Fixes: 9d4579a85c84 ("mmc: mmc_test: Disable Command Queue while mmc_test is used")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index f96bbb8014e1..ef18daeaa4cc 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2320,10 +2320,17 @@ static int mmc_test_reset(struct mmc_test_card *test)
 	int err;
 
 	err = mmc_hw_reset(host);
-	if (!err)
+	if (!err) {
+		/*
+		 * Reset will re-enable the card's command queue, but tests
+		 * expect it to be disabled.
+		 */
+		if (card->ext_csd.cmdq_en)
+			mmc_cmdq_disable(card);
 		return RESULT_OK;
-	else if (err == -EOPNOTSUPP)
+	} else if (err == -EOPNOTSUPP) {
 		return RESULT_UNSUP_HOST;
+	}
 
 	return RESULT_FAIL;
 }
-- 
1.9.1

