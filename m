From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 04/11] ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
Date: Wed,  4 Jan 2012 15:17:09 +0100
Message-ID: <1325686636-23905-5-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64920 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab2ADORZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 09:17:25 -0500
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   24 ++++--------------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9c5e598..b35343a 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1004,21 +1004,14 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 }
 
 /* SDHI0 */
-static irqreturn_t mackerel_sdhi0_gpio_cd(int irq, void *arg)
-{
-	struct device *dev = arg;
-	struct sh_mobile_sdhi_info *info = dev->platform_data;
-	struct tmio_mmc_data *pdata = info->pdata;
-
-	tmio_mmc_cd_wakeup(pdata);
-
-	return IRQ_HANDLED;
-}
-
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_HAS_COLD_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.cd_gpio	= GPIO_PORT172,
+	.cd_irq		= evt2irq(0x3340),
+	.cd_flags	= IRQF_TRIGGER_FALLING,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -1408,7 +1401,6 @@ static void __init mackerel_init(void)
 {
 	u32 srcr4;
 	struct clk *clk;
-	int ret;
 
 	sh7372_pinmux_init();
 
@@ -1505,7 +1497,6 @@ static void __init mackerel_init(void)
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
 	/* enable SDHI0 */
-	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
 	gpio_request(GPIO_FN_SDHICMD0, NULL);
 	gpio_request(GPIO_FN_SDHICLK0, NULL);
@@ -1514,13 +1505,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-	ret = request_irq(evt2irq(0x3340), mackerel_sdhi0_gpio_cd,
-			  IRQF_TRIGGER_FALLING, "sdhi0 cd", &sdhi0_device.dev);
-	if (!ret)
-		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
-	else
-		pr_err("Cannot get IRQ #%d: %d\n", evt2irq(0x3340), ret);
-
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
-- 
1.7.2.5

