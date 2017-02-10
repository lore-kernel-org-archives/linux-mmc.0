From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 38/39] mmc: sdhci-pci: Move a function to avoid later forward declaration
Date: Fri, 10 Feb 2017 14:55:51 +0200
Message-ID: <1486731352-8018-39-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2315 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdBJNMB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:12:01 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Move a function to avoid having to forward declare it in a subsequent
patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 78 +++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ca7c06508dcd..5c98a7bb8ed6 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -482,6 +482,45 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
+#define SDHCI_INTEL_PWR_TIMEOUT_CNT	20
+#define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
+
+static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
+				  unsigned short vdd)
+{
+	int cntr;
+	u8 reg;
+
+	sdhci_set_power(host, mode, vdd);
+
+	if (mode == MMC_POWER_OFF)
+		return;
+
+	/*
+	 * Bus power might not enable after D3 -> D0 transition due to the
+	 * present state not yet having propagated. Retry for up to 2ms.
+	 */
+	for (cntr = 0; cntr < SDHCI_INTEL_PWR_TIMEOUT_CNT; cntr++) {
+		reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		if (reg & SDHCI_POWER_ON)
+			break;
+		udelay(SDHCI_INTEL_PWR_TIMEOUT_UDELAY);
+		reg |= SDHCI_POWER_ON;
+		sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	}
+}
+
+static const struct sdhci_ops sdhci_intel_byt_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_power		= sdhci_intel_set_power,
+	.enable_dma		= sdhci_pci_enable_dma,
+	.set_bus_width		= sdhci_pci_set_bus_width,
+	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.hw_reset		= sdhci_pci_hw_reset,
+	.select_drive_strength	= sdhci_pci_select_drive_strength,
+};
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
@@ -560,45 +599,6 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
-#define SDHCI_INTEL_PWR_TIMEOUT_CNT	20
-#define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
-
-static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
-				  unsigned short vdd)
-{
-	int cntr;
-	u8 reg;
-
-	sdhci_set_power(host, mode, vdd);
-
-	if (mode == MMC_POWER_OFF)
-		return;
-
-	/*
-	 * Bus power might not enable after D3 -> D0 transition due to the
-	 * present state not yet having propagated. Retry for up to 2ms.
-	 */
-	for (cntr = 0; cntr < SDHCI_INTEL_PWR_TIMEOUT_CNT; cntr++) {
-		reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
-		if (reg & SDHCI_POWER_ON)
-			break;
-		udelay(SDHCI_INTEL_PWR_TIMEOUT_UDELAY);
-		reg |= SDHCI_POWER_ON;
-		sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
-	}
-}
-
-static const struct sdhci_ops sdhci_intel_byt_ops = {
-	.set_clock		= sdhci_set_clock,
-	.set_power		= sdhci_intel_set_power,
-	.enable_dma		= sdhci_pci_enable_dma,
-	.set_bus_width		= sdhci_pci_set_bus_width,
-	.reset			= sdhci_reset,
-	.set_uhs_signaling	= sdhci_set_uhs_signaling,
-	.hw_reset		= sdhci_pci_hw_reset,
-	.select_drive_strength	= sdhci_pci_select_drive_strength,
-};
-
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
-- 
1.9.1

