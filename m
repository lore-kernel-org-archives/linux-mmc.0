From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 06/11] ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
Date: Tue, 24 Jan 2012 13:01:35 +0100
Message-ID: <1327406500-7233-7-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54883 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2AXMBr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 07:01:47 -0500
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 729eaee..d16a1c4 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -367,23 +367,13 @@ static struct platform_device mipidsi0_device = {
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
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
+	.cd_gpio	= GPIO_PORT251,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -580,7 +570,6 @@ static void __init ag5evm_init(void)
 	lcd_backlight_reset();
 
 	/* enable SDHI0 on CN15 [SD I/F] */
-	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
 	gpio_request(GPIO_FN_SDHICMD0, NULL);
 	gpio_request(GPIO_FN_SDHICLK0, NULL);
@@ -589,13 +578,6 @@ static void __init ag5evm_init(void)
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

