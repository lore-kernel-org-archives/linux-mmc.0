From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-acpi: add support for eMMC hardware reset for HID 80860F14
Date: Thu, 13 Jun 2013 11:50:27 +0300
Message-ID: <1371113427-8257-3-git-send-email-adrian.hunter@intel.com>
References: <1371113427-8257-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1030 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758458Ab3FMIpf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 04:45:35 -0400
In-Reply-To: <1371113427-8257-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Add support for eMMC hardware reset for HID 80860F14.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index a51e603..baa579b 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -37,6 +37,7 @@
 #include <linux/acpi_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/delay.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
@@ -85,12 +86,37 @@ static int sdhci_acpi_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
+{
+	u8 reg;
+
+	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	reg |= 0x10;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* For eMMC, minimum is 1us but give it 9us for good measure */
+	udelay(9);
+	reg &= ~0x10;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.enable_dma = sdhci_acpi_enable_dma,
 };
 
+static const struct sdhci_ops sdhci_acpi_ops_int = {
+	.enable_dma = sdhci_acpi_enable_dma,
+	.hw_reset   = sdhci_acpi_int_hw_reset,
+};
+
+static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
+	.ops = &sdhci_acpi_ops_int,
+};
+
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
-	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.chip    = &sdhci_acpi_chip_int,
+	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE | MMC_CAP_HW_RESET,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 };
-- 
1.7.11.7

