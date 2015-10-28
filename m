From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: mmc: Improve reliability of mmc_select_hs400()
Date: Wed, 28 Oct 2015 14:25:43 +0200
Message-ID: <1446035143-4949-5-git-send-email-adrian.hunter@intel.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8119 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932454AbbJ1M3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2015 08:29:13 -0400
In-Reply-To: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

mmc_select_hs400() calls __mmc_switch() which checks the switch is
successful using CMD13 (SEND_STATUS).  The problem is that it does that
using the timing settings of the previous mode.  That is prone to error,
especially when switching from HS to HS400 because the timing parameters
for HS mode are tighter than the timing parameters for HS400 mode.

In the case when CMD13 polling is used (i.e. not MMC_CAP_WAIT_WHILE_BUSY)
with the switch command, it must be assumed that using different modes on
the card and host must work.

However in the case when CMD13 polling is not used
(i.e. MMC_CAP_WAIT_WHILE_BUSY) mmc_select_hs400() can be made more
reliable by setting the host to the correct timing before sending CMD13.

This patch does that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5884c79346da..3a9a79ec4343 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1056,6 +1056,7 @@ static int mmc_switch_status(struct mmc_card *card)
 static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
+	bool send_status = true;
 	unsigned int max_dtr;
 	int err = 0;
 	u8 val;
@@ -1067,6 +1068,9 @@ static int mmc_select_hs400(struct mmc_card *card)
 	      host->ios.bus_width == MMC_BUS_WIDTH_8))
 		return 0;
 
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		send_status = false;
+
 	/* Reduce frequency to HS frequency */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1077,7 +1081,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
-			   true, true, true);
+			   true, send_status, true);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1087,6 +1091,13 @@ static int mmc_select_hs400(struct mmc_card *card)
 	/* Set host controller to HS timing */
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 
+	if (!send_status) {
+		err = mmc_switch_status(card);
+		if (err)
+			goto out_err;
+	}
+
+	/* Switch card to DDR */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 EXT_CSD_DDR_BUS_WIDTH_8,
@@ -1097,22 +1108,35 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
-			   true, true, true);
+			   true, send_status, true);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
 		return err;
 	}
 
+	/* Set host controller to HS400 timing and frequency */
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
+	if (!send_status) {
+		err = mmc_switch_status(card);
+		if (err)
+			goto out_err;
+	}
+
 	return 0;
+
+out_err:
+	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+	       __func__, err);
+	return err;
 }
 
 int mmc_hs200_to_hs400(struct mmc_card *card)
-- 
1.9.1

