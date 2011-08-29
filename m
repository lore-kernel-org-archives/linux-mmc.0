From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/5] mmc: sdhci-pci: add eMMC hardware reset support
Date: Mon, 29 Aug 2011 16:42:13 +0300
Message-ID: <1314625335-11638-4-git-send-email-adrian.hunter@intel.com>
References: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63266 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab1H2Nm1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Aug 2011 09:42:27 -0400
In-Reply-To: <1314625335-11638-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Implement eMMC hardware reset for Medfield.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |   72 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 26c5286..3b30c51 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -21,6 +21,8 @@
 #include <linux/mmc/host.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/sfi.h>
 
 #include "sdhci.h"
 
@@ -59,6 +61,7 @@ struct sdhci_pci_slot {
 	struct sdhci_host	*host;
 
 	int			pci_bar;
+	int			rst_n_gpio;
 };
 
 struct sdhci_pci_chip {
@@ -163,12 +166,63 @@ static int mrst_hc_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+/* Medfield eMMC hardware reset GPIOs */
+static int mfd_emmc0_rst_gpio = -EINVAL;
+static int mfd_emmc1_rst_gpio = -EINVAL;
+
+static int mfd_emmc_gpio_parse(struct sfi_table_header *table)
+{
+	struct sfi_table_simple *sb = (struct sfi_table_simple *)table;
+	struct sfi_gpio_table_entry *entry;
+	int i, num;
+
+	num = SFI_GET_NUM_ENTRIES(sb, struct sfi_gpio_table_entry);
+	entry = (struct sfi_gpio_table_entry *)sb->pentry;
+
+	for (i = 0; i < num; i++, entry++) {
+		if (!strncmp(entry->pin_name, "emmc0_rst", SFI_NAME_LEN))
+			mfd_emmc0_rst_gpio = entry->pin_no;
+		else if (!strncmp(entry->pin_name, "emmc1_rst", SFI_NAME_LEN))
+			mfd_emmc1_rst_gpio = entry->pin_no;
+	}
+
+	return 0;
+}
+
 static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
+	const char *name = NULL;
+	int gpio = -EINVAL;
+
+	sfi_table_parse(SFI_SIG_GPIO, NULL, NULL, mfd_emmc_gpio_parse);
+
+	switch (slot->chip->pdev->device) {
+	case PCI_DEVICE_ID_INTEL_MFD_EMMC0:
+		gpio = mfd_emmc0_rst_gpio;
+		name = "eMMC0_reset";
+		break;
+	case PCI_DEVICE_ID_INTEL_MFD_EMMC1:
+		gpio = mfd_emmc1_rst_gpio;
+		name = "eMMC1_reset";
+		break;
+	}
+
+	if (!gpio_request(gpio, name)) {
+		gpio_direction_output(gpio, 1);
+		slot->rst_n_gpio = gpio;
+		slot->host->mmc->caps |= MMC_CAP_HW_RESET;
+	}
+
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
 	return 0;
 }
 
+static void mfd_emmc_remove_slot(struct sdhci_pci_slot *slot, int dead)
+{
+	gpio_free(slot->rst_n_gpio);
+}
+
 static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
 	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
 	.probe_slot	= mrst_hc_probe_slot,
@@ -190,6 +244,7 @@ static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
 static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.probe_slot	= mfd_emmc_probe_slot,
+	.remove_slot	= mfd_emmc_remove_slot,
 };
 
 /* O2Micro extra registers */
@@ -832,9 +887,25 @@ static int sdhci_pci_8bit_width(struct sdhci_host *host, int width)
 	return 0;
 }
 
+static void sdhci_pci_hw_reset(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	int rst_n_gpio = slot->rst_n_gpio;
+
+	if (!gpio_is_valid(rst_n_gpio))
+		return;
+	gpio_set_value_cansleep(rst_n_gpio, 0);
+	/* For eMMC, minimum is 1us but give it 10us for good measure */
+	udelay(10);
+	gpio_set_value_cansleep(rst_n_gpio, 1);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.platform_8bit_width	= sdhci_pci_8bit_width,
+	.hw_reset		= sdhci_pci_hw_reset,
 };
 
 /*****************************************************************************\
@@ -988,6 +1059,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 	slot->chip = chip;
 	slot->host = host;
 	slot->pci_bar = bar;
+	slot->rst_n_gpio = -EINVAL;
 
 	host->hw_name = "PCI";
 	host->ops = &sdhci_pci_ops;
-- 
1.7.6

