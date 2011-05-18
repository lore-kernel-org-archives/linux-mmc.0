From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v2 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Wed, 18 May 2011 16:42:22 -0400
Message-ID: <1305751342-28532-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:60314 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab1ERInJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 04:43:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@ma>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, RaymondWu <xywu@marvell.com>, Jun Nie <njun@marvell.com>

        Call back functions is added to support mmp2, pxa910, and pxa955

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: RaymondWu <xywu@marvell.com>
Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   46 ++++++++++++++
 drivers/mmc/host/sdhci-pxa.c           |  104 +++++++++++++++++++-------------
 2 files changed, 109 insertions(+), 41 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..269dbe6 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -13,9 +13,14 @@
 #ifndef __PLAT_PXA_SDHCI_H
 #define __PLAT_PXA_SDHCI_H
 
+#include <linux/mmc/sdhci.h>
+#include <linux/platform_device.h>
+
 /* pxa specific flag */
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
+/* card alwayes wired to host, like on-chip emmc */
+#define PXA_FLAG_CARD_PERMANENT	(1<<1)
 
 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
@@ -23,13 +28,54 @@
 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
  * @max_speed: the maximum speed supported
+ * @host_caps: Standard MMC host capabilities bit field.
  * @quirks: quirks of specific device
  * @flags: flags for platform requirement
+ * @clk_delay_cycles:
+ *	mmp2: each step is roughly 100ps, 5bits width
+ *	pxa910: each step is 1ns, 4bits width
+ * @clk_delay_enable: enable clk_delay or not, used on pxa910
+ * @clk_delay_sel: select clk_delay, used on pxa910
+ *	0: choose feedback clk
+ *	1: choose feedback clk + delay value
+ *	2: choose internal clk
+ * @ext_cd_gpio: gpio pin used for external CD line
+ * @ext_cd_gpio_invert: invert values for external CD gpio line
+ * @soc_set_timing: set timing for specific soc
+ * @ext_cd_init: Initialize external card detect subsystem
+ * @ext_cd_cleanup: Cleanup external card detect subsystem
+ * @soc_set_ops: overwrite host ops with soc specific ops
  */
+struct sdhci_pxa;
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
+	unsigned int	host_caps;
 	unsigned int	quirks;
 	unsigned int	flags;
+	unsigned int	clk_delay_cycles;
+	unsigned int	clk_delay_sel;
+	unsigned int	ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
+	bool		clk_delay_enable;
+
+	void (*soc_set_timing)(struct sdhci_host *host,
+			struct sdhci_pxa_platdata *pdata);
+	int (*ext_cd_init)(void (*notify_func)(struct platform_device *dev,
+						   int state), void *data);
+	int (*ext_cd_cleanup)(void (*notify_func)(struct platform_device *dev,
+						      int state), void *data);
+	void (*soc_set_ops)(struct sdhci_pxa *pxa);
+};
+
+struct sdhci_pxa {
+	struct sdhci_host		*host;
+	struct sdhci_pxa_platdata	*pdata;
+	struct clk			*clk;
+	struct resource			*res;
+	struct sdhci_ops		*ops;
+
+	u8	clk_enable;
+	u8	power_mode;
 };
 
 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 1dc9deb..460d6c3 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -24,48 +24,26 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 #include <plat/sdhci.h>
 #include "sdhci.h"
 
 #define DRIVER_NAME	"sdhci-pxa"
 
