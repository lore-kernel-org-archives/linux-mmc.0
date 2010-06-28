From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] SDHCI: 8-bit data transfer width support
Date: Mon, 28 Jun 2010 11:39:48 -0700
Message-ID: <20100628113948.7778048d.akpm@linux-foundation.org>
References: <20100612054502.GA25686@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39087 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348Ab0F1SkC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2010 14:40:02 -0400
In-Reply-To: <20100612054502.GA25686@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-mmc@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@secretlab.ca>

On Sat, 12 Jun 2010 14:45:02 +0900
Kyungmin Park <kyungmin.park@samsung.com> wrote:

> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Some host constroller such as s5pc110 has WIDE8 support feature.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 +++++
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 142419c..6cf018a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1159,6 +1159,11 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
> +	if (ios->bus_width == MMC_BUS_WIDTH_8)
> +		ctrl |= SDHCI_CTRL_8BITBUS;
> +	else
> +		ctrl &= ~SDHCI_CTRL_8BITBUS;
> +
>  	if (ios->bus_width == MMC_BUS_WIDTH_4)
>  		ctrl |= SDHCI_CTRL_4BITBUS;
>  	else
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..eb5efe0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -72,6 +72,7 @@
>  #define   SDHCI_CTRL_ADMA1	0x08
>  #define   SDHCI_CTRL_ADMA32	0x10
>  #define   SDHCI_CTRL_ADMA64	0x18
> +#define  SDHCI_CTRL_8BITBUS	0x20
>  
>  #define SDHCI_POWER_CONTROL	0x29
>  #define  SDHCI_POWER_ON		0x01

This change (or something similar) also seems to have been lumped into
the unchangelogged, unreviewed "mmc: sdhci: Initial Tegra sdhci driver"
patch.  So again, I'll drop your patch and if "mmc: sdhci: Initial
Tegra sdhci driver" doesn't get merged, your patch will be lost.

I wonder what else it does.  Here it is:

commit feed6702dc4bb130869171cbd8167637ea13c33c
Author:     Colin Cross <ccross@android.com>
AuthorDate: Wed Mar 10 20:42:35 2010 -0800
Commit:     Grant Likely <grant.likely@secretlab.ca>
CommitDate: Fri Jun 25 09:47:58 2010 -0600

    mmc: sdhci: Initial Tegra sdhci driver
    
    Signed-off-by: Colin Cross <ccross@android.com>
    [Olof: Fixed up merge conflicts]
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

