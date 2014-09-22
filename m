From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/13] mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
Date: Mon, 22 Sep 2014 13:17:41 +0300
Message-ID: <1411381064-1703-11-git-send-email-adrian.hunter@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33216 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbaIVKTd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:33 -0400
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add support for card detect for Bay Trail
and Braswell SD Card host controllers in PCI
mode.

This uses the gpio descriptor API which can find
gpio descriptors, for example, on an ACPI comapnion
device.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 20 +++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.h |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 31181d8..39499fb 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci-pci-data.h>
 
 #include "sdhci.h"
@@ -280,6 +281,14 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->cd_con_id = NULL;
+	slot->cd_idx = 0;
+	slot->cd_override_level = true;
+	return 0;
+}
+
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
@@ -300,6 +309,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 			  SDHCI_QUIRK2_STOP_WITH_TC,
 	.allow_runtime_pm = true,
 	.own_cd_for_runtime_pm = true,
+	.probe_slot	= byt_sd_probe_slot,
 };
 
 /* Define Host controllers for Intel Merrifield platform */
@@ -1354,6 +1364,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	slot->pci_bar = bar;
 	slot->rst_n_gpio = -EINVAL;
 	slot->cd_gpio = -EINVAL;
+	slot->cd_idx = -1;
 
 	/* Retrieve platform data if there is any */
 	if (*sdhci_pci_get_data)
@@ -1412,6 +1423,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	host->mmc->slotno = slotno;
 	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
 
+	if (slot->cd_idx >= 0 &&
+	    mmc_gpiod_request_cd(host->mmc, slot->cd_con_id, slot->cd_idx,
+				 slot->cd_override_level, 0)) {
+		dev_warn(&pdev->dev, "failed to setup card detect gpio\n");
+		slot->cd_idx = -1;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto remove;
@@ -1424,7 +1442,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	 * Note sdhci_pci_add_own_cd() sets slot->cd_gpio to -EINVAL on failure.
 	 */
 	if (chip->fixes && chip->fixes->own_cd_for_runtime_pm &&
-	    !gpio_is_valid(slot->cd_gpio))
+	    !gpio_is_valid(slot->cd_gpio) && slot->cd_idx < 0)
 		chip->allow_runtime_pm = false;
 
 	return slot;
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 9c1909b..d57c3d1 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -64,6 +64,10 @@ struct sdhci_pci_slot {
 	int			cd_gpio;
 	int			cd_irq;
 
+	char			*cd_con_id;
+	int			cd_idx;
+	bool			cd_override_level;
+
 	void (*hw_reset)(struct sdhci_host *host);
 };
 
-- 
1.8.3.2

