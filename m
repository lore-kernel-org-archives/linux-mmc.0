From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ARM: mach-shmobile: use GPIO interrupt also for card eject
 on SDHI0 on mackerel
Date: Thu, 14 Jul 2011 01:25:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50509 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1GMXZq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 19:25:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
also card eject events will have to be detected by the platform.
This patch prepares mackerel to this switch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   68 +++++++++++++++++++++++++++----
 1 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1b30195..05f5fe7 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -45,6 +45,7 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
+#include <linux/workqueue.h>
 
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
@@ -990,7 +991,7 @@ static struct platform_device fsi_ak4643_device = {
 
 /*
  * The card detect pin of the top SD/MMC slot (CN7) is active low and is
- * connected to GPIO A22 of SH7372 (GPIO_PORT41).
+ * connected to GPIO A22 of SH7372 (GPIO_PORT41 / IRQ8).
  */
 static int slot_cn7_get_cd(struct platform_device *pdev)
 {
@@ -998,12 +999,49 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 }
 
 /* SDHI0 */
-static irqreturn_t mackerel_sdhi0_gpio_cd(int irq, void *arg)
+struct sdhi_card_detect {
+	struct delayed_work work;
+	struct sh_mobile_sdhi_info *info;
+	int gpio_irq;
+	int gpio_port;
+	int gpio_cd;
+};
+
+static void sdhi_cd_work(struct work_struct *work)
+{
+	struct sdhi_card_detect *cd = container_of(work, struct sdhi_card_detect, work.work);
+	int ret;
+
+	if (cd->gpio_cd >= 0)
+		gpio_free(cd->gpio_cd);
+	ret = gpio_request(cd->gpio_port, NULL);
+	if (!ret) {
+		gpio_direction_input(cd->gpio_port);
+		ret = gpio_get_value(cd->gpio_port);
+		gpio_free(cd->gpio_port);
+		if (ret)
+			/* No card */
+			irq_set_irq_type(cd->gpio_irq, IRQ_TYPE_EDGE_FALLING);
+		else
+			/* Card in the slot */
+			irq_set_irq_type(cd->gpio_irq, IRQ_TYPE_EDGE_RISING);
+	}
+	if (cd->gpio_cd >= 0)
+		gpio_request(cd->gpio_cd, NULL);
+}
+
+static irqreturn_t mackerel_sdhi_gpio_cd(int irq, void *arg)
 {
-	struct device *dev = arg;
-	struct sh_mobile_sdhi_info *info = dev->platform_data;
+	struct sdhi_card_detect *cd = arg;
+	struct sh_mobile_sdhi_info *info = cd->info;
 	struct tmio_mmc_data *pdata = info->pdata;
 
+	if (irq != cd->gpio_irq)
+		return IRQ_NONE;
+
+	irq_set_irq_type(irq, IRQ_TYPE_NONE);
+
+	schedule_delayed_work(&cd->work, msecs_to_jiffies(200));
 	tmio_mmc_cd_wakeup(pdata);
 
 	return IRQ_HANDLED;
@@ -1015,6 +1053,14 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
+static struct sdhi_card_detect sdhi0_cd = {
+	.work		= __DELAYED_WORK_INITIALIZER(sdhi0_cd.work, sdhi_cd_work),
+	.info		= &sdhi0_info,
+	.gpio_irq	= evt2irq(0x3340),
+	.gpio_port	= GPIO_PORT172,
+	.gpio_cd	= GPIO_FN_SDHICD0,
+};
+
 static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -1092,7 +1138,7 @@ static struct platform_device sdhi1_device = {
 
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
- * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162).
+ * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162 / IRQ0).
  */
 static int slot_cn23_get_cd(struct platform_device *pdev)
 {
@@ -1500,12 +1546,18 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-	ret = request_irq(evt2irq(0x3340), mackerel_sdhi0_gpio_cd,
-			  IRQF_TRIGGER_FALLING, "sdhi0 cd", &sdhi0_device.dev);
+	/*
+	 * If the driver probes with a card plugged in, the native SDHICD0 IRQ
+	 * will trigger, when the runtime PM brings the interface up, and the
+	 * card will be detected. This interrupt is needed if there is no card
+	 * during probing and runtime PM turns the interface power off.
+	 */
+	ret = request_irq(sdhi0_cd.gpio_irq, mackerel_sdhi_gpio_cd,
+			  IRQF_TRIGGER_FALLING, "sdhi0 cd", &sdhi0_cd);
 	if (!ret)
 		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
 	else
-		pr_err("Cannot get IRQ #%d: %d\n", evt2irq(0x3340), ret);
+		pr_err("Cannot get IRQ #%d: %d\n", sdhi0_cd.gpio_irq, ret);
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
-- 
1.7.2.5

