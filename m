From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v3 5/6] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Wed,  6 Jul 2016 22:23:29 +0200
Message-ID: <1467836610-18539-6-git-send-email-horms+renesas@verge.net.au>
References: <1467836610-18539-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43971 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811AbcGFUYE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2016 16:24:04 -0400
In-Reply-To: <1467836610-18539-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

R-Car Gen3 has a dedicated DMA controller for SDHI module. Since
the DMAC is in a part of SDHI module and is not suitable as dmaengine,
this patch adds a different code as tmio_mmc_dma_gen3.c.

Clearing of DM_CM_INFO1 after DMA thanks to Dirk Behme

Cc: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
---
v3 [Simon Horman]
* Add missing sdhi_internal_dmac_enable_dma() calls to
  sdhi_internal_dmac_start_dma() and sdhi_internal_dmac_complete_tasklet_fn()
* Clear DM_CM_INFO1 after DMA
* Allow fallback to PIO

v2 [Simon Horman]
* Correct build error in Mekefile
* Correct inverted logic in sh_mobile_sdhi_init_dma()
* Use renesas_sdhi_internal_dmac.c as new file name to better reflect
  the contents.

v1 [Simon Horman]
* Use newly introduced tmio_set_dma_ops() to allow driver
  to be compiled along side non-Gen3 SDHI DMA driver
  - - Use renesas_sdhi_dma_gen3.c rather than tmio_mmc_dma_gen3.c
      as source file name as driver is now attached to renesas_sdhi
      rather than tmio_core driver.
* Remove debugging code

v0 [Yoshihiro Shimoda]
---
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/Makefile                     |   3 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 196 ++++++++++++++++++++++++++
 drivers/mmc/host/sh_mobile_sdhi.c             |  28 +++-
 4 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fd3c4b2a0576..0d56a4928abf 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -555,6 +555,7 @@ config MMC_SDHI
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
+	select MMC_SDHI_INTERNAL_DMA if ARM64
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  SuperH and ARM SH-Mobile SoCs
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 5a67643d5e3d..451bbeee0d2a 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
 ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYS_DMAC)),y)
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_sys_dmac.o
 endif
+ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_INTERNAL_DMA)),y)
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_internal_dmac.o
+endif
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
new file mode 100644
index 000000000000..2868d8d439fd
--- /dev/null
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -0,0 +1,196 @@
+/*
+ * linux/drivers/mmc/renesas_sdhi_internal_dmac.c
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
+static void tmio_dm_write(struct tmio_mmc_host *host, int addr, u64 val)
+{
+	writeq(val, host->ctl + addr);
+}
+
+static void sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host,
+					  bool enable)
+{
+	if (!host->chan_tx || !host->chan_rx)
+		return;
+
+	if (!enable)
+		tmio_dm_write(host, DM_CM_INFO1, INFO1_CLEAR);
+
+	if (host->dma->enable)
+		host->dma->enable(host, enable);
+}
+
+static void sdhi_internal_dmac_abort_dma(struct tmio_mmc_host *host)
+{
+	u64 val = RST_DTRANRST1 | RST_DTRANRST0;
+
+	sdhi_internal_dmac_enable_dma(host, false);
+
+	tmio_dm_write(host, DM_CM_RST, RST_RESERVED_BITS & ~val);
+	tmio_dm_write(host, DM_CM_RST, RST_RESERVED_BITS | val);
+
+	sdhi_internal_dmac_enable_dma(host, true);
+}
+
+static void sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
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
+		sdhi_internal_dmac_enable_dma(host, false);
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
+	sdhi_internal_dmac_enable_dma(host, true);
+
+	/* disable PIO irqs to avoid "PIO IRQ in DMA mode!" */
+	tmio_mmc_disable_mmc_irqs(host, irq_mask);
+
+	/* set dma parameters */
+	tmio_dm_write(host, DM_CM_DTRAN_MODE, dtran_mode);
+	tmio_dm_write(host, DM_DTRAN_ADDR, sg->dma_address);
+}
+
+static void sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+
+	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
+
+	/* start the DMAC */
+	tmio_dm_write(host, DM_CM_DTRAN_CTRL, DTRAN_CTRL_DM_START);
+}
+
+static void sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
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
+	sdhi_internal_dmac_enable_dma(host, false);
+	dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->sg_len, dir);
+	tmio_mmc_do_data_irq(host);
+}
+
+static void sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
+					   struct tmio_mmc_data *pdata)
+{
+	/* Each value is set to non-zero to assume "enabling" each DMA */
+	host->chan_rx = host->chan_tx = (void *)0xdeadbeaf;
+
+	tasklet_init(&host->dma_complete,
+		     sdhi_internal_dmac_complete_tasklet_fn,
+		     (unsigned long)host);
+	tasklet_init(&host->dma_issue, sdhi_internal_dmac_issue_tasklet_fn,
+		     (unsigned long)host);
+}
+
+static void sdhi_internal_dmac_release_dma(struct tmio_mmc_host *host)
+{
+	/* Each value is set to zero to assume "disabling" each DMA */
+	host->chan_rx = host->chan_tx = NULL;
+}
+
+static struct tmio_mmc_dma_ops sdhi_internal_dmac_dma_ops = {
+	.start = sdhi_internal_dmac_start_dma,
+	.enable = sdhi_internal_dmac_enable_dma,
+	.request = sdhi_internal_dmac_request_dma,
+	.release = sdhi_internal_dmac_release_dma,
+	.abort = sdhi_internal_dmac_abort_dma,
+};
+
+void sdhi_internal_dmac_init_dma(void)
+{
+	tmio_set_dma_ops(&sdhi_internal_dmac_dma_ops);
+}
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 83ca6cb78484..e76b0afb854f 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -47,6 +47,11 @@
 
 #define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
 