-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
-struct sdhci_pxa {
-	struct sdhci_host		*host;
-	struct sdhci_pxa_platdata	*pdata;
-	struct clk			*clk;
-	struct resource			*res;
-
-	u8 clk_enable;
-};
-
 /*****************************************************************************\
  *                                                                           *
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
+	struct sdhci_pxa_platdata *pdata = pxa->pdata;
 
-	if (clock == 0) {
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable = 0;
-		}
-	} else {
-		if (0 == pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |= DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
-			clk_enable(pxa->clk);
-			pxa->clk_enable = 1;
-		}
+	if (clock) {
+		if (pdata && pdata->soc_set_timing)
+			pdata->soc_set_timing(host, pdata);
 	}
 }
 
@@ -106,10 +84,24 @@ static int set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return 0;
 }
 
-static struct sdhci_ops sdhci_pxa_ops = {
-	.set_uhs_signaling = set_uhs_signaling,
-	.set_clock = set_clock,
-};
+static void sdhci_pxa_notify_change(struct platform_device *dev, int state)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+	unsigned long flags;
+
+	if (host) {
+		spin_lock_irqsave(&host->lock, flags);
+		if (state) {
+			dev_dbg(&dev->dev, "card inserted.\n");
+			host->flags &= ~SDHCI_DEVICE_DEAD;
+		} else {
+			dev_dbg(&dev->dev, "card removed.\n");
+			host->flags |= SDHCI_DEVICE_DEAD;
+		}
+		tasklet_schedule(&host->card_tasklet);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}
 
 /*****************************************************************************\
  *                                                                           *
@@ -149,12 +141,19 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	pxa->pdata = pdata;
 	pxa->clk_enable = 0;
 
+	pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+	if (!pxa->ops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	pxa->clk = clk_get(dev, "PXA-SDHCLK");
 	if (IS_ERR(pxa->clk)) {
 		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(pxa->clk);
 		goto out;
 	}
+	clk_enable(pxa->clk);
 
 	pxa->res = request_mem_region(iomem->start, resource_size(iomem),
 				      mmc_hostname(host->mmc));
@@ -172,11 +171,16 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	}
 
 	host->hw_name = "MMC";
-	host->ops = &sdhci_pxa_ops;
 	host->irq = irq;
-	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (pdata->quirks)
+	if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		/* on-chip device */
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+	}
+
+	if (pdata && pdata->quirks)
 		host->quirks |= pdata->quirks;
 
 	/* enable 1/8V DDR capable */
@@ -186,21 +190,36 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+	if (pdata && pdata->host_caps)
+		host->mmc->caps |= pdata->host_caps;
+
+	if (pdata && pdata->soc_set_ops)
+		pdata->soc_set_ops(pxa);
+
+	pxa->ops->set_clock = set_clock;
+	pxa->ops->set_uhs_signaling = set_uhs_signaling;
+	host->ops = pxa->ops;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
 		goto out;
 	}
 
-	if (pxa->pdata->max_speed)
-		host->mmc->f_max = pxa->pdata->max_speed;
+	if (pdata && pdata->max_speed)
+		host->mmc->f_max = pdata->max_speed;
+
+	if (pdata && pdata->ext_cd_init)
+		pdata->ext_cd_init(&sdhci_pxa_notify_change, pdata);
 
 	platform_set_drvdata(pdev, host);
 
 	return 0;
 out:
 	if (host) {
+		clk_disable(pxa->clk);
 		clk_put(pxa->clk);
+		kfree(pxa->ops);
 		if (host->ioaddr)
 			iounmap(host->ioaddr);
 		if (pxa->res)
@@ -214,27 +233,30 @@ out:
 
 static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
 {
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pxa *pxa = sdhci_priv(host);
 	int dead = 0;
 	u32 scratch;
 
 	if (host) {
+		if (pdata && pdata->ext_cd_cleanup)
+			pdata->ext_cd_cleanup(&sdhci_pxa_notify_change, pdata);
+
 		scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
 		if (scratch == (u32)-1)
 			dead = 1;
 
 		sdhci_remove_host(host, dead);
 
+		kfree(pxa->ops);
 		if (host->ioaddr)
 			iounmap(host->ioaddr);
 		if (pxa->res)
 			release_mem_region(pxa->res->start,
 					   resource_size(pxa->res));
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable = 0;
-		}
+
+		clk_disable(pxa->clk);
 		clk_put(pxa->clk);
 
 		sdhci_free_host(host);
-- 
1.7.0.4

