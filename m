From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3] sdhci: Advertise 2.0v supply on SDIO host interface
Date: Wed, 10 Jan 2018 17:32:50 +0200
Message-ID: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:22148 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965097AbeAJPcy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 10 Jan 2018 10:32:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
requires 2.0v, while the host, according to Intel Merrifield TRM,
supports 1.8v supply only.

The card announces itself as

  mmc2: new ultra high speed DDR50 SDIO card at address 0001

Introduce a custom OCR mask and ->set_power() callback to override 2.0v
supply on Intel Merrifield platforms by enforcing 1.8v power choice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- address comments given by Adrian
 drivers/mmc/host/sdhci-pci-core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 3e4f04fd5175..24c2b2504b3f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -778,6 +778,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 		break;
 	case INTEL_MRFLD_SDIO:
+		/* Advertise 2.0v for compatibility with the SDIO card's OCR */
+		slot->host->ocr_mask = MMC_VDD_20_21 | MMC_VDD_165_195;
 		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
 					 MMC_CAP_POWER_OFF_CARD;
 		break;
@@ -789,10 +791,35 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static void intel_mrfld_sdhci_set_power(struct sdhci_host *host,
+					unsigned char mode, unsigned short vdd)
+{
+	/*
+	 * Without a regulator, SDHCI does not support 2.0v but we get
+	 * here because we advertised 2.0v support for compatibility
+	 * with the SDIO card's OCR. Map it to 1.8v for the purpose of
+	 * turning on the power.
+	 */
+	if (IS_ERR(host->mmc->supply.vmmc) && vdd == ilog2(MMC_VDD_20_21))
+		vdd = ilog2(MMC_VDD_165_195);
+
+	sdhci_set_power(host, mode, vdd);
+}
+
+static const struct sdhci_ops intel_mrfld_sdhci_pci_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_power		= intel_mrfld_sdhci_set_power,
+	.enable_dma		= sdhci_pci_enable_dma,
+	.set_bus_width		= sdhci_set_bus_width,
+	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+};
+
 static const struct sdhci_pci_fixes sdhci_intel_mrfld_mmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_HS200 |
 			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.ops		= &intel_mrfld_sdhci_pci_ops,
 	.allow_runtime_pm = true,
 	.probe_slot	= intel_mrfld_mmc_probe_slot,
 };
-- 
2.15.1

