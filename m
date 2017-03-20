From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 25/25] mmc: sdhci-pci: Move a function to avoid later forward declaration
Date: Mon, 20 Mar 2017 19:50:53 +0200
Message-ID: <1490032253-6030-26-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14086 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756347AbdCTR6s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:48 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Move a function to avoid having to forward declare it in a subsequent
patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 76 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index d9a38c53e2ba..6c0440ef54be 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -515,6 +515,44 @@ static int bxt_get_cd(struct mmc_host *mmc)
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
+};
+
 static void byt_read_dsm(struct sdhci_pci_slot *slot)
 {
 	struct intel_host *intel_host = sdhci_pci_priv(slot);
@@ -606,44 +644,6 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
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
-};
-
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
-- 
1.9.1

