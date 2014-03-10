From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/6] mmc: sdhci-acpi: Fix broken card detect for ACPI HID 80860F14
Date: Mon, 10 Mar 2014 15:02:42 +0200
Message-ID: <1394456564-13783-5-git-send-email-adrian.hunter@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46138 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbaCJNEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Mar 2014 09:04:09 -0400
In-Reply-To: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Some 80860F14 devices do not support card detect and must rely
completely on GPIO.  Presently the card detect GPIO is used
only to wake-up from runtime suspend.  Change to using
mmc_gpioid_request_cd() which will cause the SDHCI driver to
prefer the GPIO to the host controller's native card detect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 77 +++++++++----------------------------------
 1 file changed, 15 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9ce17f6..98c7420 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -31,7 +31,6 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/err.h>
-#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
 #include <linux/pm.h>
@@ -40,13 +39,15 @@
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci.h>
 
 #include "sdhci.h"
 
 enum {
-	SDHCI_ACPI_SD_CD	= BIT(0),
-	SDHCI_ACPI_RUNTIME_PM	= BIT(1),
+	SDHCI_ACPI_SD_CD		= BIT(0),
+	SDHCI_ACPI_RUNTIME_PM		= BIT(1),
+	SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL	= BIT(2),
 };
 
 struct sdhci_acpi_chip {
@@ -128,7 +129,8 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
-	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_RUNTIME_PM,
+	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL |
+		   SDHCI_ACPI_RUNTIME_PM,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
 };
 
@@ -192,59 +194,6 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(acpi_handle handle,
 	return slot;
 }
 
-#ifdef CONFIG_PM_RUNTIME
-
-static irqreturn_t sdhci_acpi_sd_cd(int irq, void *dev_id)
-{
-	mmc_detect_change(dev_id, msecs_to_jiffies(200));
-	return IRQ_HANDLED;
-}
-
-static int sdhci_acpi_add_own_cd(struct device *dev, struct mmc_host *mmc)
-{
-	struct gpio_desc *desc;
-	unsigned long flags;
-	int err, irq;
-
-	desc = devm_gpiod_get_index(dev, "sd_cd", 0);
-	if (IS_ERR(desc)) {
-		err = PTR_ERR(desc);
-		goto out;
-	}
-
-	err = gpiod_direction_input(desc);
-	if (err)
-		goto out_free;
-
-	irq = gpiod_to_irq(desc);
-	if (irq < 0) {
-		err = irq;
-		goto out_free;
-	}
-
-	flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
-	err = devm_request_irq(dev, irq, sdhci_acpi_sd_cd, flags, "sd_cd", mmc);
-	if (err)
-		goto out_free;
-
-	return 0;
-
-out_free:
-	devm_gpiod_put(dev, desc);
-out:
-	dev_warn(dev, "failed to setup card detect wake up\n");
-	return err;
-}
-
-#else
-
-static int sdhci_acpi_add_own_cd(struct device *dev, struct mmc_host *mmc)
-{
-	return 0;
-}
-
-#endif
-
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -332,15 +281,19 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
 
-	err = sdhci_add_host(host);
-	if (err)
-		goto err_free;
-
 	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
-		if (sdhci_acpi_add_own_cd(dev, host->mmc))
+		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
+
+		if (mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0)) {
+			dev_warn(dev, "failed to setup card detect gpio\n");
 			c->use_runtime_pm = false;
+		}
 	}
 
+	err = sdhci_add_host(host);
+	if (err)
+		goto err_free;
+
 	if (c->use_runtime_pm) {
 		pm_runtime_set_active(dev);
 		pm_suspend_ignore_children(dev, 1);
-- 
1.8.3.2

