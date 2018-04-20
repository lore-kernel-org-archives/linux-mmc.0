From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V5 3/3] mmc: sdhci: Add MSI interrupt support for O2 SD host
Date: Sat, 21 Apr 2018 00:39:50 +0800
Message-ID: <20180420163950.11756-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

Add MSI interrupt support if the SD host device can support MSI interrupt.

Changes in V5:
	1. Because pci_enable_msi is marked as deprecated and should not be
	used in new code, use pci_alloc_irq_vectors instead.
	2. Remove unneeded CONFIG_PCI_MSI macro check

Changes in V4:
	Enable MSI interrupt if the MSI capability bit is set in
	capability register.

Changes in V3:
	None. This patch is add in V4.

Changes in V2:
	None. This patch is add in V4.

Changes in V1:
	None. This patch is add in V4.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 96adaae..374c783 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -358,11 +358,13 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
+	struct mmc_host *mmc;
 	u32 reg;
 	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
+	mmc = host->mmc;
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
@@ -373,6 +375,28 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (pci_find_capability(chip->pdev, PCI_CAP_ID_MSI)) {
+			ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
+						    PCI_IRQ_MSI | PCI_IRQ_MSIX);
+			if (ret == 1) {
+				ret = pci_irq_vector(chip->pdev, 0);
+				if (ret >= 0) {
+					host->irq = ret;
+					pr_info("%s: use MSI irq, irq=%d\n",
+						mmc_hostname(mmc), host->irq);
+				} else {
+					pr_err("%s: failed to get device irq, err=%d\n",
+					       mmc_hostname(mmc), ret);
+				}
+			} else {
+				pr_err("%s: enable PCI MSI failed, err=%d\n",
+				       mmc_hostname(mmc), ret);
+			}
+		} else {
+			pr_info("%s: unsupport msi, use INTx irq\n",
+				mmc_hostname(mmc));
+		}
+
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
@@ -380,11 +404,11 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 				return -EIO;
 			if (reg & (1 << 4)) {
 				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
-					mmc_hostname(host->mmc));
+					mmc_hostname(mmc));
 				host->flags &= ~SDHCI_SIGNALING_330;
 				host->flags |= SDHCI_SIGNALING_180;
-				host->mmc->caps2 |= MMC_CAP2_NO_SD;
-				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+				mmc->caps2 |= MMC_CAP2_NO_SD;
+				mmc->caps2 |= MMC_CAP2_NO_SDIO;
 			}
 		}
 
-- 
2.7.4
