From: akpm@linux-foundation.org
Subject: [patch 175/196] sdhci: add support for the SysKonnect CardBus2SDIO adapter
Date: Mon, 14 Dec 2009 18:01:26 -0800
Message-ID: <200912150201.nBF21QGq022685@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46289 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758610AbZLOCMd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:12:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nico@fluxnic.net, linux-mmc@vger.kernel.org, nico@marvell.com

From: Nicolas Pitre <nico@fluxnic.net>

This is still in use especially to develop SDIO device drivers on laptop
machines which are lacking SDIO slots.  This adapter supports SDIO cards
only due to lack of 136-bit response capability.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-pci.c |   75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff -puN drivers/mmc/host/sdhci-pci.c~sdhci-add-support-for-the-syskonnect-cardbus2sdio-adapter drivers/mmc/host/sdhci-pci.c
--- a/drivers/mmc/host/sdhci-pci.c~sdhci-add-support-for-the-syskonnect-cardbus2sdio-adapter
+++ a/drivers/mmc/host/sdhci-pci.c
@@ -285,6 +285,73 @@ static const struct sdhci_pci_fixes sdhc
 	.resume		= jmicron_resume,
 };
 
+/* SysKonnect CardBus2SDIO extra registers */
+#define SYSKT_CTRL		0x200
+#define SYSKT_RDFIFO_STAT	0x204
+#define SYSKT_WRFIFO_STAT	0x208
+#define SYSKT_POWER_DATA	0x20c
+#define   SYSKT_POWER_330	0xef
+#define   SYSKT_POWER_300	0xf8
+#define   SYSKT_POWER_184	0xcc
+#define SYSKT_POWER_CMD		0x20d
+#define   SYSKT_POWER_START	(1 << 7)
+#define SYSKT_POWER_STATUS	0x20e
+#define   SYSKT_POWER_STATUS_OK	(1 << 0)
+#define SYSKT_BOARD_REV		0x210
+#define SYSKT_CHIP_REV		0x211
+#define SYSKT_CONF_DATA		0x212
+#define   SYSKT_CONF_DATA_1V8	(1 << 2)
+#define   SYSKT_CONF_DATA_2V5	(1 << 1)
+#define   SYSKT_CONF_DATA_3V3	(1 << 0)
+
+static int syskt_probe(struct sdhci_pci_chip *chip)
+{
+	if ((chip->pdev->class & 0x0000FF) == PCI_SDHCI_IFVENDOR) {
+		chip->pdev->class &= ~0x0000FF;
+		chip->pdev->class |= PCI_SDHCI_IFDMA;
+	}
+	return 0;
+}
+
+static int syskt_probe_slot(struct sdhci_pci_slot *slot)
+{
+	int tm, ps;
+
+	u8 board_rev = readb(slot->host->ioaddr + SYSKT_BOARD_REV);
+	u8  chip_rev = readb(slot->host->ioaddr + SYSKT_CHIP_REV);
+	dev_info(&slot->chip->pdev->dev, "SysKonnect CardBus2SDIO, "
+					 "board rev %d.%d, chip rev %d.%d\n",
+					 board_rev >> 4, board_rev & 0xf,
+					 chip_rev >> 4,  chip_rev & 0xf);
+	if (chip_rev >= 0x20)
+		slot->host->quirks |= SDHCI_QUIRK_FORCE_DMA;
+
+	writeb(SYSKT_POWER_330, slot->host->ioaddr + SYSKT_POWER_DATA);
+	writeb(SYSKT_POWER_START, slot->host->ioaddr + SYSKT_POWER_CMD);
+	udelay(50);
+	tm = 10;  /* Wait max 1 ms */
+	do {
+		ps = readw(slot->host->ioaddr + SYSKT_POWER_STATUS);
+		if (ps & SYSKT_POWER_STATUS_OK)
+			break;
+		udelay(100);
+	} while (--tm);
+	if (!tm) {
+		dev_err(&slot->chip->pdev->dev,
+			"power regulator never stabilized");
+		writeb(0, slot->host->ioaddr + SYSKT_POWER_CMD);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct sdhci_pci_fixes sdhci_syskt = {
+	.quirks		= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER,
+	.probe		= syskt_probe,
+	.probe_slot	= syskt_probe_slot,
+};
+
 static int via_probe(struct sdhci_pci_chip *chip)
 {
 	if (chip->pdev->revision == 0x10)
@@ -363,6 +430,14 @@ static const struct pci_device_id pci_id
 	},
 
 	{
+		.vendor		= PCI_VENDOR_ID_SYSKONNECT,
+		.device		= 0x8000,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_syskt,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_VIA,
 		.device		= 0x95d0,
 		.subvendor	= PCI_ANY_ID,
_
