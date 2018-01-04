From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] sdhci: Advertise 2.0v on SDIO host interface
Date: Thu,  4 Jan 2018 21:38:20 +0200
Message-ID: <20180104193820.1101-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:13431 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeADTjX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Jan 2018 14:39:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Intel Edison the Broadcom WiFi card, which connected to SDIO,
the host announces 1.8v signaling while card expects and moreover
SDIO spec requires it to be 2.0v.

The card announces itself as

  mmc2: new ultra high speed DDR50 SDIO card at address 0001

Introduce a quirk to advirtise 2.0v signaling on Intel Merrifield platforms
while enforcing 1.8v power choice.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 1 +
 drivers/mmc/host/sdhci.c          | 3 +++
 drivers/mmc/host/sdhci.h          | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 110c634cfb43..f1cff288e03f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -931,6 +931,7 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 		break;
 	case INTEL_MRFLD_SDIO:
+		slot->host->quirks2 |= SDHCI_QUIRK2_SDIO_ADVIRTISE_2_0_V;
 		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
 					 MMC_CAP_POWER_OFF_CARD;
 		break;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..1ff3456c1e5b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1434,6 +1434,7 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 	if (mode != MMC_POWER_OFF) {
 		switch (1 << vdd) {
 		case MMC_VDD_165_195:
+		case MMC_VDD_20_21:
 			pwr = SDHCI_POWER_180;
 			break;
 		case MMC_VDD_29_30:
@@ -3624,6 +3625,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
 		mmc->ocr_avail_sdio &= host->ocr_avail_sdio;
+	if (host->quirks2 & SDHCI_QUIRK2_SDIO_ADVIRTISE_2_0_V)
+		mmc->ocr_avail_sdio |= MMC_VDD_20_21;
 	mmc->ocr_avail_sd = ocr_avail;
 	if (host->ocr_avail_sd)
 		mmc->ocr_avail_sd &= host->ocr_avail_sd;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 54bc444c317f..72eeb3af9b9f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -437,6 +437,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
 /* Controller has CRC in 136 bit Command Response */
 #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+/* Advertise 2.0v on SDIO host */
+#define SDHCI_QUIRK2_SDIO_ADVIRTISE_2_0_V		(1<<17)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.15.1

