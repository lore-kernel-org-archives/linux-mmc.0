From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/3] mmc: sdhci-pci: Fix card detect race for Intel BXT/APL
Date: Fri, 22 Jan 2016 11:45:01 +0200
Message-ID: <1453455902-3987-3-git-send-email-adrian.hunter@intel.com>
References: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39507 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbcAVJsu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jan 2016 04:48:50 -0500
In-Reply-To: <1453455902-3987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Russell King <linux@arm.linux.org.uk>

Intel BXT/APL use a card detect GPIO however the host controller
will not enable bus power unless it's card detect also reflects
the presence of a card.  Unfortunately those 2 things race which
can result in commands not starting, after which the controller
does nothing and there is a 10 second wait for the driver's
10-second timer to timeout.

That is fixed by having the driver look also at the present state
register to determine if the card is present.  Consequently, provide
a 'get_cd' sdhci host operation for BXT/APL that does that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci-pci-core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index cc851b065d0a..c92652142860 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -330,6 +330,18 @@ static void spt_read_drive_strength(struct sdhci_host *host)
 	sdhci_pci_spt_drive_strength = 0x10 | ((val >> 12) & 0xf);
 }
 
+static int bxt_get_cd(struct sdhci_host *host)
+{
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
+
+	if (!gpio_cd)
+		return 0;
+
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
+static const struct sdhci_ops bxt_ops;
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
@@ -362,6 +374,10 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	slot->cd_con_id = NULL;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD)
+		slot->host->ops = &bxt_ops;
+
 	return 0;
 }
 
@@ -1362,6 +1378,17 @@ static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
 					   card_drv, drv_type);
 }
 
+static const struct sdhci_ops bxt_ops = {
+	.set_clock	= sdhci_set_clock,
+	.enable_dma	= sdhci_pci_enable_dma,
+	.set_bus_width	= sdhci_pci_set_bus_width,
+	.reset		= sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.hw_reset		= sdhci_pci_hw_reset,
+	.select_drive_strength	= sdhci_pci_select_drive_strength,
+	.get_cd		= bxt_get_cd,
+};
+
 static const struct sdhci_ops sdhci_pci_ops = {
 	.set_clock	= sdhci_set_clock,
 	.enable_dma	= sdhci_pci_enable_dma,
-- 
1.9.1