diff --git a/arch/arm/mach-tegra/include/mach/sdhci.h b/arch/arm/mach-tegra/include/mach/sdhci.h
new file mode 100644
index 0000000..34e2686
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/sdhci.h
@@ -0,0 +1,33 @@
+/*
+ * include/asm-arm/arch-tegra/sdhci.h
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ * Author: Yvonne Yip <y@palm.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef __ASM_ARM_ARCH_TEGRA_SDHCI_H
+#define __ASM_ARM_ARCH_TEGRA_SDHCI_H
+
+#include <linux/mmc/host.h>
+
+struct tegra_sdhci_platform_data {
+	const char *clk_id;
+	int force_hs;
+	int cd_gpio;
+	int wp_gpio;
+	int power_gpio;
+
+	void (*board_probe)(int id, struct mmc_host *);
+	void (*board_remove)(int id, struct mmc_host *);
+};
+
+#endif
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b9dee28..85c473e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -229,11 +229,13 @@ static int sdio_enable_hs(struct mmc_card *card)
 	int ret;
 	u8 speed;
 
-	if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
-		return 0;
+	if (!(card->host->caps & MMC_CAP_FORCE_HS)) {
+		if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
+			return 0;
 
-	if (!card->cccr.high_speed)
-		return 0;
+		if (!card->cccr.high_speed)
+			return 0;
+	}
 
 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, 0, &speed);
 	if (ret)
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f06d06e..357c294 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -382,6 +382,12 @@ config MMC_TMIO
 	  This provides support for the SD/MMC cell found in TC6393XB,
 	  T7L66XB and also HTC ASIC3
 
+config MMC_SDHCI_TEGRA
+	tristate "Tegra SD/MMC Controller Support"
+	depends on ARCH_TEGRA && MMC_SDHCI
+	help
+	  This selects the Tegra SD/MMC controller.
+
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e30c2ee..fb04448 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PLTFM)	+= sdhci-pltfm.o
 obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
+obj-$(CONFIG_MMC_SDHCI_TEGRA)	+= sdhci-tegra.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
new file mode 100644
index 0000000..5e2a1f1
--- /dev/null
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -0,0 +1,217 @@
+/*
+ * drivers/mmc/host/sdhci-tegra.c
+ *
+ * Copyright (C) 2009 Palm, Inc.
+ * Author: Yvonne Yip <y@palm.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/sdhci.h>
+
+#include "sdhci.h"
+
+#define DRIVER_NAME    "sdhci-tegra"
+
+struct tegra_sdhci_host {
+	struct sdhci_host *sdhci;
+	struct clk *clk;
+};
+
+static irqreturn_t carddetect_irq(int irq, void *data)
+{
+	struct sdhci_host *sdhost = (struct sdhci_host *)data;
+
+	sdhci_card_detect_callback(sdhost);
+	return IRQ_HANDLED;
+};
+
+static int tegra_sdhci_enable_dma(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct tegra_sdhci_host *tegra_host = sdhci_priv(host);
+	host->max_clk = clk_get_rate(tegra_host->clk);
+}
+
+static struct sdhci_ops tegra_sdhci_ops = {
+	.enable_dma = tegra_sdhci_enable_dma,
+	.set_clock  = tegra_sdhci_set_clock,
+};
+
+static int __devinit tegra_sdhci_probe(struct platform_device *pdev)
+{
+	int rc;
+	struct tegra_sdhci_platform_data *plat;
+	struct sdhci_host *sdhci;
+	struct tegra_sdhci_host *host;
+	struct resource *res;
+	int irq;
+	void __iomem *ioaddr;
+
+	plat = pdev->dev.platform_data;
+	if (plat == NULL)
+		return -ENXIO;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res == NULL)
+		return -ENODEV;
+
+	irq = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENODEV;
+
+	ioaddr = ioremap(res->start, res->end - res->start);
+
+	sdhci = sdhci_alloc_host(&pdev->dev, sizeof(struct tegra_sdhci_host));
+	if (IS_ERR(sdhci)) {
+		rc = PTR_ERR(sdhci);
+		goto err_unmap;
+	}
+
+	host = sdhci_priv(sdhci);
+	host->sdhci = sdhci;
+
+	host->clk = clk_get(&pdev->dev, plat->clk_id);
+	if (IS_ERR(host->clk)) {
+		rc = PTR_ERR(host->clk);
+		goto err_free_host;
+	}
+
+	rc = clk_enable(host->clk);
+	if (rc != 0)
+		goto err_clkput;
+
+	sdhci->hw_name = "tegra";
+	sdhci->ops = &tegra_sdhci_ops;
+	sdhci->irq = irq;
+	sdhci->ioaddr = ioaddr;
+	sdhci->version = SDHCI_SPEC_200;
+	sdhci->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+			SDHCI_QUIRK_SINGLE_POWER_WRITE |
+			SDHCI_QUIRK_ENABLE_INTERRUPT_AT_BLOCK_GAP |
+			SDHCI_QUIRK_BROKEN_WRITE_PROTECT |
+			SDHCI_QUIRK_BROKEN_CTRL_HISPD |
+			SDHCI_QUIRK_8_BIT_DATA |
+			SDHCI_QUIRK_NO_VERSION_REG |
+			SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+			SDHCI_QUIRK_NO_SDIO_IRQ;
+
+	if (plat->force_hs != 0)
+		sdhci->quirks |= SDHCI_QUIRK_FORCE_HIGH_SPEED_MODE;
+
+	rc = sdhci_add_host(sdhci);
+	if (rc)
+		goto err_clk_disable;
+
+	platform_set_drvdata(pdev, host);
+
+	if (plat->cd_gpio) {
+		rc = request_irq(gpio_to_irq(plat->cd_gpio), carddetect_irq,
+			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			mmc_hostname(sdhci->mmc), sdhci);
+
+		if (rc)
+			goto err_remove_host;
+	}
+
+	if (plat->board_probe)
+		plat->board_probe(pdev->id, sdhci->mmc);
+
+	printk(KERN_INFO "sdhci%d: initialized irq %d ioaddr %p\n", pdev->id,
+			sdhci->irq, sdhci->ioaddr);
+
+	return 0;
+
+err_remove_host:
+	sdhci_remove_host(sdhci, 1);
+err_clk_disable:
+	clk_disable(host->clk);
+err_clkput:
+	clk_put(host->clk);
+err_free_host:
+	if (sdhci)
+		sdhci_free_host(sdhci);
+err_unmap:
+	iounmap(sdhci->ioaddr);
+
+	return rc;
+}
+
+static int tegra_sdhci_remove(struct platform_device *pdev)
+{
+	struct tegra_sdhci_host *host = platform_get_drvdata(pdev);
+	if (host) {
+		struct tegra_sdhci_platform_data *plat;
+		plat = pdev->dev.platform_data;
+		if (plat && plat->board_probe)
+			plat->board_probe(pdev->id, host->sdhci->mmc);
+
+		sdhci_remove_host(host->sdhci, 0);
+		sdhci_free_host(host->sdhci);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tegra_sdhci_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	return -1;
+}
+
+static int tegra_sdhci_resume(struct platform_device *pdev)
+{
+	return -1;
+}
+#else
+#define tegra_sdhci_suspend    NULL
+#define tegra_sdhci_resume     NULL
+#endif
+
+static struct platform_driver tegra_sdhci_driver = {
+	.probe = tegra_sdhci_probe,
+	.remove = tegra_sdhci_remove,
+	.suspend = tegra_sdhci_suspend,
+	.resume = tegra_sdhci_resume,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init tegra_sdhci_init(void)
+{
+	return platform_driver_register(&tegra_sdhci_driver);
+}
+
+static void __exit tegra_sdhci_exit(void)
+{
+	platform_driver_unregister(&tegra_sdhci_driver);
+}
+
+module_init(tegra_sdhci_init);
+module_exit(tegra_sdhci_exit);
+
+MODULE_DESCRIPTION("Tegra SDHCI controller driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..4af24d6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1024,6 +1024,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 out:
+
 	host->clock = clock;
 }
 
@@ -1159,15 +1160,18 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
-	if (ios->bus_width == MMC_BUS_WIDTH_4)
+	ctrl &= ~(SDHCI_CTRL_8BITBUS|SDHCI_CTRL_4BITBUS);
+	if (ios->bus_width == MMC_BUS_WIDTH_8)
+		ctrl |= SDHCI_CTRL_8BITBUS;
+	else if (ios->bus_width == MMC_BUS_WIDTH_4)
 		ctrl |= SDHCI_CTRL_4BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS)
-		ctrl |= SDHCI_CTRL_HISPD;
-	else
-		ctrl &= ~SDHCI_CTRL_HISPD;
+	if (!(host->quirks & SDHCI_QUIRK_BROKEN_CTRL_HISPD)) {
+		if (ios->timing == MMC_TIMING_SD_HS)
+			ctrl |= SDHCI_CTRL_HISPD;
+		else
+			ctrl &= ~SDHCI_CTRL_HISPD;
+	}
 
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
@@ -1194,16 +1198,22 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	if (host->flags & SDHCI_DEVICE_DEAD)
+	if (host->flags & SDHCI_DEVICE_DEAD) {
 		present = 0;
-	else
+	} else if (!(host->quirks & SDHCI_QUIRK_BROKEN_WRITE_PROTECT)) {
 		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		present = !(present & SDHCI_WRITE_PROTECT);
+	} else if (host->ops->get_ro) {
+		present = host->ops->get_ro(host);
+	} else {
+		present = 0;
+	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
 		return !!(present & SDHCI_WRITE_PROTECT);
-	return !(present & SDHCI_WRITE_PROTECT);
+	return present;
 }
 
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
@@ -1222,6 +1232,16 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
 	else
 		sdhci_mask_irqs(host, SDHCI_INT_CARD_INT);
+
+	if (host->quirks & SDHCI_QUIRK_ENABLE_INTERRUPT_AT_BLOCK_GAP) {
+		u8 gap_ctrl = readb(host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
+		if (enable)
+			gap_ctrl |= 0x8;
+		else
+			gap_ctrl &= ~0x8;
+		writeb(gap_ctrl, host->ioaddr + SDHCI_BLOCK_GAP_CONTROL);
+	}
+
 out:
 	mmiowb();
 
@@ -1235,19 +1255,10 @@ static const struct mmc_host_ops sdhci_ops = {
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 };
 
-/*****************************************************************************\
- *                                                                           *
- * Tasklets                                                                  *
- *                                                                           *
-\*****************************************************************************/
-
-static void sdhci_tasklet_card(unsigned long param)
+void sdhci_card_detect_callback(struct sdhci_host *host)
 {
-	struct sdhci_host *host;
 	unsigned long flags;
 
-	host = (struct sdhci_host*)param;
-
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
@@ -1269,6 +1280,22 @@ static void sdhci_tasklet_card(unsigned long param)
 
 	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }
