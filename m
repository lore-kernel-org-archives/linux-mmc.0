From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 17/21] mmc: sdhci-pci-core: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:09:05 +0800
Message-ID: <1453871345-4011-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

This patch remove SDHCI_QUIRK_BROKEN_CARD_DETECTION and add
MMC_CAP_NEEDS_POLL for PCI_DEVICE_ID_MARVELL_88ALP01_SD

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-pci-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index cc851b0..1f6d3f6 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -101,7 +101,6 @@ static const struct sdhci_pci_fixes sdhci_ene_714 = {
 static const struct sdhci_pci_fixes sdhci_cafe = {
 	.quirks		= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
 			  SDHCI_QUIRK_NO_BUSY_IRQ |
-			  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
@@ -1612,6 +1611,10 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	host->quirks = chip->quirks;
 	host->quirks2 = chip->quirks2;
 
+	if ((chip->pdev->vendor == PCI_VENDOR_ID_MARVELL) &&
+	    (chip->pdev->device == PCI_DEVICE_ID_MARVELL_88ALP01_SD))
+	    host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	host->irq = pdev->irq;
 
 	ret = pci_request_region(pdev, bar, mmc_hostname(host->mmc));
-- 
2.3.7
