From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 2/2] mmc: core: Enable MMC_CAP2_CACHE_CTRL as default
Date: Thu, 19 Dec 2013 21:04:21 +0100
Message-ID: <1387483461-6317-2-git-send-email-ulf.hansson@linaro.org>
References: <1387483461-6317-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56700 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3LSUE5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 15:04:57 -0500
Received: by mail-lb0-f180.google.com with SMTP id x18so672227lbi.25
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 12:04:56 -0800 (PST)
In-Reply-To: <1387483461-6317-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

There are no reason to why the use of a non-volatile internal eMMC
cache should be controlled by a host cap. Instead let's just enable it
if the eMMC card supports it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/core.c  |    4 ----
 drivers/mmc/core/mmc.c   |    3 +--
 include/linux/mmc/host.h |    1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index df591a9..1228a59 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2582,12 +2582,8 @@ EXPORT_SYMBOL(mmc_power_restore_host);
  */
 int mmc_flush_cache(struct mmc_card *card)
 {
-	struct mmc_host *host = card->host;
 	int err = 0;
 
-	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
-		return err;
-
 	if (mmc_card_mmc(card) &&
 			(card->ext_csd.cache_size > 0) &&
 			(card->ext_csd.cache_ctrl & 1)) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ef1cc73..7ab3e9c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1287,8 +1287,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 * If cache size is higher than 0, this indicates
 	 * the existence of cache and it can be turned on.
 	 */
-	if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
-			card->ext_csd.cache_size > 0) {
+	if (card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				EXT_CSD_CACHE_CTRL, 1,
 				card->ext_csd.generic_cmd6_time);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f539bc7..8383e3f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -264,7 +264,6 @@ struct mmc_host {
 	u32			caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
-#define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
 #define MMC_CAP2_NO_SLEEP_CMD	(1 << 4)	/* Don't allow sleep command */
-- 
1.7.9.5

