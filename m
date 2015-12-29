From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] mmc-core: One check less in mmc_select_hs200() after error
 detection
Date: Tue, 29 Dec 2015 20:50:17 +0100
Message-ID: <5682E3F9.4040006@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:59650 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbbL2TuV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Dec 2015 14:50:21 -0500
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 29 Dec 2015 20:28:46 +0100

This issue was detected by using the Coccinelle software.

Move the jump label directly before the desired log statement
so that the variable "err" will not be checked once more
after it was determined that a call of the function
"__mmc_set_signal_voltage" or "__mmc_switch" failed.
Use the identifier "report_failure" instead of the label "err".

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/mmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 549c56e..866f72b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1256,7 +1256,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	/* If fails try again during next card power cycle */
 	if (err)
-		goto err;
+		goto report_failure;
 
 	mmc_select_driver_type(card);
 
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 				   card->ext_csd.generic_cmd6_time,
 				   true, send_status, true);
 		if (err)
-			goto err;
+			goto report_failure;
 		old_timing = host->ios.timing;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 		if (!send_status) {
@@ -1289,10 +1289,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 				mmc_set_timing(host, old_timing);
 		}
 	}
-err:
-	if (err)
+	if (err) {
+report_failure:
 		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
 		       __func__, err);
+	}
 	return err;
 }
 
-- 
2.6.3

