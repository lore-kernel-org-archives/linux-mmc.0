From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 1/2] mmc: core: Separate the timeout value for cache-ctrl
Date: Fri, 09 Dec 2011 17:47:17 +0900
Message-ID: <000101ccb64f$27afdc50$770f94f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Turning the cache off implies flushing cache which doesn't define
maximum timeout unlike cache-on. This patch will apply the generic
CMD6 timeout only for cache-on. Additionally the kernel message is
added for checking failure case of cache-on.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changes in v2:
    - clear the cache_ctrl flag for a failure(enabling cache)

 drivers/mmc/core/core.c |   21 ++++++++++++---------
 drivers/mmc/core/mmc.c  |   13 +++++++++++--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a2aa860..b96b5ae 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2315,6 +2315,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
 int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 {
 	struct mmc_card *card = host->card;
+	unsigned int timeout;
 	int err = 0;
 
 	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
@@ -2325,16 +2326,18 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
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
index 006e932..71cb810 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1077,14 +1077,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
+			card->ext_csd.cache_ctrl = 0;
+			err = 0;
+		} else {
+			card->ext_csd.cache_ctrl = 1;
+		}
 	}
 
 	if (!oldcard)
-- 
1.7.0.4
