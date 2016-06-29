From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 04/54] mmc: sdhci: Tidy caps variables in sdhci_setup_host()
Date: Wed, 29 Jun 2016 16:24:17 +0300
Message-ID: <1467206707-30185-5-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbcF2N3f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:35 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In preparation for adding a function to read the capability registers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 81 ++++++++++++++++++++++++------------------------
 drivers/mmc/host/sdhci.h |  4 +--
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8ac5a9df2c01..185dbf27689e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2844,7 +2844,6 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	u32 caps[2] = {0, 0};
 	u32 max_current_caps;
 	unsigned int ocr_avail;
 	unsigned int override_timeout_clk;
@@ -2874,17 +2873,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 		       mmc_hostname(mmc), host->version);
 	}
 
-	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
-		sdhci_readl(host, SDHCI_CAPABILITIES);
-
-	if (host->version >= SDHCI_SPEC_300)
-		caps[1] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ?
-			host->caps1 :
-			sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (!(host->quirks & SDHCI_QUIRK_MISSING_CAPS)) {
+		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+		if (host->version >= SDHCI_SPEC_300)
+			host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	}
 
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
-	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
+	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
 		DBG("Controller doesn't have SDMA capability\n");
 	else
 		host->flags |= SDHCI_USE_SDMA;
@@ -2896,7 +2893,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	}
 
 	if ((host->version >= SDHCI_SPEC_200) &&
-		(caps[0] & SDHCI_CAN_DO_ADMA2))
+		(host->caps & SDHCI_CAN_DO_ADMA2))
 		host->flags |= SDHCI_USE_ADMA;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
@@ -2912,7 +2909,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
 	 * implement.
 	 */
-	if (caps[0] & SDHCI_CAN_64BIT)
+	if (host->caps & SDHCI_CAN_64BIT)
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -2988,10 +2985,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 	}
 
 	if (host->version >= SDHCI_SPEC_300)
-		host->max_clk = (caps[0] & SDHCI_CLOCK_V3_BASE_MASK)
+		host->max_clk = (host->caps & SDHCI_CLOCK_V3_BASE_MASK)
 			>> SDHCI_CLOCK_BASE_SHIFT;
 	else
-		host->max_clk = (caps[0] & SDHCI_CLOCK_BASE_MASK)
+		host->max_clk = (host->caps & SDHCI_CLOCK_BASE_MASK)
 			>> SDHCI_CLOCK_BASE_SHIFT;
 
 	host->max_clk *= 1000000;
@@ -3010,7 +3007,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * In case of Host Controller v3.00, find out whether clock
 	 * multiplier is supported.
 	 */
-	host->clk_mul = (caps[1] & SDHCI_CLOCK_MUL_MASK) >>
+	host->clk_mul = (host->caps1 & SDHCI_CLOCK_MUL_MASK) >>
 			SDHCI_CLOCK_MUL_SHIFT;
 
 	/*
@@ -3042,7 +3039,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->f_max = max_clk;
 
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
-		host->timeout_clk = (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
+		host->timeout_clk = (host->caps & SDHCI_TIMEOUT_CLK_MASK) >>
 					SDHCI_TIMEOUT_CLK_SHIFT;
 		if (host->timeout_clk == 0) {
 			if (host->ops->get_timeout_clock) {
@@ -3056,7 +3053,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 			}
 		}
 
-		if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
+		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
 			host->timeout_clk *= 1000;
 
 		if (override_timeout_clk)
@@ -3097,7 +3094,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
 		mmc->caps &= ~MMC_CAP_CMD23;
 
-	if (caps[0] & SDHCI_CAN_DO_HISPD)
+	if (host->caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
@@ -3115,9 +3112,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 		ret = regulator_enable(mmc->supply.vqmmc);
 		if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
 						    1950000))
-			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
-					SDHCI_SUPPORT_SDR50 |
-					SDHCI_SUPPORT_DDR50);
+			host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
+					 SDHCI_SUPPORT_SDR50 |
+					 SDHCI_SUPPORT_DDR50);
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
@@ -3125,28 +3122,30 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 	}
 
-	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
-		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
-		       SDHCI_SUPPORT_DDR50);
+	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
+		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+				 SDHCI_SUPPORT_DDR50);
+	}
 
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
-	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
-		       SDHCI_SUPPORT_DDR50))
+	if (host->caps1 & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+			   SDHCI_SUPPORT_DDR50))
 		mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
 
 	/* SDR104 supports also implies SDR50 support */