+enum tmio_mmc_dmac_type {
+	TMIO_MMC_SYSC_DMAC	= 0,
+	TMIO_MMC_INTERNAL_DMAC,
+};
+
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 	unsigned long capabilities;
@@ -56,6 +61,7 @@ struct sh_mobile_sdhi_of_data {
 	unsigned bus_shift;
 	unsigned int max_blk_count;
 	unsigned short max_segs;
+	enum tmio_mmc_dmac_type dmac_type;
 };
 
 static const struct sh_mobile_sdhi_of_data of_default_cfg = {
@@ -84,6 +90,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 	/* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
 	.max_blk_count  = 0xffffffff,
 	.max_segs = 1,
+	.dmac_type	= TMIO_MMC_INTERNAL_DMAC,
 };
 
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
@@ -117,6 +124,23 @@ void sdhi_sys_dmac_init_dma(void);
 static void sdhi_sys_dmac_init_dma(void) { }
 #endif
 
+#if IS_ENABLED(CONFIG_MMC_SDHI_INTERNAL_DMA)
+void sdhi_internal_dmac_init_dma(void);
+#else
+static void sdhi_internal_dmac_init_dma(void) { }
+#endif
+
+static void sh_mobile_sdhi_init_dma(enum tmio_mmc_dmac_type dmac_type)
+{
+	switch (dmac_type) {
+	case TMIO_MMC_INTERNAL_DMAC:
+		return sdhi_internal_dmac_init_dma();
+
+	case TMIO_MMC_SYSC_DMAC:
+		return sdhi_sys_dmac_init_dma();
+	}
+}
+
 static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 {
 	u32 val;
@@ -323,6 +347,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
 		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
+	enum tmio_mmc_dmac_type dmac_type = TMIO_MMC_SYSC_DMAC;
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -374,9 +399,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->max_segs = of_data->max_segs;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
+		dmac_type = of_data->dmac_type;
 	}
 
-	sdhi_sys_dmac_init_dma();
+	sh_mobile_sdhi_init_dma(dmac_type);
 
 	host->dma		= dma_priv;
 	host->write16_hook	= sh_mobile_sdhi_write16_hook;
-- 
2.7.0.rc3.207.g0ac5344

