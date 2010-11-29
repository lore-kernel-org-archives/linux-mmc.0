From: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Subject: RE: FW: [PATCH 2.6.32]: Add new device IDs and registersforMULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Mon, 29 Nov 2010 10:06:18 +0800
Message-ID: <FC57104DF444434A9D1D8A7B4EBB292308145108@HC-EXCHANGE.nt-fsrvr.o2micro.com>
References: <20101127045914.GA28590@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain;charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [203.127.153.66] ([203.127.153.66]:18442 "EHLO
	sg-mxserver-01.nt-fsrvr.o2micro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753283Ab0K2CHJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 28 Nov 2010 21:07:09 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20101127045914.GA28590@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>, Rezwanul_Kabir@Dell.com, "Shirley Her (SC)" <shirley.her@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "William Lian (TP)" <William.Lian@o2micro.com>

Hi Chris,

1. We don't need disable ADMA on the 8120 device. For safety, we have
prepared a device ID for device 8120. 

2. 0x01 bit is a lock/unlock bit. The CAPABILITIES register could be
opened by the 0x01 bit. If we set the 0x01, the CAPABILITIES register
can be written. We have to set the 0x01 bit.

Best regards,
Jennifer   
-----Original Message-----
From: Chris Ball [mailto:cjb@laptop.org] 
Sent: Saturday, November 27, 2010 12:59 PM
To: Jennifer Li (TP)
Cc: linux-mmc@vger.kernel.org; Mario_Limonciello@Dell.com;
Joseph_Yeh@Dell.com; Chris Van Hoof; Rezwanul_Kabir@Dell.com; Shirley
Her (SC); Rich Lin (TP); Samuel Guan(WH); Hardys Lv(WH); William Lian
(TP)
Subject: Re: FW: [PATCH 2.6.32]: Add new device IDs and
registersforMULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.

Hi Jennifer,

Two more questions, and then I think this will be ready to merge:

On Mon, Nov 22, 2010 at 03:46:09PM +0800, Jennifer Li (TP) wrote:
> +	if ((chip->pdev->device == PCI_DEVICE_ID_O2_8220) ||
> +	    (chip->pdev->device == PCI_DEVICE_ID_O2_8320) ||
> +	    (chip->pdev->device == PCI_DEVICE_ID_O2_8321) ||
> +	    (chip->pdev->device == PCI_DEVICE_ID_O2_8221))

Here you test against four device IDs, but:

[...]
> +		.vendor		= PCI_VENDOR_ID_O2,
> +		.device		= PCI_DEVICE_ID_O2_8120,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.driver_data	= (kernel_ulong_t)&sdhci_o2,

Here you define a fifth ID that isn't tested above, is this intentional?
We don't need to disable ADMA on the 8120 device?

Also:

> +		ret = pci_read_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, &scratch);
> +		if (ret)
> +			return ret;
> +
> +		scratch |= 0x01;
> +		ret = pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);
> +
> +		scratch = 0x73;
> +		ret = pci_write_config_byte(chip->pdev,
O2_SDMMC_CAPABILITIES, scratch);

I'd like to know why it's necessary to perform the first read/write
to O2_SDMMC_CAPABILITIES, rather than just performing the final write
directly.  What does setting the 0x01 bit do?

I've appended the latest draft of the patch in my tree below.
Thanks, regards,

- Chris.


From: Jennifer Li <Jennifer.li@o2micro.com>
Subject: [PATCH] mmc: sdhci: Disable ADMA on some O2Micro SD/MMC parts.

This patch disables the broken ADMA on selected O2Micro devices.

Signed-off-by: Jennifer Li <Jennifer.li@o2micro.com>
---
 drivers/mmc/host/sdhci-pci.c |  110
++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |    5 ++
 2 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 3d9c246..4fb70ce 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -176,6 +176,72 @@ static const struct sdhci_pci_fixes
sdhci_intel_mfd_emmc_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 };
 
