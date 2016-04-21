From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 1/3] mmc: mmc: Factor out mmc_hs200_to_hs()
Date: Thu, 21 Apr 2016 16:28:32 +0300
Message-ID: <1461245314-6282-2-git-send-email-adrian.hunter@intel.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12239 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbcDUNcX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2016 09:32:23 -0400
In-Reply-To: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

Factor out mmc_hs200_to_hs() so it can be re-used
in a later patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 28b477d397b1..a3fff994e6af 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1053,21 +1053,14 @@ static int mmc_switch_status(struct mmc_card *card)
 	return mmc_switch_status_error(card->host, status);
 }
 
-static int mmc_select_hs400(struct mmc_card *card)
+static int mmc_hs200_to_hs(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	bool send_status = true;
 	unsigned int max_dtr;
-	int err = 0;
+	int err;
 	u8 val;
 
-	/*
-	 * HS400 mode requires 8-bit bus width
-	 */
-	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
-	      host->ios.bus_width == MMC_BUS_WIDTH_8))
-		return 0;
-
 	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
 		send_status = false;
 
@@ -1081,11 +1074,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
 			   true, send_status, true);
-	if (err) {
-		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
-			mmc_hostname(host), err);
-		return err;
-	}
+	if (err)
+		goto out_err;
 
 	/* Set host controller to HS timing */
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
@@ -1096,6 +1086,35 @@ static int mmc_select_hs400(struct mmc_card *card)
 			goto out_err;
 	}
 
+	return 0;
+
+out_err:
+	pr_err("%s: switch to high-speed from hs200 failed, error %d\n",
+	       mmc_hostname(host), err);
+	return err;
+}
+
+static int mmc_select_hs400(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	bool send_status = true;
+	int err = 0;
+	u8 val;
+
+	/*
+	 * HS400 mode requires 8-bit bus width
+	 */
+	if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
+	      host->ios.bus_width == MMC_BUS_WIDTH_8))
+		return 0;
+
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		send_status = false;
+
+	err = mmc_hs200_to_hs(card);
+	if (err)
+		goto out_err;
+
 	/* Switch card to DDR */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
-- 
1.9.1

