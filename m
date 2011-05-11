From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] ARM: arch-shmobile: support SDHI card detection on
 mackerel, using a GPIO
Date: Wed, 11 May 2011 18:51:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105111850410.5557@axis700.grange>
References: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On sh7372 the card-detection pin of SDHI0 can also produce interrupts,
when configured as GPIO. Use this feature to power down SDHI0, when no
card is plugged in.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b20dd6f..48fd2fe 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -39,6 +39,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/pm_runtime.h>
 #include <linux/smsc911x.h>
 #include <linux/sh_intc.h>
 #include <linux/tca6416_keypad.h>
@@ -670,6 +671,17 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 }
 
 /* SDHI0 */
+static irqreturn_t mackerel_sdhi0_gpio_cd(int irq, void *arg)
+{
+	struct device *dev = arg;
+	struct sh_mobile_sdhi_info *info = dev->platform_data;
+	struct tmio_mmc_data *pdata = info->pdata;
+
+	tmio_mmc_cd_wakeup(pdata);
+
+	return IRQ_HANDLED;
+}
+
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
@@ -1040,6 +1052,7 @@ static void __init mackerel_init(void)
 {
 	u32 srcr4;
 	struct clk *clk;
+	int ret;
 
 	sh7372_pinmux_init();
 
@@ -1144,6 +1157,13 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
+	ret = request_irq(evt2irq(0x3340), mackerel_sdhi0_gpio_cd,
+			  IRQF_TRIGGER_FALLING, "sdhi0 cd", &sdhi0_device.dev);
+	if (!ret)
+		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
+	else
+		pr_err("Cannot get IRQ #%d: %d\n", evt2irq(0x3340), ret);
+
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
-- 
1.7.2.5