+/* O2Micro extra registers */
+#define O2_SD_LOCK_WP		0xD3
+#define O2_SD_MULTI_VCC3V	0xEE
+#define O2_SD_CLKREQ		0xEC
+#define O2_SD_CAPS		0xE0
+#define O2_SD_ADMA1		0xE2
+#define O2_SD_ADMA2		0xE7
+#define O2_SD_INF_MOD		0xF1
+
+static int o2_probe(struct sdhci_pci_chip *chip)
+{
+	int ret;
+	u8 scratch;
+
+	switch (chip->pdev->device) {
+	case PCI_DEVICE_ID_O2_8220:
+	case PCI_DEVICE_ID_O2_8221:
+	case PCI_DEVICE_ID_O2_8320:
+	case PCI_DEVICE_ID_O2_8321:
+		/* This extra setup is required due to broken ADMA. */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
&scratch);
+		if (ret)
+			return ret;
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP,
scratch);
+
+		/* Set Multi 3 to VCC3V# */
+		pci_write_config_byte(chip->pdev, O2_SD_MULTI_VCC3V,
0x08);
+
+		/* Disable CLK_REQ# support after media DET */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_CLKREQ,
&scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x20;
+		pci_write_config_byte(chip->pdev, O2_SD_CLKREQ,
scratch);
+
+		/* Choose capabilities, enable SDMA */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_CAPS,
&scratch);
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
+		ret = pci_read_config_byte(chip->pdev, O2_SD_INF_MOD,
&scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x08;
+		pci_write_config_byte(chip->pdev, O2_SD_INF_MOD,
scratch);
+
+		/* Lock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP,
&scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP,
scratch);
+	}
+
+	return 0;
+}
+
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 {
 	u8 scratch;
@@ -339,6 +405,10 @@ static int jmicron_resume(struct sdhci_pci_chip
*chip)
 	return 0;
 }
 
+static const struct sdhci_pci_fixes sdhci_o2 = {
+	.probe		= o2_probe,
+};
+
 static const struct sdhci_pci_fixes sdhci_jmicron = {
 	.probe		= jmicron_probe,
 
@@ -589,6 +659,46 @@ static const struct pci_device_id pci_ids[]
__devinitdata = {
 		.driver_data	=
(kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
 	},
 
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8120,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8220,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8221,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8320,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_O2,
+		.device		= PCI_DEVICE_ID_O2_8321,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_o2,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8),
0xFFFF00)
 	},
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d369b53..1535034 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1650,6 +1650,11 @@
 #define PCI_DEVICE_ID_O2_6836		0x6836
 #define PCI_DEVICE_ID_O2_6812		0x6872
 #define PCI_DEVICE_ID_O2_6933		0x6933
+#define PCI_DEVICE_ID_O2_8120		0x8120
+#define PCI_DEVICE_ID_O2_8220		0x8220
+#define PCI_DEVICE_ID_O2_8221		0x8221
+#define PCI_DEVICE_ID_O2_8320		0x8320
+#define PCI_DEVICE_ID_O2_8321		0x8321
 
 #define PCI_VENDOR_ID_3DFX		0x121a
 #define PCI_DEVICE_ID_3DFX_VOODOO	0x0001
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child




Unless otherwise stated, this e-mail message does not constitute a solicitation to buy or sell any products or services, or to participate in any particular trading strategy. This e-mail message and any attachments are intended solely for the use of the individual or entity to which it is addressed and may contain information that is confidential or legally privileged. If you are not the intended recipient, you are hereby notified that any dissemination, distribution, copying or other use of this message or its attachments is strictly prohibited. If you have received this message in error, please notify the sender immediately and permanently delete this message and any attachments. O2Micro International Ltd., and its subsidiaries and affiliates, are neither liable for the proper and comple
 te transmission of the information contained in this communication, the accuracy of the information contained therein, nor for any delay in its receipt.  


