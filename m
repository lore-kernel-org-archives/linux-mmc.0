From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/3] mmc: sdhci-acpi: support runtime PM for ACPI HID 80860F14 SD cards
Date: Mon,  6 May 2013 12:17:33 +0300
Message-ID: <1367831854-31952-3-git-send-email-adrian.hunter@intel.com>
References: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33871 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab3EFJMj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 May 2013 05:12:39 -0400
In-Reply-To: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Enable runtime PM for ACPI HID 80860F14 SD cards, adding support for
card detect GPIO.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 64 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 706d9cb..17fceba 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -31,8 +31,10 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
+#include <linux/acpi_gpio.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 
@@ -101,6 +103,8 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
+	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_RUNTIME_PM,
+	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
 };
 
 struct sdhci_acpi_uid_slot {
@@ -161,6 +165,57 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(acpi_handle handle,
 	return slot;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+
+static irqreturn_t sdhci_acpi_sd_cd(int irq, void *dev_id)
+{
+	mmc_detect_change(dev_id, msecs_to_jiffies(200));
+	return IRQ_HANDLED;
+}
+
+static int sdhci_acpi_add_own_cd(struct device *dev, int gpio,
+				 struct mmc_host *mmc)
+{
+	unsigned long flags;
+	int err, irq;
+
+	if (gpio < 0) {
+		err = gpio;
+		goto out;
+	}
+
+	err = devm_gpio_request_one(dev, gpio, GPIOF_DIR_IN, "sd_cd");
+	if (err)
+		goto out;
+
+	irq = gpio_to_irq(gpio);
+	if (irq < 0)
+		goto out_free;
+
+	flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+	err = devm_request_irq(dev, irq, sdhci_acpi_sd_cd, flags, "sd_cd", mmc);
+	if (err)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	devm_gpio_free(dev, gpio);
+out:
+	dev_warn(dev, "failed to setup card detect wake up\n");
+	return err;
+}
+
+#else
+
+static int sdhci_acpi_add_own_cd(struct device *dev, int gpio,
+				 struct mmc_host *mmc)
+{
+	return 0;
+}
+
+#endif
+
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -171,7 +226,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct resource *iomem;
 	resource_size_t len;
 	const char *hid;
-	int err;
+	int err, gpio;
 
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
@@ -196,6 +251,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	gpio = acpi_get_gpio_by_index(dev, 0, NULL);
+
 	c = sdhci_priv(host);
 	c->host = host;
 	c->slot = sdhci_acpi_get_slot(handle, hid);
@@ -251,6 +308,11 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (err)
 		goto err_free;
 
+	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
+		if (sdhci_acpi_add_own_cd(dev, gpio, host->mmc))
+			c->use_runtime_pm = false;
+	}
+
 	if (c->use_runtime_pm) {
 		pm_runtime_set_active(dev);
 		pm_suspend_ignore_children(dev, 1);
-- 
1.7.11.7

