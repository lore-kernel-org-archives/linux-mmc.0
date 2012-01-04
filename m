From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 05/11] ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
Date: Wed,  4 Jan 2012 15:17:10 +0100
Message-ID: <1325686636-23905-6-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Only compile-tested.

 arch/arm/mach-shmobile/board-ag5evm.c |   24 ++++--------------------
 1 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index b862e9f..b1db188 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -340,23 +340,15 @@ static struct platform_device mipidsi0_device = {
 };
 
 /* SDHI0 */
-static irqreturn_t ag5evm_sdhi0_gpio_cd(int irq, void *arg)
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
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_HAS_COLD_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
+	.cd_gpio	= GPIO_PORT251,
+	.cd_irq		= intcs_evt2irq(0x3c0),
+	.cd_flags	= IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -560,7 +552,6 @@ static void __init ag5evm_init(void)
 	__raw_writel(0x2a809010, DSI0PHYCR);
 
 	/* enable SDHI0 on CN15 [SD I/F] */
-	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
 	gpio_request(GPIO_FN_SDHICMD0, NULL);
 	gpio_request(GPIO_FN_SDHICLK0, NULL);
@@ -569,13 +560,6 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-	if (!request_irq(intcs_evt2irq(0x3c0), ag5evm_sdhi0_gpio_cd,
-			 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-			 "sdhi0 cd", &sdhi0_device.dev))
-		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
-	else
-		pr_warn("Unable to setup SDHI0 GPIO IRQ\n");
-
 	/* enable SDHI1 on CN4 [WLAN I/F] */
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
 	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
-- 
1.7.2.5

