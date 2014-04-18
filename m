From: Peter Guo <peter.guo@bayhubtech.com>
Subject: [PATCH 1/1] mmc: sdhci-pci-o2micro Add SeaBird SeaEagle SD3 support
Date: Fri, 18 Apr 2014 07:11:58 +0000
Message-ID: <1326159439be44efadec7d62612c3130@CO2PR04MB651.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:39741
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750987AbaDRH1W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Apr 2014 03:27:22 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Adam Lee <adam.lee@canonical.com>, Samuel Guan <samuel.guan@bayhubtech.com>

Add O2Micro/BayHubTech chip 8520 subversion B1 SD3.0 support.
Add O2Micro/BayHubTech chip 8620 and 8621 SD3.0 support
Enable Led function of 8520 chip.

Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c |   59 +++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f49666b..82954ce 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -21,6 +21,42 @@
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
 
+static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
+{
+	u32 scratch_32;
+	pci_read_config_dword(chip->pdev,
+			O2_SD_PLL_SETTING, &scratch_32);
+
+	scratch_32 &= 0x0000FFFF;
+	scratch_32 |= value;
+
+	pci_write_config_dword(chip->pdev,
+			O2_SD_PLL_SETTING, scratch_32);
+}
+static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
+{
+	int ret;
+	u32 scratch_32;
+
+	/* Set led of SD host */
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_FUNC_REG0, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(1<<13);
+	pci_write_config_dword(chip->pdev,
+			O2_SD_FUNC_REG0, scratch_32);
+
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_TEST_REG, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 |= 0x40;
+	pci_write_config_dword(chip->pdev,
+			O2_SD_TEST_REG, scratch_32);
+
+}
+
 void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
 {
 	u32 scratch_32;
@@ -215,6 +251,25 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 
 		scratch &= 0x7f;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_FUJIN2) {
+			ret = pci_read_config_dword(chip->pdev,
+						O2_SD_FUNC_REG0, &scratch_32);
+			scratch_32 = ((scratch_32 & 0xFF000000) >> 24);
+			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
+				scratch_32 = 0x2c280000;
+				o2_pci_set_baseclk(chip, scratch_32);
+				ret = pci_read_config_dword(chip->pdev,
+						O2_SD_FUNC_REG4, &scratch_32);
+				scratch_32 |= BIT(22);
+				pci_write_config_dword(chip->pdev,
+					O2_SD_FUNC_REG4, scratch_32);
+
+				pci_write_config_byte(chip->pdev,
+					O2_SD_TUNING_CTRL, 0x44);
+				break;
+			}
+		}
+		o2_pci_led_enable(chip);
 
 		/* Set timeout CLK */
 		ret = pci_read_config_dword(chip->pdev,
@@ -276,7 +331,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
 		ret = pci_read_config_dword(chip->pdev,
-					    O2_SD_FUNC_REG0, &scratch_32);
+					    O2_SD_PLL_SETTING, &scratch_32);
 
 		if ((scratch_32 & 0xff000000) == 0x01000000) {
 			scratch_32 &= 0x0000FFFF;
@@ -299,6 +354,8 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 					       O2_SD_FUNC_REG4, scratch_32);
 		}
 
+		pci_write_config_byte(chip->pdev,
+				O2_SD_TUNING_CTRL, 0x55);
 		/* Lock WP */
 		ret = pci_read_config_byte(chip->pdev,
 					   O2_SD_LOCK_WP, &scratch);
-- 
1.7.9.5

