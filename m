From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 2/3] mmc: mmc: Factor out mmc_hs400_to_hs() and __mmc_hs_to_hs200()
Date: Thu, 21 Apr 2016 16:28:33 +0300
Message-ID: <1461245314-6282-3-git-send-email-adrian.hunter@intel.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12239 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbcDUNc0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2016 09:32:26 -0400
In-Reply-To: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

Factor out mmc_hs400_to_hs() and __mmc_hs_to_hs200() so they can be
re-used in a later patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a3fff994e6af..4f771c6088f7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1162,7 +1162,7 @@ int mmc_hs200_to_hs400(struct mmc_card *card)
 	return mmc_select_hs400(card);
 }
 
-int mmc_hs400_to_hs200(struct mmc_card *card)
+static int mmc_hs400_to_hs(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	bool send_status = true;
@@ -1208,6 +1208,24 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 			goto out_err;
 	}
 
+	return 0;
+
+out_err:
+	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+	       __func__, err);
+	return err;
+}
+
+static int __mmc_hs_to_hs200(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	bool send_status = true;
+	int err;
+	u8 val;
+
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		send_status = false;
+
 	/* Switch HS to HS200 */
 	val = EXT_CSD_TIMING_HS200 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1235,6 +1253,26 @@ out_err:
 	return err;
 }
 
+int mmc_hs400_to_hs200(struct mmc_card *card)
+{
+	int err;
+
+	err = mmc_hs400_to_hs(card);
+	if (err)
+		goto out_err;
+
+	err = __mmc_hs_to_hs200(card);
+	if (err)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+	       __func__, err);
+	return err;
+}
+
 static void mmc_select_driver_type(struct mmc_card *card)
 {
 	int card_drv_type, drive_strength, drv_type;
-- 
1.9.1

