From: Peter Guo <peter.guo@bayhubtech.com>
Subject: [PATCH 1/1 v2] mmc: sdhci-pci-o2micro Add SeaBird SeaEagle SD3
 support
Date: Mon, 21 Apr 2014 07:21:57 +0000
Message-ID: <cbe772e81fc0470d9136fc08e6f8f264@CO2PR04MB651.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:41545
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750712AbaDUHWB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Apr 2014 03:22:01 -0400
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
 drivers/mmc/host/sdhci-pci-o2micro.c |   68 +++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci-o2micro.h |    6 +++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index f49666b..1c4d302 100644
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
+	/* Set led of SD host function enable	*/
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_FUNC_REG0, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~O2_SD_FREG0_LEFOFF;
+	pci_write_config_dword(chip->pdev,
+			O2_SD_FUNC_REG0, scratch_32);
+
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_TEST_REG, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 |= O2_SD_LED_ENABLE;
+	pci_write_config_dword(chip->pdev,
+			O2_SD_TEST_REG, scratch_32);
+
+}
+
 void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
 {
 	u32 scratch_32;
@@ -216,6 +252,33 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		scratch &= 0x7f;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
+		/* DevId=8520 subId= 0x11 or 0x12  Type Chip support */
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_FUJIN2) {
+			ret = pci_read_config_dword(chip->pdev,
+						O2_SD_FUNC_REG0, &scratch_32);
+			scratch_32 = ((scratch_32 & 0xFF000000) >> 24);
+			/* Check Whether subId is 0x11 or 0x12	*/
+			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
+				scratch_32 = 0x2c280000;
+				/* Set Base Clock to 208MZ	*/
+				o2_pci_set_baseclk(chip, scratch_32);
+				ret = pci_read_config_dword(chip->pdev,
+						O2_SD_FUNC_REG4, &scratch_32);
+				/* Enable Base Clk setting change	*/
+				scratch_32 |= O2_SD_FREG4_ENABLE_CLK_SET;
+				pci_write_config_dword(chip->pdev,
+					O2_SD_FUNC_REG4, scratch_32);
+
+				/* Set Tuning Window to 4	*/
+				pci_write_config_byte(chip->pdev,
+					O2_SD_TUNING_CTRL, 0x44);
+				break;
+			}
+		}
+
+		/* Enable 8520 led function	*/
+		o2_pci_led_enable(chip);
+
 		/* Set timeout CLK */
 		ret = pci_read_config_dword(chip->pdev,
 					    O2_SD_CLK_SETTING, &scratch_32);
@@ -276,7 +339,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
 		ret = pci_read_config_dword(chip->pdev,
-					    O2_SD_FUNC_REG0, &scratch_32);
+					    O2_SD_PLL_SETTING, &scratch_32);
 
 		if ((scratch_32 & 0xff000000) == 0x01000000) {
 			scratch_32 &= 0x0000FFFF;
@@ -299,6 +362,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 					       O2_SD_FUNC_REG4, scratch_32);
 		}
 
+		/* Set Tuning Windows to 5 */
+		pci_write_config_byte(chip->pdev,
+				O2_SD_TUNING_CTRL, 0x55);
 		/* Lock WP */
 		ret = pci_read_config_byte(chip->pdev,
 					   O2_SD_LOCK_WP, &scratch);
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.h b/drivers/mmc/host/sdhci-pci-o2micro.h
index dbec4c9..5331678 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.h
+++ b/drivers/mmc/host/sdhci-pci-o2micro.h
@@ -39,7 +39,11 @@
 #define O2_SD_DEV_CTRL		0x88
 #define O2_SD_LOCK_WP		0xD3
 #define O2_SD_TEST_REG		0xD4
+#define	O2_SD_LED_ENABLE	BIT(6)
+
 #define O2_SD_FUNC_REG0		0xDC
+#define O2_SD_FRGE0_LEDOFF	BIT(13)
+
 #define O2_SD_MULTI_VCC3V	0xEE
 #define O2_SD_CLKREQ		0xEC
 #define O2_SD_CAPS		0xE0
@@ -57,10 +61,12 @@
 #define O2_SD_UHS2_L1_CTRL	0x35C
 #define O2_SD_FUNC_REG3		0x3E0
 #define O2_SD_FUNC_REG4		0x3E4
+#define O2_SD_FREG4_ENABLE_CLK_SET	BIT(22)
 
 #define O2_SD_VENDOR_SETTING	0x110
 #define O2_SD_VENDOR_SETTING2	0x1C8
 
+
 extern void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip);
 
 extern int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
-- 
1.7.9.5

