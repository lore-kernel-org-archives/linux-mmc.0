From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: sdhci-acpi: add probe_slot method for emmc/sd/sdio
Date: Tue, 26 Aug 2014 20:00:55 +0800
Message-ID: <1409054455-7782-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18601 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbaHZL7c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Aug 2014 07:59:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>

Similar to sdhci-pci controller, also add probe_slot
and remove_slot method in the sdhci-acpi driver.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c |   58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8ce3c28..93dabf7 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -67,6 +67,8 @@ struct sdhci_acpi_slot {
 	unsigned int	caps2;
 	mmc_pm_flag_t	pm_caps;
 	unsigned int	flags;
+	int (*probe_slot) (struct platform_device *);
+	int (*remove_slot) (struct platform_device *);
 };
 
 struct sdhci_acpi_host {
@@ -122,11 +124,57 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host;
+
+	if (!c || !c->host)
+		return 0;
+
+	host = c->host;
+
+	/* Platform specific code during emmc proble slot goes here */
+
+	return 0;
+}
+
+static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host;
+
+	if (!c || !c->host)
+		return 0;
+
+	host = c->host;
+
+	/* Platform specific code during emmc proble slot goes here */
+
+	return 0;
+}
+
+static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct sdhci_host *host;
+
+	if (!c || !c->host || !c->slot)
+		return 0;
+
+	host = c->host;
+
+	/* Platform specific code during emmc proble slot goes here */
+
+	return 0;
+}
+
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.chip    = &sdhci_acpi_chip_int,
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE | MMC_CAP_HW_RESET,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
+	.probe_slot	= sdhci_acpi_emmc_probe_slot,
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
@@ -135,12 +183,14 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
+	.probe_slot	= sdhci_acpi_sdio_probe_slot,
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL |
 		   SDHCI_ACPI_RUNTIME_PM,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
+	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
 struct sdhci_acpi_uid_slot {
@@ -275,6 +325,11 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	}
 
 	if (c->slot) {
+		if (c->slot->probe_slot) {
+			err = c->slot->probe_slot(pdev);
+			if (err)
+				goto err_free;
+		}
 		if (c->slot->chip) {
 			host->ops            = c->slot->chip->ops;
 			host->quirks        |= c->slot->chip->quirks;
@@ -332,6 +387,9 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
 		pm_runtime_put_noidle(dev);
 	}
 
+	if (c->slot && c->slot->remove_slot)
+		c->slot->remove_slot(pdev);
+
 	dead = (sdhci_readl(c->host, SDHCI_INT_STATUS) == ~0);
 	sdhci_remove_host(c->host, dead);
 	sdhci_free_host(c->host);
-- 
1.7.9.5

