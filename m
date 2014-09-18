From: Vincent Wan <vincent.wan@amd.com>
Subject: [PATCH] sdhci:  fix sd/emmc clear transfer mode issue
Date: Thu, 18 Sep 2014 14:44:13 +0800
Message-ID: <541A7F3D.70909@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:53664
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751024AbaIRELI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Sep 2014 00:11:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: ray.huang@amd.com, Wan Zongshun <mcuos.com@gmail.com>

This patch is to fix AMD SD/eMMC host controller issue.
We have seen this DMA false trigger after the following sequence:

1.The first command has data transfer and driver enable DMA.
2.Driver did not clear transfer mode register, and send second command.
3.The second command has a response with busy state.

for example: cmd8 -> cmd6

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
Signed-off-by: Vincent Wan <vincent.wan@amd.com>
---
  drivers/mmc/host/sdhci-pci.c | 26 ++++++++++++++++++++++++++
  drivers/mmc/host/sdhci.c     |  3 +++
  include/linux/mmc/sdhci.h    |  2 ++
  3 files changed, 31 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..68ea2f2 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -622,6 +622,22 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
  	.probe_slot	= rtsx_probe_slot,
  };

+static int amd_probe(struct sdhci_pci_chip *chip)
+{
+	struct pci_dev	*smbus_dev;
+	smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
+			PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
+
+	if (smbus_dev && (smbus_dev->revision < 0x51))
+		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
+
+	return 0;
+}
+
+static const struct sdhci_pci_fixes sdhci_amd = {
+	.probe		= amd_probe,
+};
+
  static const struct pci_device_id pci_ids[] = {
  	{
  		.vendor		= PCI_VENDOR_ID_RICOH,
@@ -991,6 +1007,16 @@ static const struct pci_device_id pci_ids[] = {
  		.driver_data	= (kernel_ulong_t)&sdhci_o2,
  	},

+	{
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_ANY_ID,
+		.class		= PCI_CLASS_SYSTEM_SDHCI << 8,
+		.class_mask	= 0xFFFF00,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_amd,
+	},
+
  	{	/* Generic SD host controller */
  		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
  	},
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..b9e0bc7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -879,6 +879,9 @@ static void sdhci_set_transfer_mode(struct 
sdhci_host *host,
  	u16 mode;
  	struct mmc_data *data = cmd->data;

+	if (host->quirks2 & SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD)
+		sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
+
  	if (data == NULL) {
  		/* clear Auto CMD settings for no data CMDs */
  		mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 08abe99..6ba5dab 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
  #define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
  /* Controller does not support DDR50 */
  #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+/* need clear transfer mode register before send cmd */
+#define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	(1<<8)

  	int irq;		/* Device IRQ */
  	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.1.2
