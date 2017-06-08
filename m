From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/9] mmc: core: Move mmc_flush_cache() from core.c to mmc_ops.c
Date: Thu,  8 Jun 2017 15:27:40 +0200
Message-ID: <1496928465-25004-5-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33412 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdFHN2C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:28:02 -0400
Received: by mail-lf0-f50.google.com with SMTP id a136so18052513lfa.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:28:02 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mmc_flush_cache() is a eMMC specific function, let's move it to
mmc_ops.c to make that clear.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    | 21 ---------------------
 drivers/mmc/core/mmc_ops.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index de31f30..d40697f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2729,27 +2729,6 @@ int mmc_power_restore_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_power_restore_host);
 
-/*
- * Flush the cache to the non-volatile storage.
- */
-int mmc_flush_cache(struct mmc_card *card)
-{
-	int err = 0;
-
-	if (mmc_card_mmc(card) &&
-			(card->ext_csd.cache_size > 0) &&
-			(card->ext_csd.cache_ctrl & 1)) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_FLUSH_CACHE, 1, 0);
-		if (err)
-			pr_err("%s: cache flush error %d\n",
-					mmc_hostname(card->host), err);
-	}
-
-	return err;
-}
-EXPORT_SYMBOL(mmc_flush_cache);
-
 #ifdef CONFIG_PM_SLEEP
 /* Do the card removal on suspend if card is assumed removeable
  * Do that in pm notifier while userspace isn't yet frozen, so we will be able
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 53e4da48..f79d680 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -1022,6 +1022,27 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	mmc_release_host(card->host);
 }
 
+/*
+ * Flush the cache to the non-volatile storage.
+ */
+int mmc_flush_cache(struct mmc_card *card)
+{
+	int err = 0;
+
+	if (mmc_card_mmc(card) &&
+			(card->ext_csd.cache_size > 0) &&
+			(card->ext_csd.cache_ctrl & 1)) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				EXT_CSD_FLUSH_CACHE, 1, 0);
+		if (err)
+			pr_err("%s: cache flush error %d\n",
+					mmc_hostname(card->host), err);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(mmc_flush_cache);
+
 static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
 {
 	u8 val = enable ? EXT_CSD_CMDQ_MODE_ENABLED : 0;
-- 
2.7.4