-	if (caps[1] & SDHCI_SUPPORT_SDR104) {
+	if (host->caps1 & SDHCI_SUPPORT_SDR104) {
 		mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
 		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
 		 * field can be promoted to support HS200.
 		 */
 		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
 			mmc->caps2 |= MMC_CAP2_HS200;
-	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
+	} else if (host->caps1 & SDHCI_SUPPORT_SDR50) {
 		mmc->caps |= MMC_CAP_UHS_SDR50;
+	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 &&
-	    (caps[1] & SDHCI_SUPPORT_HS400))
+	    (host->caps1 & SDHCI_SUPPORT_HS400))
 		mmc->caps2 |= MMC_CAP2_HS400;
 
 	if ((mmc->caps2 & MMC_CAP2_HSX00_1_2V) &&
@@ -3155,25 +3154,25 @@ int sdhci_setup_host(struct sdhci_host *host)
 					     1300000)))
 		mmc->caps2 &= ~MMC_CAP2_HSX00_1_2V;
 
-	if ((caps[1] & SDHCI_SUPPORT_DDR50) &&
-		!(host->quirks2 & SDHCI_QUIRK2_BROKEN_DDR50))
+	if ((host->caps1 & SDHCI_SUPPORT_DDR50) &&
+	    !(host->quirks2 & SDHCI_QUIRK2_BROKEN_DDR50))
 		mmc->caps |= MMC_CAP_UHS_DDR50;
 
 	/* Does the host need tuning for SDR50? */
-	if (caps[1] & SDHCI_USE_SDR50_TUNING)
+	if (host->caps1 & SDHCI_USE_SDR50_TUNING)
 		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
 
 	/* Driver Type(s) (A, C, D) supported by the host */
-	if (caps[1] & SDHCI_DRIVER_TYPE_A)
+	if (host->caps1 & SDHCI_DRIVER_TYPE_A)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
-	if (caps[1] & SDHCI_DRIVER_TYPE_C)
+	if (host->caps1 & SDHCI_DRIVER_TYPE_C)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_C;
-	if (caps[1] & SDHCI_DRIVER_TYPE_D)
+	if (host->caps1 & SDHCI_DRIVER_TYPE_D)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
 	/* Initial value for re-tuning timer count */
-	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
-			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
+	host->tuning_count = (host->caps1 & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
+			     SDHCI_RETUNING_TIMER_COUNT_SHIFT;
 
 	/*
 	 * In case Re-tuning Timer is not disabled, the actual value of
@@ -3183,7 +3182,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->tuning_count = 1 << (host->tuning_count - 1);
 
 	/* Re-tuning mode supported by the Host Controller */
-	host->tuning_mode = (caps[1] & SDHCI_RETUNING_MODE_MASK) >>
+	host->tuning_mode = (host->caps1 & SDHCI_RETUNING_MODE_MASK) >>
 			     SDHCI_RETUNING_MODE_SHIFT;
 
 	ocr_avail = 0;
@@ -3212,7 +3211,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 	}
 
-	if (caps[0] & SDHCI_CAN_VDD_330) {
+	if (host->caps & SDHCI_CAN_VDD_330) {
 		ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
 
 		mmc->max_current_330 = ((max_current_caps &
@@ -3220,7 +3219,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_330_SHIFT) *
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
-	if (caps[0] & SDHCI_CAN_VDD_300) {
+	if (host->caps & SDHCI_CAN_VDD_300) {
 		ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
 
 		mmc->max_current_300 = ((max_current_caps &
@@ -3228,7 +3227,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_300_SHIFT) *
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
-	if (caps[0] & SDHCI_CAN_VDD_180) {
+	if (host->caps & SDHCI_CAN_VDD_180) {
 		ocr_avail |= MMC_VDD_165_195;
 
 		mmc->max_current_180 = ((max_current_caps &
@@ -3315,7 +3314,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
 		mmc->max_blk_size = 2;
 	} else {
-		mmc->max_blk_size = (caps[0] & SDHCI_MAX_BLOCK_MASK) >>
+		mmc->max_blk_size = (host->caps & SDHCI_MAX_BLOCK_MASK) >>
 				SDHCI_MAX_BLOCK_SHIFT;
 		if (mmc->max_blk_size >= 3) {
 			pr_warn("%s: Invalid maximum block size, assuming 512 bytes\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 419911f107d3..8696c9365ef2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -490,8 +490,8 @@ struct sdhci_host {
 
 	struct timer_list timer;	/* Timer for timeouts */
 
-	u32 caps;		/* Alternative CAPABILITY_0 */
-	u32 caps1;		/* Alternative CAPABILITY_1 */
+	u32 caps;		/* CAPABILITY_0 */
+	u32 caps1;		/* CAPABILITY_1 */
 
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
-- 
1.9.1

