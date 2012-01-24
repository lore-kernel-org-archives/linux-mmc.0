From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 05/11] ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
Date: Tue, 24 Jan 2012 13:01:34 +0100
Message-ID: <1327406500-7233-6-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1a955e2..0af2e9b 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1016,21 +1016,12 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
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
+	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.cd_gpio	= GPIO_PORT172,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -1410,7 +1401,6 @@ static void __init mackerel_init(void)
 {
 	u32 srcr4;
 	struct clk *clk;
-	int ret;
 
 	sh7372_pinmux_init();
 
@@ -1507,7 +1497,6 @@ static void __init mackerel_init(void)
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
 	/* enable SDHI0 */
-	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
 	gpio_request(GPIO_FN_SDHICMD0, NULL);
 	gpio_request(GPIO_FN_SDHICLK0, NULL);
@@ -1516,13 +1505,6 @@ static void __init mackerel_init(void)
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

