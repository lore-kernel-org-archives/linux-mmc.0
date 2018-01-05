From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] sdhci: Advertise 2.0v on SDIO host interface
Date: Fri,  5 Jan 2018 22:37:43 +0200
Message-ID: <20180105203743.35201-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40924 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbeAEUhq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Jan 2018 15:37:46 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
requires 2.0v, while the host, according to Intel Merrifield TRM,
supports 1.8v I/O only.

The card announces itself as

  mmc2: new ultra high speed DDR50 SDIO card at address 0001

Introduce a custom OCR mask and ->set_power() callback to override 2.0v
signaling on Intel Merrifield platforms by enforcing 1.8v power choice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- quirk free approach
 drivers/mmc/host/sdhci-pci-core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 3e4f04fd5175..029fcb19eb91 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -778,6 +778,7 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 		break;
 	case INTEL_MRFLD_SDIO:
+		slot->host->ocr_mask = MMC_VDD_20_21 | MMC_VDD_165_195;
 		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
 					 MMC_CAP_POWER_OFF_CARD;
 		break;
@@ -789,10 +790,37 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static void intel_mrfld_sdhci_set_power(struct sdhci_host *host,
+					unsigned char mode, unsigned short vdd)
+{
+	if (IS_ERR(host->mmc->supply.vmmc)) {
+		switch (1 << vdd) {
+		case MMC_VDD_20_21:
+			sdhci_set_power_noreg(host, mode, ilog2(MMC_VDD_165_195));
+			break;
+		default:
+			sdhci_set_power_noreg(host, mode, vdd);
+			break;
+		}
+	} else {
+		sdhci_set_power(host, mode, vdd);
+	}
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

