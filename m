From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/13] mmc: core: Simplify by adding mmc_execute_tuning()
Date: Fri,  5 Dec 2014 19:40:59 +0200
Message-ID: <1417801271-15575-2-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60352 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbaLERnT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:19 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

For each MMC, SD and SDIO there is code that
holds the clock, calls ops->execute_tuning, and
releases the clock. Simplify the code a bit by
providing a separate function to do that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 24 ++++++++++++++++++++++++
 drivers/mmc/core/core.h |  3 +++
 drivers/mmc/core/mmc.c  | 14 +-------------
 drivers/mmc/core/sd.c   | 13 ++++---------
 drivers/mmc/core/sdio.c | 14 ++++----------
 5 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9584bff..b329725 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1077,6 +1077,30 @@ void mmc_set_ungated(struct mmc_host *host)
 }
 #endif
 
+int mmc_execute_tuning(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	u32 opcode;
+	int err;
+
+	if (!host->ops->execute_tuning)
+		return 0;
+
+	if (mmc_card_mmc(card))
+		opcode = MMC_SEND_TUNING_BLOCK_HS200;
+	else
+		opcode = MMC_SEND_TUNING_BLOCK;
+
+	mmc_host_clk_hold(host);
+	err = host->ops->execute_tuning(host, opcode);
+	mmc_host_clk_release(host);
+
+	if (err)
+		pr_err("%s: tuning execution failed\n", mmc_hostname(host));
+
+	return err;
+}
+
 /*
  * Change the bus mode (open drain/push-pull) of a host.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index d76597c..1b022c9 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -82,5 +82,8 @@ void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
 
 void mmc_init_context_info(struct mmc_host *host);
+
+int mmc_execute_tuning(struct mmc_card *card);
+
 #endif
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 02ad792..c712ba7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1194,7 +1194,6 @@ EXPORT_SYMBOL(tuning_blk_pattern_8bit);
 static int mmc_hs200_tuning(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	int err = 0;
 
 	/*
 	 * Timing should be adjusted to the HS400 target
@@ -1205,18 +1204,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 		if (host->ops->prepare_hs400_tuning)
 			host->ops->prepare_hs400_tuning(host, &host->ios);
 
-	if (host->ops->execute_tuning) {
-		mmc_host_clk_hold(host);
-		err = host->ops->execute_tuning(host,
-				MMC_SEND_TUNING_BLOCK_HS200);
-		mmc_host_clk_release(host);
-
-		if (err)
-			pr_err("%s: tuning execution failed\n",
-				mmc_hostname(host));
-	}
-
-	return err;
+	return mmc_execute_tuning(card);
 }
 
 /*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d90a6de..7907544 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -660,15 +660,10 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
 	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
 	 */
-	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
-			(card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
-			 card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
-		mmc_host_clk_hold(card->host);
-		err = card->host->ops->execute_tuning(card->host,
-						      MMC_SEND_TUNING_BLOCK);
-		mmc_host_clk_release(card->host);
-	}
-
+	if (!mmc_host_is_spi(card->host) &&
+	    (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
+	     card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
+		err = mmc_execute_tuning(card);
 out:
 	kfree(status);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index fd0750b..ce6cc47 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -567,17 +567,11 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
 	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
 	 */
-	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
-			((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
-			 (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104))) {
-		mmc_host_clk_hold(card->host);
-		err = card->host->ops->execute_tuning(card->host,
-						      MMC_SEND_TUNING_BLOCK);
-		mmc_host_clk_release(card->host);
-	}
-
+	if (!mmc_host_is_spi(card->host) &&
+	    ((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
+	     (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)))
+		err = mmc_execute_tuning(card);
 out:
-
 	return err;
 }
 
-- 
1.9.1

