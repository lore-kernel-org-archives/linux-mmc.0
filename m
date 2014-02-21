From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 4/5] mmc: sdhci-spear: remove support for power gpio
Date: Fri, 21 Feb 2014 10:41:22 +0000
Message-ID: <E1WGnXm-0007Js-TC@rmk-PC.arm.linux.org.uk>
References: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:45458 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754682AbaBUKlc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2014 05:41:32 -0500
In-Reply-To: <20140221103710.GB21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Pratyush Anand <pratyush.anand@st.com>, Mohit KUMAR <Mohit.KUMAR@st.com>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <chris@printf.net>, spear-devel@list.st.com, linux-mmc@vger.kernel.org

None of this code is currently used: there are no definitions of
struct sdhci_plat_data in arch/arm, neither are there any DT properties
which use card_power_gpio/power_active_high/power_always_enb.  In any
case, slot power control should be rigged up via vmmc and the regulator
subsystem in the DT case.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-spear.c  | 32 --------------------------------
 include/linux/mmc/sdhci-spear.h |  8 --------
 2 files changed, 40 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index f879b27e59b1..00a73b1a6444 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -59,14 +59,6 @@ static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
 	gpio_irq_type = val ? IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
 	irq_set_irq_type(irq, gpio_irq_type);
 
-	if (sdhci->data->card_power_gpio >= 0) {
-		if (!sdhci->data->power_always_enb) {
-			/* if card inserted, give power, otherwise remove it */
-			val = sdhci->data->power_active_high ? !val : val ;
-			gpio_set_value(sdhci->data->card_power_gpio, val);
-		}
-	}
-
 	/* inform sdhci driver about card insertion/removal */
 	tasklet_schedule(&host->card_tasklet);
 
@@ -184,30 +176,6 @@ static int sdhci_probe(struct platform_device *pdev)
 	if (!sdhci->data)
 		return 0;
 
-	if (sdhci->data->card_power_gpio >= 0) {
-		int val = 0;
-
-		ret = devm_gpio_request(&pdev->dev,
-				sdhci->data->card_power_gpio, "sdhci");
-		if (ret < 0) {
-			dev_dbg(&pdev->dev, "gpio request fail: %d\n",
-					sdhci->data->card_power_gpio);
-			goto set_drvdata;
-		}
-
-		if (sdhci->data->power_always_enb)
-			val = sdhci->data->power_active_high;
-		else
-			val = !sdhci->data->power_active_high;
-
-		ret = gpio_direction_output(sdhci->data->card_power_gpio, val);
-		if (ret) {
-			dev_dbg(&pdev->dev, "gpio set direction fail: %d\n",
-					sdhci->data->card_power_gpio);
-			goto set_drvdata;
-		}
-	}
-
 	if (sdhci->data->card_int_gpio >= 0) {
 		ret = devm_gpio_request(&pdev->dev, sdhci->data->card_int_gpio,
 				"sdhci");
diff --git a/include/linux/mmc/sdhci-spear.h b/include/linux/mmc/sdhci-spear.h
index e78c0e236e9d..8cc095a76cf8 100644
--- a/include/linux/mmc/sdhci-spear.h
+++ b/include/linux/mmc/sdhci-spear.h
@@ -18,17 +18,9 @@
 /*
  * struct sdhci_plat_data: spear sdhci platform data structure
  *
- * @card_power_gpio: gpio pin for enabling/disabling power to sdhci socket
- * @power_active_high: if set, enable power to sdhci socket by setting
- *			card_power_gpio
- * @power_always_enb: If set, then enable power on probe, otherwise enable only
- *			on card insertion and disable on card removal.
  * card_int_gpio: gpio pin used for card detection
  */
 struct sdhci_plat_data {
-	int card_power_gpio;
-	int power_active_high;
-	int power_always_enb;
 	int card_int_gpio;
 };
 
-- 
1.8.3.1

