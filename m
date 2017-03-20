From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/25] mmc: sdhci: Remove ->select_drive_strength() callback
Date: Mon, 20 Mar 2017 19:50:36 +0200
Message-ID: <1490032253-6030-9-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755752AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Drivers can use the host operation directly, so remove this now unused
callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 20 --------------------
 drivers/mmc/host/sdhci-pci.h      |  4 ----
 drivers/mmc/host/sdhci.c          | 14 --------------
 drivers/mmc/host/sdhci.h          |  4 ----
 4 files changed, 42 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 351920f4ec42..5c620206138e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -36,10 +36,6 @@
 static int sdhci_pci_enable_dma(struct sdhci_host *host);
 static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width);
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
-static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
-					   struct mmc_card *card,
-					   unsigned int max_dtr, int host_drv,
-					   int card_drv, int *drv_type);
 
 /*****************************************************************************\
  *                                                                           *
@@ -514,7 +510,6 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	.reset			= sdhci_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
-	.select_drive_strength	= sdhci_pci_select_drive_strength,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
@@ -1658,20 +1653,6 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 		slot->hw_reset(host);
 }
 
-static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
-					   struct mmc_card *card,
-					   unsigned int max_dtr, int host_drv,
-					   int card_drv, int *drv_type)
-{
-	struct sdhci_pci_slot *slot = sdhci_priv(host);
-
-	if (!slot->select_drive_strength)
-		return 0;
-
-	return slot->select_drive_strength(host, card, max_dtr, host_drv,
-					   card_drv, drv_type);
-}
-
 static const struct sdhci_ops sdhci_pci_ops = {
 	.set_clock	= sdhci_set_clock,
 	.enable_dma	= sdhci_pci_enable_dma,
@@ -1679,7 +1660,6 @@ static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
 	.reset		= sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
-	.select_drive_strength	= sdhci_pci_select_drive_strength,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index cfe519c0c990..da7b95016c6f 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -86,10 +86,6 @@ struct sdhci_pci_slot {
 	bool			cd_override_level;
 
 	void (*hw_reset)(struct sdhci_host *host);
-	int (*select_drive_strength)(struct sdhci_host *host,
-				     struct mmc_card *card,
-				     unsigned int max_dtr, int host_drv,
-				     int card_drv, int *drv_type);
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c3c7df480a66..cb235cb74948 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2176,19 +2176,6 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static int sdhci_select_drive_strength(struct mmc_card *card,
-				       unsigned int max_dtr, int host_drv,
-				       int card_drv, int *drv_type)
-{
-	struct sdhci_host *host = mmc_priv(card->host);
-
-	if (!host->ops->select_drive_strength)
-		return 0;
-
-	return host->ops->select_drive_strength(host, card, max_dtr, host_drv,
-						card_drv, drv_type);
-}
-
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
@@ -2302,7 +2289,6 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
 	.execute_tuning			= sdhci_execute_tuning,
-	.select_drive_strength		= sdhci_select_drive_strength,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
 };
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adfbc213..67772674da90 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -562,10 +562,6 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
-	int	(*select_drive_strength)(struct sdhci_host *host,
-					 struct mmc_card *card,
-					 unsigned int max_dtr, int host_drv,
-					 int card_drv, int *drv_type);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.9.1

