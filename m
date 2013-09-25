From: Peter Guo <peter.guo@bayhubtech.com>
Subject: [PATCH 1/2] mmc:sdhci-pci:Add O2Micor/BayHubTect PCI SD Host
Date: Wed, 25 Sep 2013 03:20:07 +0000
Message-ID: <9ac149a4448d4d99a280a37b104da1e3@BN1PR04MB091.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Bjorn Helgaas <bhelgaas@google.com>, Adrian Hunter <adrian.hunter@intel.com>, reg Kroah-Hartman <gregkh@linuxfoundation.org>, Bill Pemberton <wfp5p@virginia.edu>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Samuel Guan <samuel.guan@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

From: "peter.guo" <peter.guo@bayhubtech.com>

Add O2Micor/BayHubTect SD Host Controller PCI Devices IDs in pci_ids.h.
Apply SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 for some SD Host Controller.
Apply SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC for some SD Host Controller.
Add O2Micro/BayHubTech SD Host Controller specified Init.

Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci.c |  122 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |    5 ++
 2 files changed, 127 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d7d6bc8..2387b3e 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -364,11 +364,42 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 #define O2_SD_ADMA1		0xE2
 #define O2_SD_ADMA2		0xE7
 #define O2_SD_INF_MOD		0xF1
+#define	O2_SD_PLL_SETTING	0x304
+#define	O2_SD_CLK_SETTING	0x328
+#define	O2_SD_UHS1_CAP_SETTING	0x33C
+#define	O2_SD_VENDOR_SETTING 0x110
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
+	case PCI_DEVICE_ID_O2_8420:
+	case PCI_DEVICE_ID_O2_8421:
+	case PCI_DEVICE_ID_O2_8520:
+	case PCI_DEVICE_ID_O2_8620:
+	case PCI_DEVICE_ID_O2_8621:
+		reg = sdhci_readl(host, O2_SD_VENDOR_SETTING);
+		if (reg & 0x1)
+			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
 
 static int o2_probe(struct sdhci_pci_chip *chip)
 {
 	int ret;
 	u8 scratch;
+	u32 scratch_32;
 
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_8220:
@@ -419,6 +450,59 @@ static int o2_probe(struct sdhci_pci_chip *chip)
 			return ret;
 		scratch |= 0x80;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		break;
+
+	case PCI_DEVICE_ID_O2_8420:
+	case PCI_DEVICE_ID_O2_8421:
+	case PCI_DEVICE_ID_O2_8520:
+	case PCI_DEVICE_ID_O2_8620:
+	case PCI_DEVICE_ID_O2_8621:
+	    /* UnLock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		ret = pci_read_config_dword(chip->pdev,
+				O2_SD_PLL_SETTING, &scratch_32);
+		if (ret)
+			return ret;
+		/* Set timeout CLK */
+		ret = pci_read_config_dword(chip->pdev,
+				O2_SD_CLK_SETTING, &scratch_32);
+		if (ret)
+			return ret;
+		scratch_32 |= 0x07E00000;
+		pci_write_config_dword(chip->pdev,
+				O2_SD_CLK_SETTING, scratch_32);
+
+		ret = pci_read_config_dword(chip->pdev,
+				O2_SD_CLKREQ, &scratch_32);
+		if (ret)
+			return ret;
+		scratch_32 |= 0x3;
+		pci_write_config_dword(chip->pdev, O2_SD_CLKREQ, scratch_32);
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_8520) {
+
+			ret = pci_read_config_dword(chip->pdev,
+				O2_SD_UHS1_CAP_SETTING, &scratch_32);
+			if (ret)
+				return ret;
+			scratch_32 |= (1 << 21);
+			pci_write_config_dword(chip->pdev,
+				O2_SD_UHS1_CAP_SETTING, scratch_32);
+		}
+
+		/* Lock WP */
+		ret = pci_read_config_byte(chip->pdev,
+				O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		break;
 	}
 
 	return 0;
@@ -615,6 +699,8 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 
 static const struct sdhci_pci_fixes sdhci_o2 = {
 	.probe		= o2_probe,
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.probe_slot = o2_probe_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_jmicron = {
@@ -979,6 +1065,42 @@ static const struct pci_device_id pci_ids[] = {
 		.driver_data	= (kernel_ulong_t)&sdhci_o2,
 	},
 
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8520,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8420,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8421,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8620,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8621,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
 	},
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 97fbecd..254818d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1700,6 +1700,11 @@
 #define PCI_DEVICE_ID_O2_8221		0x8221
 #define PCI_DEVICE_ID_O2_8320		0x8320
 #define PCI_DEVICE_ID_O2_8321		0x8321
+#define PCI_DEVICE_ID_O2_8520		0x8520
+#define	PCI_DEVICE_ID_O2_8420		0x8420
+#define	PCI_DEVICE_ID_O2_8421		0x8421
+#define	PCI_DEVICE_ID_O2_8620		0x8620
+#define	PCI_DEVICE_ID_O2_8621		0x8621
 
 #define PCI_VENDOR_ID_3DFX		0x121a
 #define PCI_DEVICE_ID_3DFX_VOODOO	0x0001
-- 
1.7.9.5
