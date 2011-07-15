From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2 v2] ARM: mach-shmobile: use GPIO interrupt also for card
 eject on SDHI0 on mackerel
Date: Fri, 15 Jul 2011 12:59:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107151257220.22613@axis700.grange>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
 <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>
List-Id: linux-mmc@vger.kernel.org

When we switch to transaction-based runtime PM on SDHI / TMIO MMC,
also card eject events will have to be detected by the platform.
This patch prepares mackerel to this switch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: reconfiguring the pin for card insertion and ejection is no longer 
needed.

 arch/arm/mach-shmobile/board-mackerel.c |   48 +++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1b30195..9addaae 100644
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
@@ -998,12 +999,30 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 }
 
 /* SDHI0 */
-static irqreturn_t mackerel_sdhi0_gpio_cd(int irq, void *arg)
+struct sdhi_card_detect {
+	struct delayed_work work;
+	struct sh_mobile_sdhi_info *info;
+	int gpio_irq;
+};
+
+static void sdhi_cd_work(struct work_struct *work)
+{
+	struct sdhi_card_detect *cd = container_of(work, struct sdhi_card_detect, work.work);
+	irq_set_irq_type(cd->gpio_irq, IRQ_TYPE_EDGE_BOTH);
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
@@ -1015,6 +1034,12 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
+static struct sdhi_card_detect sdhi0_cd = {
+	.work		= __DELAYED_WORK_INITIALIZER(sdhi0_cd.work, sdhi_cd_work),
+	.info		= &sdhi0_info,
+	.gpio_irq	= evt2irq(0x3340),
+};
+
 static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -1092,7 +1117,7 @@ static struct platform_device sdhi1_device = {
 
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
- * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162).
+ * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162 / IRQ0).
  */
 static int slot_cn23_get_cd(struct platform_device *pdev)
 {
@@ -1500,12 +1525,19 @@ static void __init mackerel_init(void)
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
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			  "sdhi0 cd", &sdhi0_cd);
 	if (!ret)
 		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
 	else
-		pr_err("Cannot get IRQ #%d: %d\n", evt2irq(0x3340), ret);
+		pr_err("Cannot get IRQ #%d: %d\n", sdhi0_cd.gpio_irq, ret);
 
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
-- 
1.7.2.5

