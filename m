From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 1/2] mmc: core: Separate the timeout value for cache-ctrl
Date: Thu, 24 Nov 2011 18:22:46 +0900
Message-ID: <1322126566-5107-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:55495 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab1KXJpV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 04:45:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>

Turning the cache off implies flushing cache which doesn't define
maximum timeout unlike cache-on. This patch will apply the generic
CMD6 timeout only for cache-on. Additionally the kernel message is
added for checking failure case of cache-on.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/core.c |   22 +++++++++++++---------
 drivers/mmc/core/mmc.c  |   12 ++++++++++--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 271efea..481b090 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2270,6 +2270,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
 int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 {
 	struct mmc_card *card = host->card;
+	unsigned int timeout;
 	int err = 0;
 
 	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
@@ -2280,16 +2281,19 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 			(card->ext_csd.cache_size > 0)) {
 		enable = !!enable;
 
-		if (card->ext_csd.cache_ctrl ^ enable)
+		if (card->ext_csd.cache_ctrl ^ enable) {
+			timeout = enable ? card->ext_csd.generic_cmd6_time : 0;
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					EXT_CSD_CACHE_CTRL, enable, 0);
-		if (err)
-			pr_err("%s: cache %s error %d\n",
-					mmc_hostname(card->host),
-					enable ? "on" : "off",
-					err);
-		else
-			card->ext_csd.cache_ctrl = enable;
+					EXT_CSD_CACHE_CTRL, enable, timeout);
+
+			if (err)
+				pr_err("%s: cache %s error %d\n",
+						mmc_hostname(card->host),
+						enable ? "on" : "off",
+						err);
+			else
+				card->ext_csd.cache_ctrl = enable;
+		}
 	}
 
 	return err;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a1223bd..1e1dda9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1066,14 +1066,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
 			card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1, 0);
+				EXT_CSD_CACHE_CTRL, 1,
+				card->ext_csd.generic_cmd6_time);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
 		/*
 		 * Only if no error, cache is turned on successfully.
 		 */
-		card->ext_csd.cache_ctrl = err ? 0 : 1;
+		if (err) {
+			pr_warning("%s: Cache is supported, "
+					"but failed to turn on (%d)\n",
+					mmc_hostname(card->host), err);
+			err = 0;
+		} else {
+			card->ext_csd.cache_ctrl = 1;
+		}
 	}
 
 	if (!oldcard)
-- 
1.7.0.4

