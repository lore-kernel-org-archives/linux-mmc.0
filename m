From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: Remove D3 delays for Intel BYT-related host controllers
Date: Fri,  6 Oct 2017 15:50:59 +0300
Message-ID: <1507294259-20438-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

The default D3 cold delay of 100 ms can cause pauses when streaming audio
from eMMC.

Intel BYT-related host controllers do not need PCI D3 delays. Although the
delays can be set to zero via an ACPI _DSM, unfortunately that is not being
used in all cases. So just set the delays to zero in the driver.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5f3f7b51299f..14ef99b6e5b7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -592,9 +592,18 @@ static void byt_read_dsm(struct sdhci_pci_slot *slot)
 	slot->chip->rpm_retune = intel_host->d3_retune;
 }
 
-static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+static void byt_common_setup(struct sdhci_pci_slot *slot)
 {
 	byt_read_dsm(slot);
+
+	/* PCI D3 delays are not needed */
+	slot->chip->pdev->d3_delay = 0;
+	slot->chip->pdev->d3cold_delay = 0;
+}
+
+static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	byt_common_setup(slot);
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
 				 MMC_CAP_CMD_DURING_TFR |
@@ -649,7 +658,7 @@ static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
 	int err;
 
-	byt_read_dsm(slot);
+	byt_common_setup(slot);
 
 	err = ni_set_max_freq(slot);
 	if (err)
@@ -662,7 +671,7 @@ static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
-	byt_read_dsm(slot);
+	byt_common_setup(slot);
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
@@ -670,7 +679,7 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 
 static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 {
-	byt_read_dsm(slot);
+	byt_common_setup(slot);
 	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
 				 MMC_CAP_AGGRESSIVE_PM | MMC_CAP_CD_WAKE;
 	slot->cd_idx = 0;
-- 
1.9.1

