From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 4/4] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Wed, 15 Jun 2016 13:01:57 +0900
Message-ID: <1465963317-28672-5-git-send-email-horms+renesas@verge.net.au>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47886 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcFOECj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 00:02:39 -0400
In-Reply-To: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

R-Car Gen3 has a dedicated DMA controller for SDHI module. Since
the DMAC is in a part of SDHI module and is not suitable as dmaengine,
this patch adds a different code as tmio_mmc_dma_gen3.c.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
---
v1 [Simon Horman]
* Use newly introduced tmio_set_dma_ops() to allow driver
  to be compiled along side non-Gen3 SDHI DMA driver
  - - Use renesas_sdhi_dma_gen3.c rather than tmio_mmc_dma_gen3.c
      as source file name as driver is now attached to renesas_sdhi
      rather than tmio_core driver.
* Remove debugging code

v0 [Yoshihiro Shimoda]
---
 drivers/mmc/host/Kconfig                 |   9 ++
 drivers/mmc/host/Makefile                |   1 +
 drivers/mmc/host/renesas_sdhi.c          |  32 +++++-
 drivers/mmc/host/renesas_sdhi_dma_gen3.c | 190 +++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_dma_gen3.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7ccae04632aa..5b9af094daba 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -565,6 +565,7 @@ config MMC_SDHI
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	select MMC_SDHI_DMA if (SUPERH || ARM)
+	select MMC_SDHI_DMA_GEN3 if ARM64
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  SuperH, and Renesas ARM and arm64 based SoCs.
@@ -577,6 +578,14 @@ config MMC_SDHI_DMA
 	  This provides DMA support for the DMA support the SDHI SD/SDIO
 	  found in SuperH and Renesas ARM based SoCs.
 
+config MMC_SDHI_DMA_GEN3
+	tristate "DMA support for R-Car Gen3 Renesas SDHI SD/SDIO controller"
+	depends on ARM64
+	depends on MMC_SDHI
+	help
+	  This provides DMA support for the DMA support the SDHI SD/SDIO
+	  found in Renesas ARM and arm64 based SoCs.
+
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 0ea7fb6f3d5e..5557203ce8b9 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi.o
 renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA))	+= renesas_sdhi_dma.o
+renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA_GEN3))	+= renesas_sdhi_dma_gen3.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/renesas_sdhi.c b/drivers/mmc/host/renesas_sdhi.c
index 4403dfe1413d..74fe25bfe5c4 100644
--- a/drivers/mmc/host/renesas_sdhi.c
+++ b/drivers/mmc/host/renesas_sdhi.c
@@ -47,6 +47,11 @@
 
 #define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
 
+enum tmio_mmc_dma_type {
+	TMIO_MMC_DMA_TYPE_DEFAULT	= 0,
+	TMIO_MMC_DMA_TYPE_GEN3,
+};
+
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 	unsigned long capabilities;
@@ -54,6 +59,7 @@ struct sh_mobile_sdhi_of_data {
 	enum dma_slave_buswidth dma_buswidth;
 	dma_addr_t dma_rx_offset;
 	unsigned bus_shift;
+	enum tmio_mmc_dma_type dma_type;
 };
 
 static const struct sh_mobile_sdhi_of_data of_default_cfg = {
@@ -79,6 +85,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.bus_shift	= 2,
+	.dma_type	= TMIO_MMC_DMA_TYPE_GEN3,
 };
 
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
@@ -115,6 +122,27 @@ static int tmio_mmc_init_dma(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_MMC_SDHI_DMA_GEN3)
+int tmio_mmc_init_dma_gen3(void);
+#else
+static int tmio_mmc_init_dma_gen3(void)
+{
+	return -EINVAL;
+}
+#endif
+
+static int sh_mobile_sdhi_init_dma(enum tmio_mmc_dma_type dma_type)
+{
+	switch (dma_type) {
+	case TMIO_MMC_DMA_TYPE_DEFAULT:
+		return tmio_mmc_init_dma_gen3();
+
+	case TMIO_MMC_DMA_TYPE_GEN3:
+	default:
+		return tmio_mmc_init_dma();
+	}
+}
+
 static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 {
 	u32 val;
@@ -321,6 +349,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
+	enum tmio_mmc_dma_type dma_type = TMIO_MMC_DMA_TYPE_DEFAULT;
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -370,9 +399,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
+		dma_type = of_data->dma_type;
 	}
 
