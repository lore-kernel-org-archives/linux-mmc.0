From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 4/4] mmc: sdhci-pci: Fix device hang on Intel BayTrail
Date: Tue, 24 Mar 2015 15:40:40 +0200
Message-ID: <1427204440-3533-5-git-send-email-adrian.hunter@intel.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Intel Baytrail has been observed sometimes to hang
if host controllers are using DMA while deep C-states
are used. Workaround that by specifying a maximum
DMA latency that will prevent deep C-states.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 5a5b5e9..bba2956 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -330,6 +330,12 @@ static void spt_read_drive_strength(struct sdhci_host *host)
 	sdhci_pci_spt_drive_strength = 0x10 | ((val >> 12) & 0xf);
 }
 
+static void byt_set_dma_latency(struct sdhci_host *host)
+{
+	host->dma_latency = 20;
+	host->lat_cancel_delay = 275;
+}
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
@@ -338,6 +344,9 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
 	slot->hw_reset = sdhci_pci_int_hw_reset;
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_EMMC ||
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_EMMC2)
+		byt_set_dma_latency(slot->host);
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BSW_EMMC)
 		slot->host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_SPT_EMMC) {
@@ -352,6 +361,8 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_BUS_WIDTH_TEST |
 				 MMC_CAP_WAIT_WHILE_BUSY;
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SDIO)
+		byt_set_dma_latency(slot->host);
 	return 0;
 }
 
@@ -362,6 +373,8 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	slot->cd_con_id = NULL;
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
+	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
+		byt_set_dma_latency(slot->host);
 	return 0;
 }
 
-- 
1.9.1
