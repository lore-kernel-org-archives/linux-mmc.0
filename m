From: Peter Guo <peter.guo@bayhubtech.com>
Subject: [PATCH v3] mmc:sdhci-pci: Add Support of O2Mirco/BayHubTech SD Host
Date: Mon, 28 Oct 2013 11:34:21 +0000
Message-ID: <fba4b3478c934463b45ae400fa36a480@BN1PR04MB091.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bill Pemberton <wfp5p@virginia.edu>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Samuel Guan <samuel.guan@bayhubtech.com>, Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>, Adam Lee <adam.lee@canonical.com>
List-Id: linux-mmc@vger.kernel.org

Add O2Micro/BayHubTech SD Host DeviceId 8520 support.
Add O2Micro/BayHubTech SD Host DeviceId 8420 & 8421 support.
Add O2Micro/BayHubTech SD Host DeviceID 8620 & 8621 support.
Move O2Micro/BayHubTech SD Host support code to sdhci-pci-o2micro.c

Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c |  345 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.c         |  104 +++++-----
 2 files changed, 387 insertions(+), 62 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-o2micro.c

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
new file mode 100644
index 0000000..9763884
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -0,0 +1,345 @@
+#define	O2_SD_MISC_REG5		0x64
+#define	O2_SD_LD0_CTRL		0x68
+#define	O2_SD_DEV_CTRL		0x88
+#define	O2_SD_LOCK_WP		0xD3
+#define	O2_SD_TEST_REG		0xD4
+#define	O2_SD_FUNC_REG0		0xDC
+#define O2_SD_MULTI_VCC3V	0xEE
+#define O2_SD_CLKREQ		0xEC
+#define O2_SD_CAPS		0xE0
+#define O2_SD_ADMA1		0xE2
+#define O2_SD_ADMA2		0xE7
+#define O2_SD_INF_MOD		0xF1
+#define	O2_SD_MISC_CTRL4	0xFC
+#define	O2_SD_TUNING_CTRL	0x300
+#define	O2_SD_PLL_SETTING	0x304
+#define	O2_SD_CLK_SETTING	0x328
+#define O2_SD_CAP_REG2		0x330
+#define O2_SD_CAP_REG0		0x334
+#define	O2_SD_UHS1_CAP_SETTING	0x33C
+#define	O2_SD_DELAY_CTRL	0x350
+#define	O2_SD_UHS2_L1_CTRL	0x35C
+#define	O2_SD_FUNC_REG3		0x3E0
+#define	O2_SD_FUNC_REG4		0x3E4
+
+#define	O2_SD_VENDOR_SETTING	0x110
+#define O2_SD_VENDOR_SETTING2	0x1C8
+
+
+#define	PCI_DEVICE_ID_SDS0		0x8420
+#define	PCI_DEVICE_ID_SDS1		0x8421
+#define PCI_DEVICE_ID_FUJIN2		0x8520
+#define	PCI_DEVICE_ID_SEABIRD0		0x8620
+#define	PCI_DEVICE_ID_SEABIRD1		0x8621
+
+static void o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
+{
+	u32 scratch_32;
+	int ret;
+	/* Improve write performance for SD3.0 */
+	ret = pci_read_config_dword(chip->pdev, O2_SD_DEV_CTRL, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~((1 << 12) | (1 << 13) | (1 << 14));
+	pci_write_config_dword(chip->pdev, O2_SD_DEV_CTRL, scratch_32);
+
+
+	/* Enable Link abnormal reset generating Reset */
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_MISC_REG5, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~((1 << 19) | (1 << 11));
+	scratch_32 |= (1 << 10);
+	pci_write_config_dword(chip->pdev, O2_SD_MISC_REG5, scratch_32);
+
+	/* set card power over current protection	*/
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_TEST_REG, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 |= (1 << 4);
+	pci_write_config_dword(chip->pdev, O2_SD_TEST_REG, scratch_32);
+
+
+	/* adjust the output delay for SD mode */
+	pci_write_config_dword(chip->pdev,
+			O2_SD_DELAY_CTRL, 0x00002492);
+
+	/* Set the output voltage setting of Aux 1.2v LDO */
+	ret = pci_read_config_dword(chip->pdev,
+				O2_SD_LD0_CTRL, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(3 << 12);
+	pci_write_config_dword(chip->pdev,
+			O2_SD_LD0_CTRL, scratch_32);
+
+	/* Set Max power supply capability of SD host */
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_CAP_REG0, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(0x01FE);
+	scratch_32 |= 0x00CC;
+	pci_write_config_dword(chip->pdev,
+			O2_SD_CAP_REG0, scratch_32);
+	/* Set DLL Tuning Window */
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_TUNING_CTRL, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(0x000000FF);
+	scratch_32 |= 0x00000066;
+	pci_write_config_dword(chip->pdev,
+				O2_SD_TUNING_CTRL, scratch_32);
+
+	/* Set UHS2 T_EIDLE */
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_UHS2_L1_CTRL, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(0x000000FC);
+	scratch_32 |= 0x00000084;
+	pci_write_config_dword(chip->pdev,
+			O2_SD_UHS2_L1_CTRL, scratch_32);
+
+	/* Set UHS2 Termination */
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_FUNC_REG3, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~((1 << 21) | (1 << 30));
+
+	/* Set RTD3 function disabled */
+	scratch_32 |= ((1 << 29) | (1 << 28));
+	pci_write_config_dword(chip->pdev,
+				O2_SD_FUNC_REG3, scratch_32);
+
+	/* Set L1 Entrance Timer */
+	ret = pci_read_config_dword(chip->pdev,
+				O2_SD_CAPS, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(0xf0000000);
+	scratch_32 |= 0x30000000;
+	pci_write_config_dword(chip->pdev,
+				O2_SD_CAPS, scratch_32);
+
+	ret = pci_read_config_dword(chip->pdev,
+			O2_SD_MISC_CTRL4, &scratch_32);
+	if (ret)
+		return;
+	scratch_32 &= ~(0x000f0000);
+	scratch_32 |= 0x00080000;
+	pci_write_config_dword(chip->pdev,
+			O2_SD_MISC_CTRL4, scratch_32);
+}
+
+static int o2_probe_slot(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_pci_chip	*chip;
+	struct sdhci_host	*host;
+	u32			reg;
+
+	chip = slot->chip;
+	host = slot->host;
+	switch (chip->pdev->device) {
+	case PCI_DEVICE_ID_SDS0:
+	case PCI_DEVICE_ID_SEABIRD0:
+	case PCI_DEVICE_ID_SEABIRD1:
+	case PCI_DEVICE_ID_SDS1:
+	case PCI_DEVICE_ID_FUJIN2:
+		reg = sdhci_readl(host, O2_SD_VENDOR_SETTING);
+		if (reg & 0x1)
+			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+		if (chip->pdev->device != PCI_DEVICE_ID_FUJIN2)
+			break;
+		/* set dll watch dog timer	*/
+		reg = sdhci_readl(host, O2_SD_VENDOR_SETTING2);
+		reg |= (1 << 12);
+		sdhci_writel(host, reg, O2_SD_VENDOR_SETTING2);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int o2_probe(struct sdhci_pci_chip *chip)
+{
+	int ret;
+	u8 scratch;
+	u32 scratch_32;
+
+	switch (chip->pdev->device) {
+	case PCI_DEVICE_ID_O2_8220:
+	case PCI_DEVICE_ID_O2_8221:
+	case PCI_DEVICE_ID_O2_8320:
+	case PCI_DEVICE_ID_O2_8321:
+		/* This extra setup is required due to broken ADMA. */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		/* Set Multi 3 to VCC3V# */
+		pci_write_config_byte(chip->pdev, O2_SD_MULTI_VCC3V, 0x08);
+
+		/* Disable CLK_REQ# support after media DET */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_CLKREQ, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x20;
+		pci_write_config_byte(chip->pdev, O2_SD_CLKREQ, scratch);
+
+		/* Choose capabilities, enable SDMA.  We have to write 0x01
+		 * to the capabilities register first to unlock it.
+		 */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_CAPS, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x01;
+		pci_write_config_byte(chip->pdev, O2_SD_CAPS, scratch);
+		pci_write_config_byte(chip->pdev, O2_SD_CAPS, 0x73);
+
+		/* Disable ADMA1/2 */
+		pci_write_config_byte(chip->pdev, O2_SD_ADMA1, 0x39);
+		pci_write_config_byte(chip->pdev, O2_SD_ADMA2, 0x08);
+
+		/* Disable the infinite transfer mode */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_INF_MOD, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x08;
+		pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch);
+
+		/* Lock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		break;
+	case PCI_DEVICE_ID_SDS0:
+	case PCI_DEVICE_ID_SDS1:
+	case PCI_DEVICE_ID_FUJIN2:
+	    /* UnLock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		/* Set timeout CLK */
+		ret = pci_read_config_dword(chip->pdev,
+				O2_SD_CLK_SETTING, &scratch_32);
+		if (ret)
+			return ret;
+
+		scratch_32 &= ~(0xFF00);
+		scratch_32 |= 0x07E0C800;
+		pci_write_config_dword(chip->pdev,
+			O2_SD_CLK_SETTING, scratch_32);
+
+		ret = pci_read_config_dword(chip->pdev,
+				O2_SD_CLKREQ, &scratch_32);
+		if (ret)
+			return ret;
+		scratch_32 |= 0x3;
+		pci_write_config_dword(chip->pdev, O2_SD_CLKREQ, scratch_32);
+
+		ret = pci_read_config_dword(chip->pdev,
+			O2_SD_PLL_SETTING, &scratch_32);
+		if (ret)
+			return ret;
+
+		scratch_32 &= ~(0x1F3F070E);
+		scratch_32 |= 0x18270106;
+		pci_write_config_dword(chip->pdev,
+				O2_SD_PLL_SETTING, scratch_32);
+
+		/* Disable UHS1 funciton */
+		ret = pci_read_config_dword(chip->pdev,
+				O2_SD_CAP_REG2, &scratch_32);
+		if (ret)
+			return ret;
+		scratch_32 &= ~(0xE0);
+		pci_write_config_dword(chip->pdev,
+				O2_SD_CAP_REG2, scratch_32);
+
+		if (chip->pdev->device == PCI_DEVICE_ID_FUJIN2)
+			o2_fujin2_pci_init(chip);
+
+		/* Lock WP */
+		ret = pci_read_config_byte(chip->pdev,
+				O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		break;
+	case PCI_DEVICE_ID_SEABIRD0:
+	case PCI_DEVICE_ID_SEABIRD1:
+	    /* UnLock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		ret = pci_read_config_dword(chip->pdev,
+					O2_SD_FUNC_REG0, &scratch_32);
+
+		if ((scratch_32 & 0xff000000) == 0x01000000) {
+			scratch_32 &= 0x0000FFFF;
+			scratch_32 |= 0x1F340000;
+
+			pci_write_config_dword(chip->pdev,
+				O2_SD_PLL_SETTING, scratch_32);
+		} else {
+			scratch_32 &= 0x0000FFFF;
+			scratch_32 |= 0x2c280000;
+
+			pci_write_config_dword(chip->pdev,
+				O2_SD_PLL_SETTING, scratch_32);
+
+			ret = pci_read_config_dword(chip->pdev,
+					O2_SD_FUNC_REG4, &scratch_32);
+			scratch_32 |= (1<<22);
+			pci_write_config_dword(chip->pdev,
+					O2_SD_FUNC_REG4, scratch_32);
+		}
+
+		/* Lock WP */
+		ret = pci_read_config_byte(chip->pdev,
+				O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		break;
+	}
+
+	return 0;
+}
+
+static int o2_resume(struct sdhci_pci_chip *chip)
+{
+	o2_probe(chip);
+	return 0;
+}
+
+
+static const struct sdhci_pci_fixes sdhci_o2 = {
+	.probe		= o2_probe,
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.probe_slot	= o2_probe_slot,
+	.resume		= o2_resume,
+};
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 8f75381..5313260 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -100,6 +100,8 @@ struct sdhci_pci_chip {
 	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
 };
 
+/*	Add O2Micro SD Host Support	*/
+#include "sdhci-pci-o2micro.c"
 
 /*****************************************************************************\
  *                                                                           *
@@ -393,65 +395,6 @@ static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
 #define O2_SD_ADMA2		0xE7
 #define O2_SD_INF_MOD		0xF1
 
-static int o2_probe(struct sdhci_pci_chip *chip)
-{
-	int ret;
-	u8 scratch;
-
-	switch (chip->pdev->device) {
-	case PCI_DEVICE_ID_O2_8220:
-	case PCI_DEVICE_ID_O2_8221:
-	case PCI_DEVICE_ID_O2_8320:
-	case PCI_DEVICE_ID_O2_8321:
-		/* This extra setup is required due to broken ADMA. */
-		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
-		if (ret)
-			return ret;
-		scratch &= 0x7f;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
-
-		/* Set Multi 3 to VCC3V# */
-		pci_write_config_byte(chip->pdev, O2_SD_MULTI_VCC3V, 0x08);
-
-		/* Disable CLK_REQ# support after media DET */
-		ret = pci_read_config_byte(chip->pdev, O2_SD_CLKREQ, &scratch);
-		if (ret)
-			return ret;
-		scratch |= 0x20;
-		pci_write_config_byte(chip->pdev, O2_SD_CLKREQ, scratch);
-
-		/* Choose capabilities, enable SDMA.  We have to write 0x01
-		 * to the capabilities register first to unlock it.
-		 */
-		ret = pci_read_config_byte(chip->pdev, O2_SD_CAPS, &scratch);
-		if (ret)
-			return ret;
-		scratch |= 0x01;
-		pci_write_config_byte(chip->pdev, O2_SD_CAPS, scratch);
-		pci_write_config_byte(chip->pdev, O2_SD_CAPS, 0x73);
-
-		/* Disable ADMA1/2 */
-		pci_write_config_byte(chip->pdev, O2_SD_ADMA1, 0x39);
-		pci_write_config_byte(chip->pdev, O2_SD_ADMA2, 0x08);
-
-		/* Disable the infinite transfer mode */
-		ret = pci_read_config_byte(chip->pdev, O2_SD_INF_MOD, &scratch);
-		if (ret)
-			return ret;
-		scratch |= 0x08;
-		pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch);
-
-		/* Lock WP */
-		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
-		if (ret)
-			return ret;
-		scratch |= 0x80;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
-	}
-
-	return 0;
-}
-
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 {
 	u8 scratch;
@@ -641,9 +584,6 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
-static const struct sdhci_pci_fixes sdhci_o2 = {
-	.probe		= o2_probe,
-};
 
 static const struct sdhci_pci_fixes sdhci_jmicron = {
 	.probe		= jmicron_probe,
@@ -1055,6 +995,46 @@ static const struct pci_device_id pci_ids[] = {
 		.driver_data	= (kernel_ulong_t)&sdhci_o2,
 	},
 
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_FUJIN2,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_SDS0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_SDS1,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_SEABIRD0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_SEABIRD1,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
 	},
-- 
1.7.9.5