+EXPORT_SYMBOL_GPL(sdhci_card_detect_callback);
+
+/*****************************************************************************\
+ *                                                                           *
+ * Tasklets                                                                  *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_tasklet_card(unsigned long param)
+{
+	struct sdhci_host *host;
+
+	host = (struct sdhci_host *)param;
+
+	sdhci_card_detect_callback(host);
+}
 
 static void sdhci_tasklet_finish(unsigned long param)
 {
@@ -1380,7 +1407,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		host->cmd->error = -EILSEQ;
 
 	if (host->cmd->error) {
-		tasklet_schedule(&host->finish_tasklet);
+		if (intmask & SDHCI_INT_RESPONSE)
+			tasklet_schedule(&host->finish_tasklet);
 		return;
 	}
 
@@ -1678,9 +1706,12 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_reset(host, SDHCI_RESET_ALL);
 
-	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
-	host->version = (host->version & SDHCI_SPEC_VER_MASK)
-				>> SDHCI_SPEC_VER_SHIFT;
+	if (!(host->quirks & SDHCI_QUIRK_NO_VERSION_REG)) {
+		host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
+		host->version = (host->version & SDHCI_SPEC_VER_MASK)
+					>> SDHCI_SPEC_VER_SHIFT;
+	}
+
 	if (host->version > SDHCI_SPEC_200) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
@@ -1791,13 +1822,24 @@ int sdhci_add_host(struct sdhci_host *host)
 	else
 		mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
-	mmc->caps = MMC_CAP_SDIO_IRQ;
+	mmc->caps = 0;
 
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
+	if (host->quirks & SDHCI_QUIRK_8_BIT_DATA)
+		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	else if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	if (caps & SDHCI_CAN_DO_HISPD)
+
+	if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+
+	if (caps & SDHCI_CAN_DO_HISPD) {
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
+	}
+
+	if (host->quirks & SDHCI_QUIRK_FORCE_HIGH_SPEED_MODE)
+		mmc->caps |= MMC_CAP_FORCE_HS;
 
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
@@ -1841,10 +1883,14 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * of bytes. When doing hardware scatter/gather, each entry cannot
 	 * be larger than 64 KiB though.
 	 */
