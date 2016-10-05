From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci-pci: Fix bus power failing to enable for some Intel controllers
Date: Wed,  5 Oct 2016 12:11:24 +0300
Message-ID: <1475658684-32312-5-git-send-email-adrian.hunter@intel.com>
References: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752488AbcJEJRH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 05:17:07 -0400
In-Reply-To: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Some Intel controllers (e.g. BXT) might fail to set bus power after a
D3 -> D0 transition due to the present state not yet having propagated.
Retry for up to 2 milliseconds.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5e11e0e3be63..1d9e00a00e9f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -32,6 +32,14 @@
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
 
+static int sdhci_pci_enable_dma(struct sdhci_host *host);
+static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width);
+static void sdhci_pci_hw_reset(struct sdhci_host *host);
+static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
+					   struct mmc_card *card,
+					   unsigned int max_dtr, int host_drv,
+					   int card_drv, int *drv_type);
+
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -390,6 +398,45 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
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
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
@@ -397,6 +444,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
 			  SDHCI_QUIRK2_STOP_WITH_TC,
+	.ops		= &sdhci_intel_byt_ops,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
@@ -405,6 +453,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_sdio_probe_slot,
+	.ops		= &sdhci_intel_byt_ops,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
@@ -415,6 +464,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 	.allow_runtime_pm = true,
 	.own_cd_for_runtime_pm = true,
 	.probe_slot	= byt_sd_probe_slot,
+	.ops		= &sdhci_intel_byt_ops,
 };
 
 /* Define Host controllers for Intel Merrifield platform */
-- 
1.9.1

