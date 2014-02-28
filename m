From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 6/6] mmc: sdhci-spear: use generic card detection gpio support
Date: Fri, 28 Feb 2014 21:32:49 +0000
Message-ID: <E1WJV33-00042Y-Hb@rmk-PC.arm.linux.org.uk>
References: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60188 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752206AbaB1Vcw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 16:32:52 -0500
In-Reply-To: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

sdhci has support for using GPIOs for card detection.  If we have a
GPIO specified, we can use that directly, without needing our own
interrupt handler.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c | 79 +++++++++---------------------------------
 1 file changed, 17 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2a208a9b4de1..87e737c00876 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-spear.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/io.h>
 #include "sdhci.h"
 
@@ -40,28 +41,6 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	/* Nothing to do for now. */
 };
 
-/* gpio card detection interrupt handler */
-static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
-{
-	struct platform_device *pdev = dev_id;
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
-	unsigned long gpio_irq_type;
-	int val;
-
-	val = gpio_get_value(sdhci->data->card_int_gpio);
-
-	/* val == 1 -> card removed, val == 0 -> card inserted */
-	/* if card removed - set irq for low level, else vice versa */
-	gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
-	irq_set_irq_type(irq, gpio_irq_type);
-
-	/* inform sdhci driver about card insertion/removal */
-	tasklet_schedule(&host->card_tasklet);
-
-	return IRQ_HANDLED;
-}
-
 #ifdef CONFIG_OF
 static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pdev)
 {
@@ -154,6 +133,22 @@ static int sdhci_probe(struct platform_device *pdev)
 		sdhci->data = dev_get_platdata(&pdev->dev);
 	}
 
+	/*
+	 * It is optional to use GPIOs for sdhci card detection. If
+	 * sdhci->data is NULL, then use original sdhci lines otherwise
+	 * GPIO lines. We use the built-in GPIO support for this.
+	 */
+	if (sdhci->data && sdhci->data->card_int_gpio >= 0) {
+		ret = mmc_gpio_request_cd(host->mmc,
+					  sdhci->data->card_int_gpio, 0);
+		if (ret < 0) {
+			dev_dbg(&pdev->dev,
+				"failed to request card-detect gpio%d\n",
+				sdhci->data->card_int_gpio);
+			goto disable_clk;
+		}
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_dbg(&pdev->dev, "error adding host\n");
@@ -162,48 +157,8 @@ static int sdhci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	/*
-	 * It is optional to use GPIOs for sdhci Power control & sdhci card
-	 * interrupt detection. If sdhci->data is NULL, then use original sdhci
-	 * lines otherwise GPIO lines.
-	 * If GPIO is selected for power control, then power should be disabled
-	 * after card removal and should be enabled when card insertion
-	 * interrupt occurs
-	 */
-	if (!sdhci->data)
-		return 0;
-
-	if (sdhci->data->card_int_gpio >= 0) {
-		ret = devm_gpio_request(&pdev->dev, sdhci->data->card_int_gpio,
-				"sdhci");
-		if (ret < 0) {
-			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto set_drvdata;
-		}
-
-		ret = gpio_direction_input(sdhci->data->card_int_gpio);
-		if (ret) {
-			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto set_drvdata;
-		}
-		ret = devm_request_irq(&pdev->dev,
-				gpio_to_irq(sdhci->data->card_int_gpio),
-				sdhci_gpio_irq, IRQF_TRIGGER_LOW,
-				mmc_hostname(host->mmc), pdev);
-		if (ret) {
-			dev_dbg(&pdev->dev, "gpio request irq fail: %d\n",
-					sdhci->data->card_int_gpio);
-			goto set_drvdata;
-		}
-
-	}
-
 	return 0;
 
-set_drvdata:
-	sdhci_remove_host(host, 1);
 disable_clk:
 	clk_disable_unprepare(sdhci->clk);
 err_host:
-- 
1.8.3.1