-	if (host->flags & SDHCI_USE_ADMA)
-		mmc->max_seg_size = 65536;
-	else
+	if (host->flags & SDHCI_USE_ADMA) {
+		if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC)
+			mmc->max_seg_size = 0xffff;
+		else
+			mmc->max_seg_size = 65536;
+	} else {
 		mmc->max_seg_size = mmc->max_req_size;
+	}
 
 	/*
 	 * Maximum block size. This varies from controller to controller and
@@ -1868,7 +1914,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Maximum block count.
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
-
+	
 	/*
 	 * Init tasklets.
 	 */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..2c8a83a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -66,6 +66,7 @@
 #define SDHCI_HOST_CONTROL 	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
+#define  SDHCI_CTRL_8BITBUS	0x20
 #define  SDHCI_CTRL_HISPD	0x04
 #define  SDHCI_CTRL_DMA_MASK	0x18
 #define   SDHCI_CTRL_SDMA	0x00
@@ -184,7 +185,7 @@ struct sdhci_host {
 	/* Data set by hardware interface driver */
 	const char		*hw_name;	/* Hardware bus name */
 
-	unsigned int		quirks;		/* Deviations from spec. */
+	u64			quirks;		/* Deviations from spec. */
 
 /* Controller doesn't honor resets unless we touch the clock register */
 #define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
@@ -240,6 +241,22 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller write protect bit is broken. Assume no write protection */
+#define SDHCI_QUIRK_BROKEN_WRITE_PROTECT		(1<<27)
+/* Controller needs INTERRUPT_AT_BLOCK_GAP enabled to detect card interrupts */
+#define SDHCI_QUIRK_ENABLE_INTERRUPT_AT_BLOCK_GAP	(1<<28)
+/* Controller should not program HIGH_SPEED_EN after switching to high speed */
+#define SDHCI_QUIRK_BROKEN_CTRL_HISPD			(1<<29)
+/* Controller supports 8-bit data width */
+#define SDHCI_QUIRK_8_BIT_DATA				(1<<30)
+/* Controller has no version register */
+#define SDHCI_QUIRK_NO_VERSION_REG			(1<<31)
+/* Controller treats ADMA descriptors with length 0000h incorrectly */
+#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1LL<<32)
+/* Controller should not use SDIO IRQ */
+#define SDHCI_QUIRK_NO_SDIO_IRQ				(1LL<<33)
+/* Controller should only use high-speed mode */
+#define SDHCI_QUIRK_FORCE_HIGH_SPEED_MODE		(1LL<<34)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -309,6 +326,7 @@ struct sdhci_ops {
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 
 	int		(*enable_dma)(struct sdhci_host *host);
+	int		(*get_ro)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
@@ -401,6 +419,7 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	size_t priv_size);
 extern void sdhci_free_host(struct sdhci_host *host);
+extern void sdhci_card_detect_callback(struct sdhci_host *host);
 
 static inline void *sdhci_priv(struct sdhci_host *host)
 {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f65913c..9ab146a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -155,6 +155,7 @@ struct mmc_host {
 #define MMC_CAP_DISABLE		(1 << 7)	/* Can the host be disabled */
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
+#define MMC_CAP_FORCE_HS	(1 << 10)	/* Must enable highspeed mode */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 