-	ret = tmio_mmc_init_dma();
+	ret = sh_mobile_sdhi_init_dma(dma_type);
 	if (ret < 0)
 		goto efree;
 
diff --git a/drivers/mmc/host/renesas_sdhi_dma_gen3.c b/drivers/mmc/host/renesas_sdhi_dma_gen3.c
new file mode 100644
index 000000000000..55d6a65e12b3
--- /dev/null
+++ b/drivers/mmc/host/renesas_sdhi_dma_gen3.c
@@ -0,0 +1,190 @@
+/*
+ * linux/drivers/mmc/tmio_mmc_dma_gen3.c
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * R-Car Gen3 DMA function for TMIO MMC implementations
+ */
+
+#include <linux/bug.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/pagemap.h>
+#include <linux/scatterlist.h>
+
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
+static void tmio_dm_write(struct tmio_mmc_host *host, int addr, u64 val)
+{
+	writeq(val, host->ctl + addr);
+}
+
+static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+	if (!host->chan_tx || !host->chan_rx)
+		return;
+
+	if (host->dma->enable)
+		host->dma->enable(host, enable);
+}
+
+static void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+{
+	u64 val = RST_DTRANRST1 | RST_DTRANRST0;
+
+	tmio_mmc_enable_dma(host, false);
+
+	tmio_dm_write(host, DM_CM_RST, RST_RESERVED_BITS & ~val);
+	tmio_dm_write(host, DM_CM_RST, RST_RESERVED_BITS | val);
+
+	tmio_mmc_enable_dma(host, true);
+}
+
+static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+			       struct mmc_data *data)
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
+	tmio_mmc_enable_dma(host, true);
+
+	/* disable PIO irqs to avoid "PIO IRQ in DMA mode!" */
+	tmio_mmc_disable_mmc_irqs(host, irq_mask);
+
+	/* set dma parameters */
+	tmio_dm_write(host, DM_CM_DTRAN_MODE, dtran_mode);
+	tmio_dm_write(host, DM_DTRAN_ADDR, sg->dma_address);
+}
+
+static void tmio_mmc_issue_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+
+	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
+
+	/* start the DMAC */
+	tmio_dm_write(host, DM_CM_DTRAN_CTRL, DTRAN_CTRL_DM_START);
+}
+
+static void tmio_mmc_complete_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+	enum dma_data_direction dir;
+
+	if (!host->data)
+		return;
+
+	if (host->data->flags & MMC_DATA_READ)
+		dir = DMA_FROM_DEVICE;
+	else
+		dir = DMA_TO_DEVICE;
+
+	dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->sg_len, dir);
+	tmio_mmc_do_data_irq(host);
+}
+
+static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+			  struct tmio_mmc_data *pdata)
+{
+	/* Each value is set to non-zero to assume "enabling" each DMA */
+	host->chan_rx = host->chan_tx = (void *)0xdeadbeaf;
+
+	tasklet_init(&host->dma_complete, tmio_mmc_complete_tasklet_fn,
+		     (unsigned long)host);
+	tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn,
+		     (unsigned long)host);
+}
+
+static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+{
+	/* Each value is set to zero to assume "disabling" each DMA */
+	host->chan_rx = host->chan_tx = NULL;
+}
+
+static struct tmio_mmc_dma_ops tmio_mmc_dma_ops __initdata = {
+	.start = tmio_mmc_start_dma,
+	.enable = tmio_mmc_enable_dma,
+	.request = tmio_mmc_request_dma,
+	.release = tmio_mmc_release_dma,
+	.abort = tmio_mmc_abort_dma,
+};
+
+int tmio_mmc_init_dma_gen3(void)
+{
+	tmio_set_dma_ops(&tmio_mmc_dma_ops);
+
+	return 0;
+}
-- 
2.1.4

