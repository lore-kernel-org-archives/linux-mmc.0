From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: core: Separate the timeout value for cache-ctrl
Date: Mon, 24 Oct 2011 19:10:41 +0900
Message-ID: <001a01cc9235$2f626000$8e272000$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Turning the cache off implies flushing cache which doesn't define
maximum timeout unlike cache-on. This patch will apply the generic
CMD6 timeout only for cache-on. Additionally the kernel message is
added for checking failure case of cache-on.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/core.c |   22 +++++++++++++---------
 drivers/mmc/core/mmc.c  |   10 ++++++++--
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5278ffb..65b5643 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2248,6 +2248,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
 int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 {
 	struct mmc_card *card = host->card;
+	unsigned int timeout;
 	int err = 0;

 	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
@@ -2258,16 +2259,19 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
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
index fb5bf01..6354eb3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1064,14 +1064,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
+			pr_warning("%s: Cache is supported, but enabling failed\n",
+					mmc_hostname(card->host));
+			err = 0;
+		} else
+			card->ext_csd.cache_ctrl = 1;
 	}

 	if (!oldcard)
--
1.7.0.4
