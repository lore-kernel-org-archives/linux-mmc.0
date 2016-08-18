From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: sdhci-pci: Convert to use managed functions (part2)
Date: Thu, 18 Aug 2016 14:59:13 +0300
Message-ID: <1471521553-125728-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11120 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698AbcHRL7R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Aug 2016 07:59:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The commit 52ac7acf412b ("mmc: sdhci-pci: Convert to use managed functions
pcim_* and devm_*") converted ->probe() / ->remove() functions to use device
managed resource API. Here is a follow up to cover sdhci_pci_probe_slot() and
sdhci_pci_remove_slot().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 34 ++++++----------------------------
 drivers/mmc/host/sdhci-pci.h      |  1 -
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 897cfd2..93bb0ff 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -156,7 +156,7 @@ static void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
 	if (!gpio_is_valid(gpio))
 		return;
 
-	err = gpio_request(gpio, "sd_cd");
+	err = devm_gpio_request(&slot->chip->pdev->dev, gpio, "sd_cd");
 	if (err < 0)
 		goto out;
 
@@ -179,7 +179,7 @@ static void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
 	return;
 
 out_free:
-	gpio_free(gpio);
+	devm_gpio_free(&slot->chip->pdev->dev, gpio);
 out:
 	dev_warn(&slot->chip->pdev->dev, "failed to setup card detect wake up\n");
 }
@@ -188,8 +188,6 @@ static void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
 {
 	if (slot->cd_irq >= 0)
 		free_irq(slot->cd_irq, slot);
-	if (gpio_is_valid(slot->cd_gpio))
-		gpio_free(slot->cd_gpio);
 }
 
 #else
@@ -1615,7 +1613,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 
 	slot->chip = chip;
 	slot->host = host;
-	slot->pci_bar = bar;
 	slot->rst_n_gpio = -EINVAL;
 	slot->cd_gpio = -EINVAL;
 	slot->cd_idx = -1;
@@ -1643,27 +1640,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 
 	host->irq = pdev->irq;
 
-	ret = pci_request_region(pdev, bar, mmc_hostname(host->mmc));
+	ret = pcim_iomap_regions(pdev, BIT(bar), mmc_hostname(host->mmc));
 	if (ret) {
 		dev_err(&pdev->dev, "cannot request region\n");
 		goto cleanup;
 	}
 
-	host->ioaddr = pci_ioremap_bar(pdev, bar);
-	if (!host->ioaddr) {
-		dev_err(&pdev->dev, "failed to remap registers\n");
-		ret = -ENOMEM;
-		goto release;
-	}
+	host->ioaddr = pcim_iomap_table(pdev)[bar];
 
 	if (chip->fixes && chip->fixes->probe_slot) {
 		ret = chip->fixes->probe_slot(slot);
 		if (ret)
-			goto unmap;
+			goto cleanup;
 	}
 
 	if (gpio_is_valid(slot->rst_n_gpio)) {
-		if (!gpio_request(slot->rst_n_gpio, "eMMC_reset")) {
+		if (!devm_gpio_request(&pdev->dev, slot->rst_n_gpio, "eMMC_reset")) {
 			gpio_direction_output(slot->rst_n_gpio, 1);
 			slot->host->mmc->caps |= MMC_CAP_HW_RESET;
 			slot->hw_reset = sdhci_pci_gpio_hw_reset;
@@ -1702,18 +1694,9 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	return slot;
 
 remove:
-	if (gpio_is_valid(slot->rst_n_gpio))
-		gpio_free(slot->rst_n_gpio);
-
 	if (chip->fixes && chip->fixes->remove_slot)
 		chip->fixes->remove_slot(slot, 0);
 
-unmap:
-	iounmap(host->ioaddr);
-
-release:
-	pci_release_region(pdev, bar);
-
 cleanup:
 	if (slot->data && slot->data->cleanup)
 		slot->data->cleanup(slot->data);
@@ -1738,17 +1721,12 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 
 	sdhci_remove_host(slot->host, dead);
 
-	if (gpio_is_valid(slot->rst_n_gpio))
-		gpio_free(slot->rst_n_gpio);
-
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
 
 	if (slot->data && slot->data->cleanup)
 		slot->data->cleanup(slot->data);
 
-	pci_release_region(slot->chip->pdev, slot->pci_bar);
-
 	sdhci_free_host(slot->host);
 }
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 7e07887..9c7c08b 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -72,7 +72,6 @@ struct sdhci_pci_slot {
 	struct sdhci_host	*host;
 	struct sdhci_pci_data	*data;
 
-	int			pci_bar;
 	int			rst_n_gpio;
 	int			cd_gpio;
 	int			cd_irq;
-- 
2.8.1

