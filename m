From: "ernest.zhang" <ernest.zhang@bayhubtech.com>
Subject: [PATCH 1/2] mmc: sdhci: Add support for O2 eMMC HS200 mode
Date: Wed, 17 Jan 2018 09:37:34 +0800
Message-ID: <20180117013734.4120-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shirley.her@bayhubtech.com, yuxiang.wan@bayhubtech.com, xiaoguang.yu@bayhubtech.com
List-Id: linux-mmc@vger.kernel.org

when eMMC used as boot device, the eMMC signaling voltage is tied to 1.8v
fixed output voltage, bios can set o2 sd host controller PCI configuration
register 0x308 bit4 to 1 to let host controller skip try 3.3.v signaling
voltage and direct use 1.8v singling voltage in eMMC initialize process.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 555970a29c94..8855a416ffd4 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -1,8 +1,9 @@
 /*
- * Copyright (C) 2013 BayHub Technology Ltd.
+ * Copyright (C) 2018 BayHub Technology Ltd.
  *
  * Authors: Peter Guo <peter.guo@bayhubtech.com>
  *          Adam Lee <adam.lee@canonical.com>
+ *          Ernest Zhang <ernest.zhang@canonical.com>
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
@@ -53,6 +55,7 @@
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
+#define O2_SD_HW_TUNING_ENABLE	BIT(4)
 
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
 {
@@ -184,6 +187,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
 	u32 reg;
+	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
@@ -197,6 +201,20 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
+			ret = pci_read_config_dword(chip->pdev,
+						    O2_SD_MISC_SETTING, &reg);
+			if (ret)
+				return -EIO;
+			if (reg & (1 << 4)) {
+				pr_info("%s: emmc 1.8v flag is set, force 1.8v signaling voltage\n",
+				     mmc_hostname(host->mmc));
+				host->flags &= ~SDHCI_SIGNALING_330;
+				host->flags |= SDHCI_SIGNALING_180;
+			}
+		}
+
+
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
-- 
2.14.1
