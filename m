From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v2 3/4] mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Fri, 16 Jun 2017 11:58:53 +0200
Message-ID: <1497607134-10241-4-git-send-email-horms+renesas@verge.net.au>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45944 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbdFPJ7I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2017 05:59:08 -0400
In-Reply-To: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>

Add a new variant of the SDHI driver to support R-Car Gen3 with DMA via
on-chip bus mastering.  Since the DMAC is in a part of the SDHI module it
is not suitable to be used via DMA Engine.

Clearing of DM_CM_INFO1 after DMA thanks to Dirk Behme

Cc: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
---
v2
* Enhanced help text and changelog
---
 drivers/mmc/host/Kconfig                      |  19 ++
 drivers/mmc/host/Makefile                     |   8 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 275 ++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   2 +-
 drivers/mmc/host/tmio_mmc.h                   |   1 +
 5 files changed, 303 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5755b69f2f72..81c81ed19735 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -575,10 +575,29 @@ config MMC_SDHI
 	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
+	select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
+	select MMC_SDHI_INTERNAL_DMAC if ARM64
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
 
+config MMC_SDHI_SYS_DMAC
+	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
+	depends on MMC_SDHI
+	help
+	  This provides DMA support for SDHI SD/SDIO controllers
+	  using SYS-DMAC via DMA Engine. This supports the controllers
+	  found in SuperH and Renesas ARM based SoCs.
+
+config MMC_SDHI_INTERNAL_DMAC
+	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
+	depends on ARM64 || COMPILE_TEST
+	depends on MMC_SDHI
+	help
+	  This provides DMA support for SDHI SD/SDIO controllers
+	  using on-chip bus mastering. This supports the controllers
+	  found in arm64 based SoCs.
+
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4d4547116311..8c46766c000c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,7 +36,13 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
-obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o renesas_sdhi_sys_dmac.o
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o
+ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYS_DMAC)),y)
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_sys_dmac.o
+endif
+ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_INTERNAL_DMAC)),y)
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_internal_dmac.o
+endif
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
new file mode 100644
index 000000000000..a16b616a2c96
--- /dev/null
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -0,0 +1,275 @@
+/*
+ * DMA support for Internal DMAC with SDHI SD/SDIO controller
+ *
+ * Copyright (C) 2016-17 Renesas Electronics Corporation
+ * Copyright (C) 2016-17 Horms Solutions, Simon Horman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/scatterlist.h>
+
+#include "renesas_sdhi.h"
+#include "tmio_mmc.h"
+
+#define DM_CM_DTRAN_MODE	0x820
+#define DM_CM_DTRAN_CTRL	0x828
+#define DM_CM_RST		0x830
+#define DM_CM_INFO1		0x840
+#define DM_CM_INFO1_MASK	0x848
+#define DM_CM_INFO2		0x850
+#define DM_CM_INFO2_MASK	0x858
+#define DM_DTRAN_ADDR		0x880
+
+/* DM_CM_DTRAN_MODE */
+#define DTRAN_MODE_CH_NUM_CH0	0	/* "downstream" = for write commands */
+#define DTRAN_MODE_CH_NUM_CH1	BIT(16)	/* "uptream" = for read commands */
+#define DTRAN_MODE_BUS_WID_TH	(BIT(5) | BIT(4))
+#define DTRAN_MODE_ADDR_MODE	BIT(0)	/* 1 = Increment address */
+
+/* DM_CM_DTRAN_CTRL */
+#define DTRAN_CTRL_DM_START	BIT(0)
+
+/* DM_CM_RST */
+#define RST_DTRANRST1		BIT(9)
+#define RST_DTRANRST0		BIT(8)
+#define RST_RESERVED_BITS	GENMASK_ULL(32, 0)
+
+/* DM_CM_INFO1 and DM_CM_INFO1_MASK */
+#define INFO1_CLEAR		0
+#define INFO1_DTRANEND1		BIT(17)
+#define INFO1_DTRANEND0		BIT(16)
+
+/* DM_CM_INFO2 and DM_CM_INFO2_MASK */
+#define INFO2_DTRANERR1		BIT(17)
+#define INFO2_DTRANERR0		BIT(16)
+
+/*
+ * Specification of this driver:
+ * - host->chan_{rx,tx} will be used as a flag of enabling/disabling the dma
+ * - Since this SDHI DMAC register set has actual 32-bit and "bus_shift" is 2,
+ *   this driver cannot use original sd_ctrl_{write,read}32 functions.
+ */
+
+/* Definitions for sampling clocks */
+static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_CMD23,
+	.bus_shift	= 2,
+	.scc_offset	= 0x1000,
+	.taps		= rcar_gen3_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
+	/* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
+	.max_blk_count	= 0xffffffff,
+	.max_segs	= 1,
+};
+
+static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
+	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7796", .data = &of_rcar_gen3_compatible, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
+
+static void
+renesas_sdhi_internal_dmac_dm_write(struct tmio_mmc_host *host,
+				    int addr, u64 val)
+{
+	writeq(val, host->ctl + addr);
+}
+
+static void
+renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+	if (!host->chan_tx || !host->chan_rx)
+		return;
+
+	if (!enable)
+		renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO1,
+						    INFO1_CLEAR);
+
+	if (host->dma->enable)
+		host->dma->enable(host, enable);
+}
+
+static void
+renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host) {
+	u64 val = RST_DTRANRST1 | RST_DTRANRST0;
+
+	renesas_sdhi_internal_dmac_enable_dma(host, false);
+
+	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
+					    RST_RESERVED_BITS & ~val);
+	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
+					    RST_RESERVED_BITS | val);
+
+	renesas_sdhi_internal_dmac_enable_dma(host, true);
+}
+
+static void
+renesas_sdhi_internal_dmac_complete_dma(struct tmio_mmc_host *host) {
+	tasklet_schedule(&host->dma_complete);
+}
+
+static void
+renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
+				     struct mmc_data *data)
+{
+	struct scatterlist *sg = host->sg_ptr;
+	u32 dtran_mode = DTRAN_MODE_BUS_WID_TH | DTRAN_MODE_ADDR_MODE;
+	enum dma_data_direction dir;
+	int ret;
+	u32 irq_mask;
+
+	/* This DMAC cannot handle if sg_len is not 1 */
+	WARN_ON(host->sg_len > 1);
+
+	/* This DMAC cannot handle if buffer is not 8-bytes alignment */
+	if (!IS_ALIGNED(sg->offset, 8)) {
+		host->force_pio = true;
+		renesas_sdhi_internal_dmac_enable_dma(host, false);
+		return;
+	}
+
+	if (data->flags & MMC_DATA_READ) {
+		dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
+		dir = DMA_FROM_DEVICE;
+		irq_mask = TMIO_STAT_RXRDY;
+	} else {
+		dtran_mode |= DTRAN_MODE_CH_NUM_CH0;
+		dir = DMA_TO_DEVICE;
+		irq_mask = TMIO_STAT_TXRQ;
+	}
+
+	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, dir);
+	if (ret < 0) {
+		dev_err(&host->pdev->dev, "%s: dma_map_sg failed\n", __func__);
+		return;
+	}
+
+	renesas_sdhi_internal_dmac_enable_dma(host, true);
+
+	/* disable PIO irqs to avoid "PIO IRQ in DMA mode!" */
+	tmio_mmc_disable_mmc_irqs(host, irq_mask);
+
+	/* set dma parameters */
+	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_MODE,
+					    dtran_mode);
+	renesas_sdhi_internal_dmac_dm_write(host, DM_DTRAN_ADDR,
+					    sg->dma_address);
+}
+
+static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+
+	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
+
+	/* start the DMAC */
+	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_CTRL,
+					    DTRAN_CTRL_DM_START);
+}
+
+static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+	enum dma_data_direction dir;
+
+	spin_lock_irq(&host->lock);
+
+	if (!host->data)
+		goto out;
+
+	if (host->data->flags & MMC_DATA_READ)
+		dir = DMA_FROM_DEVICE;
+	else
+		dir = DMA_TO_DEVICE;
+
+	renesas_sdhi_internal_dmac_enable_dma(host, false);
+	dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->sg_len, dir);
+
+	spin_unlock_irq(&host->lock);
+
+	spin_lock_irq(&host->lock);
+	tmio_mmc_do_data_irq(host);
+out:
+	spin_unlock_irq(&host->lock);
+}
+
+static void
+renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
+				       struct tmio_mmc_data *pdata)
+{
+	/* Each value is set to non-zero to assume "enabling" each DMA */
+	host->chan_rx = host->chan_tx = (void *)0xdeadbeaf;
+
+	tasklet_init(&host->dma_complete,
+		     renesas_sdhi_internal_dmac_complete_tasklet_fn,
+		     (unsigned long)host);
+	tasklet_init(&host->dma_issue,
+		     renesas_sdhi_internal_dmac_issue_tasklet_fn,
+		     (unsigned long)host);
+}
+
+static void
+renesas_sdhi_internal_dmac_release_dma(struct tmio_mmc_host *host)
+{
+	/* Each value is set to zero to assume "disabling" each DMA */
+	host->chan_rx = host->chan_tx = NULL;
+}
+
+static struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
+	.start = renesas_sdhi_internal_dmac_start_dma,
+	.enable = renesas_sdhi_internal_dmac_enable_dma,
+	.request = renesas_sdhi_internal_dmac_request_dma,
+	.release = renesas_sdhi_internal_dmac_release_dma,
+	.abort = renesas_sdhi_internal_dmac_abort_dma,
+	.complete = renesas_sdhi_internal_dmac_complete_dma,
+};
+
+static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
+{
+	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
+}
+
+static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+			   tmio_mmc_host_runtime_resume,
+			   NULL)
+};
+
+static struct platform_driver renesas_internal_dmac_sdhi_driver = {
+	.driver		= {
+		.name	= "renesas_sdhi_internal_dmac",
+		.pm	= &renesas_sdhi_internal_dmac_dev_pm_ops,
+		.of_match_table = renesas_sdhi_internal_dmac_of_match,
+	},
+	.probe		= renesas_sdhi_internal_dmac_probe,
+	.remove		= renesas_sdhi_remove,
+};
+
+module_platform_driver(renesas_internal_dmac_sdhi_driver);
+
+MODULE_DESCRIPTION("Renesas SDHI driver for internal DMAC");
+MODULE_AUTHOR("Yoshihiro Shimoda");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 7a85610525b0..d1cfc2370915 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -1,5 +1,5 @@
 /*
- * DMA function for TMIO MMC implementations
+ * DMA support use of SYS DMAC with SDHI SD/SDIO controller
  *
  * Copyright (C) 2016-17 Renesas Electronics Corporation
  * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 89f0e264f02f..bc562b141878 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -152,6 +152,7 @@ struct tmio_mmc_host {
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
 	struct completion	dma_dataend;
+	struct tasklet_struct	dma_complete;
 	struct tasklet_struct	dma_issue;
 	struct scatterlist	bounce_sg;
 	u8			*bounce_buf;
-- 
2.1.4

