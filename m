From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH V5 1/3] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date: Sat, 21 Apr 2018 00:37:26 +0800
Message-ID: <20180420163726.17036-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

When use eMMC as boot device, the eMMC signaling voltage is tied to 1.8v
fixed output voltage, bios can set o2 sd host controller PCI configuration
register 0x308 bit4 to 1 to let driver skip 3.3v signaling voltage and
direct use 1.8v singling voltage in eMMC initialize process.

Changes in V5:
	Modify code format to pass checkpatch.pl check and add a summary
	of what has changed in each version.

Changes in V4:
	Skip SDIO and SD initalization when register 0x308 bit 4 is set,
	and modify some typo.

Changes in V3:
	Rebase the patch on the mmc tree 'next' branch.

Changes in V2:
	Modify code format, and delete unused code path.

Changes in V1:
	Check PCIe register 0x308 bit 4 and skip eMMC 3.3v initialization
	process if it is set to 1.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 555970a..ba59db6a 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -3,6 +3,7 @@
  *
  * Authors: Peter Guo <peter.guo@bayhubtech.com>
  *          Adam Lee <adam.lee@canonical.com>
+ *          Ernest Zhang <ernest.zhang@bayhubtech.com>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -39,6 +40,7 @@
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
+#define O2_SD_MISC_SETTING	0x308
 #define O2_SD_CLK_SETTING	0x328
 #define O2_SD_CAP_REG2		0x330
 #define O2_SD_CAP_REG0		0x334
@@ -184,6 +186,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
 	u32 reg;
+	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
@@ -197,6 +200,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
+			ret = pci_read_config_dword(chip->pdev,
+						    O2_SD_MISC_SETTING, &reg);
+			if (ret)
+				return -EIO;
+			if (reg & (1 << 4)) {
+				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
+					mmc_hostname(host->mmc));
+				host->flags &= ~SDHCI_SIGNALING_330;
+				host->flags |= SDHCI_SIGNALING_180;
+				host->mmc->caps2 |= MMC_CAP2_NO_SD;
+				host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+			}
+		}
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
-- 
2.7.4
