From: Beata Baranowska <beatax.baranowska@intel.com>
Subject: [RFC PATCH] mmc: host: add a new cap to force set power control
Date: Tue, 28 Jun 2016 11:36:57 +0200
Message-ID: <1467106617-33219-1-git-send-email-beatax.baranowska@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41361 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbcF1Jse (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2016 05:48:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sebastianx.jarosz@intel.com, beatax.baranowska@intel.com, Chuanxiao Dong <chuanxiao.dong@intel.com>

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

Even with a regulator, some host controller still needs to
set the power control register to make sure the inter logical
is working

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c |  5 ++++-
 drivers/mmc/host/sdhci.c      | 10 ++++++----
 include/linux/mmc/host.h      |  6 ++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 458ffb7637e5..23f436ec5803 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -275,7 +275,8 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
 		   MMC_CAP_WAIT_WHILE_BUSY,
-	.caps2   = MMC_CAP2_HC_ERASE_SZ,
+	.caps2   = MMC_CAP2_HC_ERASE_SZ |
+		   MMC_CAP2_FORCE_SET_PWR_CTRL,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
@@ -290,6 +291,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
 		   MMC_CAP_WAIT_WHILE_BUSY,
+	.caps2	 = MMC_CAP2_FORCE_SET_PWR_CTRL,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
 	.probe_slot	= sdhci_acpi_sdio_probe_slot,
@@ -302,6 +304,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.caps    = MMC_CAP_WAIT_WHILE_BUSY,
+	.caps2	 = MMC_CAP2_FORCE_SET_PWR_CTRL,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e3d7c056cb1..9b50648d320f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1268,10 +1268,12 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 	spin_lock_irq(&host->lock);
 
-	if (mode != MMC_POWER_OFF)
-		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
-	else
-		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	if (!(mmc->caps2 & MMC_CAP2_FORCE_SET_PWR_CTRL)) {
+		if (mode != MMC_POWER_OFF)
+			sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
+		else
+			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	}
 }
 
 void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 45cde8cd39f2..0eee78d17722 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -303,6 +303,12 @@ struct mmc_host {
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
 
+/*
+ * For the host which needs to config its power control
+ * register even it has regulators
+ */
+#define MMC_CAP2_FORCE_SET_PWR_CTRL	(1 << 20)
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
 	/* host specific block data */
-- 
1.9.1

