From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: add a driver for the Renesas v08r07s01e SD/SDIO host
 controller
Date: Sat, 12 Apr 2014 19:42:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1404121939250.8725@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53834 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaDLRm2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Apr 2014 13:42:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>

This patch adds a driver for the Renesas v08r07s01e SD/SDIO host controller
in both PIO and DMA modes.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Tested on a Xilinx zc706-based board with SD, MMC and SDIO cards.

 .../devicetree/bindings/mmc/v08r07s01e.txt         |   33 +
 drivers/mmc/host/Kconfig                           |    6 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/v08r07s01e.c                      | 1835 ++++++++++++++++++++
 4 files changed, 1875 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/v08r07s01e.txt
 create mode 100644 drivers/mmc/host/v08r07s01e.c

diff --git a/Documentation/devicetree/bindings/mmc/v08r07s01e.txt b/Documentation/devicetree/bindings/mmc/v08r07s01e.txt
new file mode 100644
index 0000000..60e6cb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/v08r07s01e.txt
@@ -0,0 +1,33 @@
+* Renesas v08r07s01e SD/SDIO host controller
+
+Required properties:
+
+- compatible:	must be
+		"renesas,v08r07s01e"
+- interrupts:	3 interrupts, named "card detect", "data" and "SDIO" must be
+		specified
+- clocks:	a clock binding for the IMCLK input
+
+Optional properties:
+
+- vmmc-supply:	a phandle of a regulator, supplying Vcc to the card
+- vqmmc-supply:	a phandle of a regulator, supplying VccQ to the card
+
+Additionally any standard mmc bindings from mmc.txt can be used.
+
+Example:
+
+sd0: sd@ab000000 {
+	compatible = "renesas,v08r07s01e";
+	reg = <0xab000000 0x200>;
+	interrupts = <0 23 0x4
+		      0 24 0x4
+		      0 25 0x4>;
+	interrupt-names = "card detect", "data", "SDIO";
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	cap-power-off-card;
+	clocks = <&imclk>;
+	vmmc-supply = <&vcc_sd0>;
+	vqmmc-supply = <&vccq_sd0>;
+};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8aaf8c1..0feccd5 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -688,6 +688,12 @@ config MMC_WMT
 	  To compile this driver as a module, choose M here: the
 	  module will be called wmt-sdmmc.
 
+config MMC_V08R07S01E
+	tristate "Renesas V08R07S01E SD/SDIO Host Controller support"
+	help
+	  This selects support for the Renesas V08R07S01E SD/SDIO
+	  Host Controller
+
 config MMC_REALTEK_PCI
 	tristate "Realtek PCI-E SD/MMC Card Interface Driver"
 	depends on MFD_RTSX_PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 0c8aa5e..d7d3ee9 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
 obj-$(CONFIG_MMC_USHC)		+= ushc.o
 obj-$(CONFIG_MMC_WMT)		+= wmt-sdmmc.o
+obj-$(CONFIG_MMC_V08R07S01E)	+= v08r07s01e.o
 
 obj-$(CONFIG_MMC_REALTEK_PCI)	+= rtsx_pci_sdmmc.o
 
diff --git a/drivers/mmc/host/v08r07s01e.c b/drivers/mmc/host/v08r07s01e.c
new file mode 100644
index 0000000..4eb9ce1
--- /dev/null
+++ b/drivers/mmc/host/v08r07s01e.c
@@ -0,0 +1,1835 @@
+/*
+ * Copyright (C) 2013-2014 Renesas Europe Ltd.
+ * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/sdio.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/virtio.h>
+#include <linux/workqueue.h>
+
+#define V08R07_SD_CMD		0x0000
+#define V08R07_SD_PORT_SEL	0x0004
+#define V08R07_SD_ARG		0x0008
+#define V08R07_SD_STOP		0x0010
+#define V08R07_SD_SECCNT	0x0014
+#define V08R07_SD_RSP10		0x0018
+#define V08R07_SD_RSP32		0x0020
+#define V08R07_SD_RSP54		0x0028
+#define V08R07_SD_RSP76		0x0030
+#define V08R07_SD_INFO1		0x0038
+#define V08R07_SD_INFO2		0x003c
+#define V08R07_SD_INFO1_MASK	0x0040
+#define V08R07_SD_INFO2_MASK	0x0044
+#define V08R07_SD_CLK_CTRL	0x0048
+#define V08R07_SD_SIZE		0x004c
+#define V08R07_SD_OPTION	0x0050
+#define V08R07_SD_ERR_STS1	0x0058
+#define V08R07_SD_ERR_STS2	0x005c
+#define V08R07_SD_BUF0		0x0060
+#define V08R07_SDIO_MODE	0x0068
+#define V08R07_SDIO_INFO1	0x006c
+#define V08R07_SDIO_INFO1_MASK	0x0070
+#define V08R07_CC_EXT_MODE	0x01b0
+#define V08R07_SOFT_RST		0x01c0
+#define V08R07_VERSION		0x01c4
+#define V08R07_HOST_MODE	0x01c8
+#define V08R07_SDIF_MODE	0x01cc
+
+#define V08R07_SD_CMD_APP		0x0040
+#define V08R07_SD_CMD_MODE_RSP_AUTO	0x0000
+#define V08R07_SD_CMD_MODE_RSP_NONE	0x0300
+#define V08R07_SD_CMD_MODE_RSP_R1	0x0400	/* Also R5, R6, R7 */
+#define V08R07_SD_CMD_MODE_RSP_R1B	0x0500	/* R1b */
+#define V08R07_SD_CMD_MODE_RSP_R2	0x0600
+#define V08R07_SD_CMD_MODE_RSP_R3	0x0700	/* Also R4 */
+#define V08R07_SD_CMD_DATA		0x0800
+#define V08R07_SD_CMD_READ		0x1000
+#define V08R07_SD_CMD_MULTI		0x2000
+#define V08R07_SD_CMD_CMD12_AUTO_OFF	0x4000
+
+#define V08R07_CC_EXT_MODE_SDRW		BIT(1)
+
+#define V08R07_SD_INFO1_RSP_END		BIT(0)
+#define V08R07_SD_INFO1_ACCESS_END	BIT(2)
+#define V08R07_SD_INFO1_CARD_OUT	BIT(3)
+#define V08R07_SD_INFO1_CARD_IN		BIT(4)
+#define V08R07_SD_INFO1_CD		BIT(5)
+#define V08R07_SD_INFO1_WP		BIT(7)
+#define V08R07_SD_INFO1_D3_CARD_OUT	BIT(8)
+#define V08R07_SD_INFO1_D3_CARD_IN	BIT(9)
+
+#define V08R07_SD_INFO2_CMD_ERR		BIT(0)
+#define V08R07_SD_INFO2_CRC_ERR		BIT(1)
+#define V08R07_SD_INFO2_END_ERR		BIT(2)
+#define V08R07_SD_INFO2_TOUT		BIT(3)
+#define V08R07_SD_INFO2_IWA_ERR		BIT(4)
+#define V08R07_SD_INFO2_IRA_ERR		BIT(5)
+#define V08R07_SD_INFO2_RSP_TOUT	BIT(6)
+#define V08R07_SD_INFO2_SDDAT0		BIT(7)
+#define V08R07_SD_INFO2_BRE		BIT(8)
+#define V08R07_SD_INFO2_BWE		BIT(9)
+#define V08R07_SD_INFO2_SCLKDIVEN	BIT(13)
+#define V08R07_SD_INFO2_CBSY		BIT(14)
+#define V08R07_SD_INFO2_ILA		BIT(15)
+
+#define V08R07_SD_INFO1_CARD_INSERT (V08R07_SD_INFO1_CARD_IN | V08R07_SD_INFO1_D3_CARD_IN)
+#define V08R07_SD_INFO1_CARD_EJECT (V08R07_SD_INFO1_CARD_OUT | V08R07_SD_INFO1_D3_CARD_OUT)
+#define V08R07_SD_INFO1_CARD (V08R07_SD_INFO1_CARD_INSERT | V08R07_SD_INFO1_CARD_EJECT)
+#define V08R07_SD_INFO1_CARD_CD (V08R07_SD_INFO1_CARD_IN | V08R07_SD_INFO1_CARD_OUT)
+
+#define V08R07_SD_INFO2_ERR	(V08R07_SD_INFO2_CMD_ERR |	\
+	V08R07_SD_INFO2_CRC_ERR | V08R07_SD_INFO2_END_ERR |	\
+	V08R07_SD_INFO2_TOUT | V08R07_SD_INFO2_IWA_ERR |	\
+	V08R07_SD_INFO2_IRA_ERR | V08R07_SD_INFO2_RSP_TOUT |	\
+	V08R07_SD_INFO2_ILA)
+
+#define V08R07_SD_INFO1_IRQ	(V08R07_SD_INFO1_RSP_END | V08R07_SD_INFO1_ACCESS_END | \
+				 V08R07_SD_INFO1_CARD)
+
+#define V08R07_SD_INFO2_IRQ	(V08R07_SD_INFO2_ERR | V08R07_SD_INFO2_BRE | \
+				 V08R07_SD_INFO2_BWE | 0x0800 | V08R07_SD_INFO2_ILA)
+
+#define V08R07_SD_CLK_CTRL_SCLKEN	BIT(8)
+
+#define V08R07_SD_STOP_STP		BIT(0)
+#define V08R07_SD_STOP_SEC		BIT(8)
+
+#define V08R07_SDIO_INFO1_IOIRQ		BIT(0)
+#define V08R07_SDIO_INFO1_EXPUB52	BIT(14)
+#define V08R07_SDIO_INFO1_EXWT		BIT(15)
+
+#define V08R07_SDIO_INFO1_IRQ	(V08R07_SDIO_INFO1_IOIRQ | 3 | \
+				 V08R07_SDIO_INFO1_EXPUB52 | V08R07_SDIO_INFO1_EXWT)
+
+#define V08R07_MIN_DMA 64
+
+enum v08r07_wait_for {
+	V08R07_WAIT_FOR_REQUEST,
+	V08R07_WAIT_FOR_CMD,
+	V08R07_WAIT_FOR_MREAD,
+	V08R07_WAIT_FOR_MWRITE,
+	V08R07_WAIT_FOR_READ,
+	V08R07_WAIT_FOR_WRITE,
+	V08R07_WAIT_FOR_DATA_END,
+	V08R07_WAIT_FOR_STOP,
+	V08R07_WAIT_FOR_DMA,
+};
+
+struct v08r07_page {
+	struct page *page;
+	void *mapped;		/* mapped page */
+};
+
+struct v08r07_host {
+	struct mmc_host *mmc;
+	struct mmc_request *mrq;
+	void __iomem *base;
+	struct clk *clk;
+
+	/* SG memory handling */
+
+	/* Common for multiple and single block requests */
+	struct v08r07_page pg;	/* current page from an SG */
+	void *blk_page;		/* either a mapped page, or the bounce buffer */
+	size_t offset;		/* offset within a page, including sg->offset */
+
+	/* Blocks, crossing a page boundary */
+	size_t head_len;
+	struct v08r07_page head_pg;
+
+	/* A bounce buffer for unaligned blocks or blocks, crossing a page boundary */
+	struct scatterlist bounce_sg;
+	u8 bounce_buf[512];
+
+	/* Multiple block requests only */
+	struct scatterlist *sg;	/* current SG segment */
+	int page_idx;		/* page index within an SG segment */
+
+	enum v08r07_wait_for wait;
+	u32 status_mask;
+	u32 status2_mask;
+	u32 sdio_mask;
+	u32 io_error;
+	u32 irq_status;
+	unsigned long imclk;
+	unsigned long rate;
+	bool app_cmd;
+
+	/* Timeout handling */
+	struct delayed_work timeout_work;
+	unsigned long timeout;
+
+	/* DMA support */
+	struct dma_chan *chan_rx;
+	struct dma_chan *chan_tx;
+	bool dma_active;
+};
+
+/*			I/O primitives					*/
+
+static void v08r07_write(struct v08r07_host *host, u32 reg, u32 data)
+{
+	iowrite32(data, host->base + reg);
+	dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) = 0x%x\n", __func__,
+		host->base, reg, data);
+}
+
+static void v08r07_write16(struct v08r07_host *host, u32 reg, u16 data)
+{
+	iowrite16(data, host->base + reg);
+	dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) = 0x%x\n", __func__,
+		host->base, reg, data);
+}
+
+static u32 v08r07_read(struct v08r07_host *host, u32 reg)
+{
+	u32 data = ioread32(host->base + reg);
+	dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) = 0x%x\n", __func__,
+		host->base, reg, data);
+	return data;
+}
+
+static u16 v08r07_read16(struct v08r07_host *host, u32 reg)
+{
+	u16 data = ioread16(host->base + reg);
+	dev_vdbg(mmc_dev(host->mmc), "%s(0x%p + 0x%x) = 0x%x\n", __func__,
+		host->base, reg, data);
+	return data;
+}
+
+static void v08r07_irq_enable(struct v08r07_host *host, u32 info1, u32 info2)
+{
+	host->status_mask = V08R07_SD_INFO1_IRQ & ~info1;
+	host->status2_mask = V08R07_SD_INFO2_IRQ & ~info2;
+	v08r07_write(host, V08R07_SD_INFO1_MASK, host->status_mask);
+	v08r07_write(host, V08R07_SD_INFO2_MASK, host->status2_mask);
+}
+
+static void v08r07_wait_for_resp(struct v08r07_host *host)
+{
+	v08r07_irq_enable(host, V08R07_SD_INFO1_RSP_END |
+			  V08R07_SD_INFO1_ACCESS_END | V08R07_SD_INFO1_CARD_CD,
+			  V08R07_SD_INFO2_ERR);
+}
+
+static void v08r07_wait_for_brwe(struct v08r07_host *host, bool read)
+{
+	v08r07_irq_enable(host, V08R07_SD_INFO1_ACCESS_END |
+			  V08R07_SD_INFO1_CARD_CD, V08R07_SD_INFO2_ERR |
+			  (read ? V08R07_SD_INFO2_BRE : V08R07_SD_INFO2_BWE));
+}
+
+static void v08r07_only_cd(struct v08r07_host *host)
+{
+	/* Mask all except card hotplug */
+	v08r07_irq_enable(host, V08R07_SD_INFO1_CARD_CD, 0);
+}
+
+static void v08r07_mask_all(struct v08r07_host *host)
+{
+	v08r07_irq_enable(host, 0, 0);
+}
+
+static int v08r07_error_code(struct v08r07_host *host)
+{
+	u32 err;
+
+	v08r07_write(host, V08R07_SD_STOP, V08R07_SD_STOP_STP);
+
+	if (host->io_error &
+	    (V08R07_SD_INFO2_RSP_TOUT | V08R07_SD_INFO2_TOUT)) {
+		u32 rsp54 = v08r07_read(host, V08R07_SD_RSP54);
+		int opc = host->mrq ? host->mrq->cmd->opcode : -1;
+
+		err = v08r07_read(host, V08R07_SD_ERR_STS2);
+		/* Response timeout is often normal, don't spam the log */
+		if (host->wait == V08R07_WAIT_FOR_CMD)
+			dev_dbg(mmc_dev(host->mmc),
+				"T-out sts 0x%x, resp 0x%x, state %u, CMD%d\n",
+				err, rsp54, host->wait, opc);
+		else
+			dev_warn(mmc_dev(host->mmc),
+				 "T-out sts 0x%x, resp 0x%x, state %u, CMD%d\n",
+				 err, rsp54, host->wait, opc);
+		return -ETIMEDOUT;
+	}
+
+	err = v08r07_read(host, V08R07_SD_ERR_STS1);
+	if (err != 0x2000)
+		dev_warn(mmc_dev(host->mmc), "Err sts 0x%x, state %u, CMD%d\n",
+			 err, host->wait, host->mrq ? host->mrq->cmd->opcode : -1);
+	if (host->io_error & V08R07_SD_INFO2_ILA)
+		return -EILSEQ;
+
+	return -EIO;
+}
+
+/*			Scatter-Gather management			*/
+
+/*
+ * In PIO mode we have to map each page separately, using kmap(). That way
+ * adjacent pages are mapped to non-adjacent virtual addresses. That's why we
+ * have to use a bounce buffer for blocks, crossing page boundaries. Such blocks
+ * have been observed with an SDIO WiFi card (b43 driver).
+ */
+static void v08r07_blk_bounce(struct v08r07_host *host,
+			      struct scatterlist *sg)
+{
+	struct mmc_data *data = host->mrq->data;
+	size_t blk_head = host->head_len;
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): CMD%u of %u SG: %ux%u @ 0x%x\n",
+		__func__, host->mrq->cmd->opcode, data->sg_len,
+		data->blksz, data->blocks, sg->offset);
+
+	host->head_pg.page	= host->pg.page;
+	host->head_pg.mapped	= host->pg.mapped;
+	host->pg.page		= nth_page(host->pg.page, 1);
+	host->pg.mapped		= kmap(host->pg.page);
+
+	host->blk_page = host->bounce_buf;
+	host->offset = 0;
+
+	if (data->flags & MMC_DATA_READ)
+		return;
+
+	memcpy(host->bounce_buf, host->head_pg.mapped + PAGE_SIZE - blk_head,
+	       blk_head);
+	memcpy(host->bounce_buf + blk_head, host->pg.mapped,
+	       data->blksz - blk_head);
+}
+
+/* Only called for multiple block IO */
+static void v08r07_sg_prep(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_data *data = mrq->data;
+
+	v08r07_write(host, V08R07_SD_SECCNT, data->blocks);
+
+	host->sg = data->sg;
+	/* TODO: if we always map, this is redundant */
+	host->offset = host->sg->offset;
+}
+
+/* Map the first page in an SG segment: common for multiple and single block IO */
+static void *v08r07_sg_map(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	struct scatterlist *sg = data->sg_len > 1 ? host->sg : data->sg;
+	size_t head = PAGE_SIZE - sg->offset;
+	size_t blk_head = head % data->blksz;
+
+	WARN(host->pg.page, "%p not properly unmapped!\n", host->pg.page);
+	if (WARN(sg_dma_len(sg) % data->blksz,
+		 "SG size %zd isn't a multiple of block size %zd\n",
+		 sg_dma_len(sg), data->blksz))
+		return NULL;
+
+	host->pg.page = sg_page(sg);
+	host->pg.mapped = kmap(host->pg.page);
+	host->offset = sg->offset;
+
+	/*
+	 * Block size must be a power of 2 for multi-block transfers,
+	 * therefore blk_head is equal for all pages in this SG
+	 */
+	host->head_len = blk_head;
+
+	if (head < data->blksz)
+		/*
+		 * The first block in the SG crosses a page boundary.
+		 * Max blksz = 512, so blocks can only span 2 pages
+		 */
+		v08r07_blk_bounce(host, sg);
+	else
+		host->blk_page = host->pg.mapped;
+
+	dev_dbg(mmc_dev(host->mmc), "Mapped %p (%lx) at %p + %u for CMD%u @ 0x%p\n",
+		host->pg.page, page_to_pfn(host->pg.page), host->pg.mapped,
+		sg->offset, host->mrq->cmd->opcode, host->mrq);
+
+	return host->blk_page + host->offset;
+}
+
+/* Unmap the current page: common for multiple and single block IO */
+static void v08r07_sg_unmap(struct v08r07_host *host, bool force)
+{
+	struct mmc_data *data = host->mrq->data;
+	struct page *page = host->head_pg.page;
+
+	if (page) {
+		/* Previous block was cross-page boundary */
+		struct scatterlist *sg = data->sg_len > 1 ?
+			host->sg : data->sg;
+		size_t blk_head = host->head_len;
+
+		if (!data->error && data->flags & MMC_DATA_READ) {
+			memcpy(host->head_pg.mapped + PAGE_SIZE - blk_head,
+			       host->bounce_buf, blk_head);
+			memcpy(host->pg.mapped, host->bounce_buf + blk_head,
+			       data->blksz - blk_head);
+		}
+
+		flush_dcache_page(page);
+		kunmap(page);
+
+		host->head_pg.page = NULL;
+
+		if (!force && sg_dma_len(sg) + sg->offset >
+		    (host->page_idx << PAGE_SHIFT) + data->blksz - blk_head)
+			/* More blocks in this SG, don't unmap the next page */
+			return;
+	}
+
+	page = host->pg.page;
+	if (!page)
+		return;
+
+	flush_dcache_page(page);
+	kunmap(page);
+
+	host->pg.page = NULL;
+}
+
+/* Called from MMC_WRITE_MULTIPLE_BLOCK or MMC_READ_MULTIPLE_BLOCK */
+static void v08r07_sg_advance(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	size_t done, total;
+
+	/* New offset: set at the end of the previous block */
+	if (host->head_pg.page) {
+		/* Finished a cross-page block, jump to the new page */
+		host->page_idx++;
+		host->offset = data->blksz - host->head_len;
+		host->blk_page = host->pg.mapped;
+		v08r07_sg_unmap(host, false);
+	} else {
+		host->offset += data->blksz;
+		/* The completed block didn't cross a page boundary */
+		if (host->offset == PAGE_SIZE) {
+			/* If required, we'll map the page below */
+			host->offset = 0;
+			host->page_idx++;
+		}
+	}
+
+	/*
+	 * Now host->blk_page + host->offset point at the end of our last block
+	 * and host->page_idx is the index of the page, in which our new block
+	 * is located, if any
+	 */
+
+	done = (host->page_idx << PAGE_SHIFT) + host->offset;
+	total = host->sg->offset + sg_dma_len(host->sg);
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): %zu of %zu @ %u\n", __func__,
+		done, total, host->offset);
+
+	if (done < total && host->offset) {
+		/* More blocks in this page */
+		if (host->offset + data->blksz > PAGE_SIZE)
+			/* We approached at a block, that spans 2 pages */
+			v08r07_blk_bounce(host, host->sg);
+
+		return;
+	}
+
+	/* Finished current page or an SG segment */
+	v08r07_sg_unmap(host, false);
+
+	if (done == total) {
+		/*
+		 * End of an SG segment or the complete SG: jump to the next
+		 * segment, we'll map it later in v08r07_blk_read() or
+		 * v08r07_blk_write()
+		 */
+		struct scatterlist *next = sg_next(host->sg);
+
+		host->page_idx = 0;
+
+		if (!next)
+			host->wait = V08R07_WAIT_FOR_DATA_END;
+		host->sg = next;
+
+		if (WARN(next && sg_dma_len(next) % data->blksz,
+			 "SG size %zd isn't a multiple of block size %zd\n",
+			 sg_dma_len(next), data->blksz))
+			data->error = -EINVAL;
+
+		return;
+	}
+
+	/* We cannot get here after crossing a page border */
+
+	/* Next page in the same SG */
+	host->pg.page = nth_page(sg_page(host->sg), host->page_idx);
+	host->pg.mapped = kmap(host->pg.page);
+	host->blk_page = host->pg.mapped;
+
+	dev_dbg(mmc_dev(host->mmc), "Mapped %p (%lx) at %p for CMD%u @ 0x%p\n",
+		host->pg.page, page_to_pfn(host->pg.page), host->pg.mapped,
+		host->mrq->cmd->opcode, host->mrq);
+}
+
+/*			DMA handling					*/
+
+static void v08r07_dma_release(struct v08r07_host *host)
+{
+	host->dma_active = false;
+	if (host->chan_tx) {
+		struct dma_chan *chan = host->chan_tx;
+		host->chan_tx = NULL;
+		dma_release_channel(chan);
+	}
+	if (host->chan_rx) {
+		struct dma_chan *chan = host->chan_rx;
+		host->chan_rx = NULL;
+		dma_release_channel(chan);
+	}
+}
+
+static void v08r07_dma_stop_unmap(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+
+	if (!host->dma_active)
+		return;
+
+	v08r07_write(host, V08R07_CC_EXT_MODE, 0);
+	host->dma_active = false;
+
+	if (data->flags & MMC_DATA_READ)
+		/* TODO: do we have to synchronise? */
+		dma_unmap_sg(host->chan_rx->device->dev, data->sg,
+			     data->sg_len, DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(host->chan_tx->device->dev, data->sg,
+			     data->sg_len, DMA_TO_DEVICE);
+}
+
+static void v08r07_dma_complete(void *arg)
+{
+	struct v08r07_host *host = arg;
+	struct mmc_request *mrq = host->mrq;
+
+	if (WARN(!mrq || !mrq->data, "%s: NULL data in DMA completion for %p!\n",
+		 dev_name(mmc_dev(host->mmc)), mrq))
+		return;
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): CMD%u DMA completed\n", __func__,
+		mrq->cmd->opcode);
+
+	v08r07_dma_stop_unmap(host);
+	v08r07_wait_for_brwe(host, mrq->data->flags & MMC_DATA_READ);
+}
+
+static int v08r07_dma_setup(struct v08r07_host *host, struct dma_chan *chan,
+			    enum dma_transfer_direction dir)
+{
+	struct mmc_data *data = host->mrq->data;
+	struct scatterlist *sg = data->sg;
+	struct dma_async_tx_descriptor *desc = NULL;
+	dma_cookie_t cookie = -EINVAL;
+	enum dma_data_direction data_dir;
+	int ret;
+
+	switch (dir) {
+	case DMA_MEM_TO_DEV:
+		data_dir = DMA_TO_DEVICE;
+		break;
+	case DMA_DEV_TO_MEM:
+		data_dir = DMA_FROM_DEVICE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = dma_map_sg(chan->device->dev, sg, data->sg_len, data_dir);
+	if (ret > 0) {
+		host->dma_active = true;
+		desc = dmaengine_prep_slave_sg(chan, sg, ret, dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	}
+
+	if (desc) {
+		desc->callback = v08r07_dma_complete;
+		desc->callback_param = host;
+		cookie = dmaengine_submit(desc);
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): mapped %d -> %d, cookie %d @ %p\n",
+		__func__, data->sg_len, ret, cookie, desc);
+
+	if (cookie < 0) {
+		/* DMA failed, fall back to PIO */
+		if (ret >= 0)
+			ret = cookie;
+		v08r07_dma_release(host);
+		dev_warn(mmc_dev(host->mmc),
+			 "DMA failed: %d, falling back to PIO\n", ret);
+	}
+
+	return cookie;
+}
+
+static int v08r07_dma_start(struct v08r07_host *host)
+{
+	if (!host->chan_rx || !host->chan_tx)
+		return -ENODEV;
+
+	if (host->mrq->data->flags & MMC_DATA_READ)
+		return v08r07_dma_setup(host, host->chan_rx, DMA_DEV_TO_MEM);
+
+	return v08r07_dma_setup(host, host->chan_tx, DMA_MEM_TO_DEV);
+}
+
+static void v08r07_dma_kill(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): SG of %u: %ux%u\n",
+		__func__, data->sg_len, data->blocks, data->blksz);
+	/* Abort DMA */
+	if (data->flags & MMC_DATA_READ)
+		dmaengine_terminate_all(host->chan_rx);
+	else
+		dmaengine_terminate_all(host->chan_tx);
+}
+
+static void v08r07_dma_check_error(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): IO error %d, status 0x%x\n",
+		__func__, host->io_error, v08r07_read(host, V08R07_SD_INFO1));
+
+	if (host->io_error) {
+		data->error = v08r07_error_code(host);
+		data->bytes_xfered = 0;
+		v08r07_dma_kill(host);
+		v08r07_dma_release(host);
+		dev_warn(mmc_dev(host->mmc),
+			 "DMA failed: %d, falling back to PIO\n", data->error);
+		return;
+	}
+
+	/*
+	 * The datasheet tells us to check a response from the card, whereas
+	 * responses only come after the command phase, not after the data
+	 * phase. Let's check anyway.
+	 */
+	if (host->irq_status & V08R07_SD_INFO1_RSP_END)
+		dev_warn(mmc_dev(host->mmc), "Unexpected response received!\n");
+}
+
+static void v08r07_dma_kick(struct v08r07_host *host)
+{
+	if (host->mrq->data->flags & MMC_DATA_READ)
+		dma_async_issue_pending(host->chan_rx);
+	else
+		dma_async_issue_pending(host->chan_tx);
+}
+
+static void v08r07_dma_request(struct v08r07_host *host, phys_addr_t start)
+{
+	struct dma_slave_config cfg = {
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
+	int ret;
+
+	host->chan_tx = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
+	dev_dbg(mmc_dev(host->mmc), "%s: TX: got channel %p\n", __func__,
+		host->chan_tx);
+
+	if (!host->chan_tx)
+		return;
+
+	cfg.direction = DMA_MEM_TO_DEV;
+	cfg.dst_addr = start + V08R07_SD_BUF0;
+	cfg.dst_maxburst = 128;	/* 128 words * 4 bytes = 512 bytes */
+	cfg.src_addr = 0;
+	ret = dmaengine_slave_config(host->chan_tx, &cfg);
+	if (ret < 0)
+		goto e_release_tx;
+
+	host->chan_rx = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
+	dev_dbg(mmc_dev(host->mmc), "%s: RX: got channel %p\n", __func__,
+		host->chan_rx);
+
+	if (!host->chan_rx)
+		goto e_release_tx;
+
+	cfg.direction = DMA_DEV_TO_MEM;
+	cfg.src_addr = cfg.dst_addr;
+	cfg.src_maxburst = 128;	/* 128 words * 4 bytes = 512 bytes */
+	cfg.dst_addr = 0;
+	ret = dmaengine_slave_config(host->chan_rx, &cfg);
+	if (ret < 0)
+		goto e_release_rx;
+
+	return;
+
+e_release_rx:
+	dma_release_channel(host->chan_rx);
+	host->chan_rx = NULL;
+e_release_tx:
+	dma_release_channel(host->chan_tx);
+	host->chan_tx = NULL;
+}
+
+/*			API helpers					*/
+
+static void v08r07_clk_set(struct v08r07_host *host, struct mmc_ios *ios)
+{
+	unsigned long rate = ios->clock;
+	u32 val;
+	unsigned int i;
+
+	for (i = 1000; i; i--) {
+		if (v08r07_read(host, V08R07_SD_INFO2) & V08R07_SD_INFO2_SCLKDIVEN)
+			break;
+		usleep_range(10, 100);
+	}
+
+	if (!i) {
+		dev_err(mmc_dev(host->mmc), "SD bus busy, clock set aborted\n");
+		return;
+	}
+
+	val = v08r07_read(host, V08R07_SD_CLK_CTRL) & 0xff00;
+
+	if (rate) {
+		unsigned long new_rate;
+
+		if (host->imclk <= rate) {
+			if (ios->timing != MMC_TIMING_UHS_DDR50) {
+				/* Cannot have 1-to-1 clock in DDR mode */
+				new_rate = host->imclk;
+				val |= 0xff;
+			} else {
+				new_rate = host->imclk / 2;
+			}
+		} else {
+			unsigned long div =
+				roundup_pow_of_two(DIV_ROUND_UP(host->imclk, rate));
+			val |= div >> 2;
+			new_rate = host->imclk / div;
+		}
+
+		if (host->rate == new_rate)
+			return;
+
+		host->rate = new_rate;
+
+		dev_dbg(mmc_dev(host->mmc), "target %lu, div %u, set %lu\n",
+			rate, (val & 0xff) << 2, new_rate);
+	}
+
+	/*
+	 * if old or new rate is equal to input rate, have to switch the clock
+	 * off before changing and on after
+	 */
+	if (host->imclk == rate || host->imclk == host->rate || !rate)
+		v08r07_write(host, V08R07_SD_CLK_CTRL,
+			     val & ~V08R07_SD_CLK_CTRL_SCLKEN);
+
+	if (!rate) {
+		host->rate = 0;
+		return;
+	}
+
+	v08r07_write(host, V08R07_SD_CLK_CTRL, val);
+
+	if (host->imclk == rate || host->imclk == host->rate ||
+	    !(val & V08R07_SD_CLK_CTRL_SCLKEN))
+		v08r07_write(host, V08R07_SD_CLK_CTRL,
+			     val | V08R07_SD_CLK_CTRL_SCLKEN);
+}
+
+static void v08r07_set_power(struct v08r07_host *host, struct mmc_ios *ios)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (!IS_ERR(mmc->supply.vmmc))
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+				      ios->power_mode ? ios->vdd : 0);
+}
+
+static int v08r07_reset(struct v08r07_host *host)
+{
+	int i;
+
+	v08r07_write(host, V08R07_SOFT_RST, 6);
+	cpu_relax();
+	v08r07_write(host, V08R07_SOFT_RST, 7);
+	for (i = 1000; i; i--)
+		if (v08r07_read(host, V08R07_SOFT_RST) & 1)
+			break;
+
+	return i ? 0 : -ETIMEDOUT;
+}
+
+static void v08r07_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct v08r07_host *host = mmc_priv(mmc);
+	u32 option, mode;
+	int ret;
+
+	dev_dbg(mmc_dev(mmc), "%uHz, OCR: %u, power %u, bus-width %u, timing %u\n",
+		ios->clock, ios->vdd, ios->power_mode, ios->bus_width, ios->timing);
+
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		v08r07_set_power(host, ios);
+		v08r07_only_cd(host);
+		break;
+	case MMC_POWER_UP:
+		/*
+		 * We only also touch V08R07_SD_OPTION from .request(), which
+		 * cannot race with MMC_POWER_UP
+		 */
+		ret = v08r07_reset(host);
+		if (ret < 0) {
+			dev_err(mmc_dev(mmc), "Cannot reset the interface!\n");
+		} else {
+			v08r07_set_power(host, ios);
+			v08r07_only_cd(host);
+		}
+		break;
+	case MMC_POWER_ON:
+		option = v08r07_read(host, V08R07_SD_OPTION);
+		/*
+		 * The eMMC standard only allows 4 or 8 bits in the DDR mode,
+		 * the same probably holds for SD cards. We check here anyway,
+		 * since the datasheet explicitly requires 4 bits for DDR.
+		 */
+		if (ios->bus_width == MMC_BUS_WIDTH_1) {
+			if (ios->timing == MMC_TIMING_UHS_DDR50)
+				dev_err(mmc_dev(mmc),
+					"4 bits are required for DDR\n");
+			option |= 0x8000;
+			mode = 0;
+		} else {
+			option &= 0x7fff;
+			mode = ios->timing == MMC_TIMING_UHS_DDR50;
+		}
+		v08r07_write(host, V08R07_SD_OPTION, option);
+		v08r07_write(host, V08R07_SDIF_MODE, mode);
+		break;
+	}
+
+	if (host->rate != ios->clock)
+		v08r07_clk_set(host, ios);
+}
+
+/* This is data timeout. Response timeout is fixed to 640 clock cycles */
+static void v08r07_timeout_set(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+	u32 val;
+	unsigned long ticks;
+
+	if (!mrq->data)
+		ticks = host->rate / 1000 * mrq->cmd->busy_timeout;
+	else
+		ticks = host->rate / 1000000 * (mrq->data->timeout_ns / 1000) +
+			mrq->data->timeout_clks;
+
+	if (!ticks || ticks > 1 << 27)
+		/* Max timeout */
+		val = 14;
+	else if (ticks < 1 << 13)
+		/* Min timeout */
+		val = 0;
+	else
+		val = order_base_2(ticks) - 13;
+
+	dev_dbg(mmc_dev(host->mmc), "Set %s timeout %lu ticks @ %lu Hz\n",
+		mrq->data ? "data" : "cmd", ticks, host->rate);
+
+	v08r07_write(host, V08R07_SD_OPTION, (val << 4) |
+		     (v08r07_read(host, V08R07_SD_OPTION) & 0xff0f));
+}
+
+static void v08r07_request_done(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_data *data = mrq->data;
+
+	if (WARN(host->pg.page || host->head_pg.page,
+		 "Page %p or %p not unmapped: wait %u, CMD%d(%c) @ +0x%x %ux%u in SG%u!\n",
+		 host->pg.page, host->head_pg.page, host->wait, mrq->cmd->opcode,
+		 data ? (data->flags & MMC_DATA_READ ? 'R' : 'W') : '-',
+		 data ? host->offset : 0, data ? data->blocks : 0,
+		 data ? data->blksz : 0, data ? data->sg_len : 0))
+		v08r07_sg_unmap(host, true);
+
+	if (mrq->cmd->error ||
+	    (data && data->error) ||
+	    (mrq->stop && mrq->stop->error))
+		dev_dbg(mmc_dev(host->mmc), "%s(CMD%d: %ux%u): err %d %d %d\n",
+			__func__, mrq->cmd->opcode, data ? data->blocks : 0,
+			data ? data->blksz : 0,
+			mrq->cmd->error,
+			data ? data->error : 1,
+			mrq->stop ? mrq->stop->error : 1);
+
+	/* Disable DMA */
+	v08r07_write(host, V08R07_CC_EXT_MODE, 0);
+	host->wait = V08R07_WAIT_FOR_REQUEST;
+	host->mrq = NULL;
+
+	mmc_request_done(host->mmc, mrq);
+}
+
+static int v08r07_cmd_flags(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = mrq->cmd;
+	u16 opc = cmd->opcode;
+
+	if (host->app_cmd) {
+		host->app_cmd = false;
+		opc |= V08R07_SD_CMD_APP;
+	}
+
+	if (mrq->data) {
+		opc |= V08R07_SD_CMD_DATA;
+
+		if (mrq->data->flags & MMC_DATA_READ)
+			opc |= V08R07_SD_CMD_READ;
+
+		if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+		    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+		    (cmd->opcode == SD_IO_RW_EXTENDED &&
+		     mrq->data->blocks > 1)) {
+			opc |= V08R07_SD_CMD_MULTI;
+			if (!mrq->stop)
+				opc |= V08R07_SD_CMD_CMD12_AUTO_OFF;
+		}
+
+		switch (mmc_resp_type(cmd)) {
+		case MMC_RSP_NONE:
+			opc |= V08R07_SD_CMD_MODE_RSP_NONE;
+			break;
+		case MMC_RSP_R1:
+			opc |= V08R07_SD_CMD_MODE_RSP_R1;
+			break;
+		case MMC_RSP_R1B:
+			opc |= V08R07_SD_CMD_MODE_RSP_R1B;
+			break;
+		case MMC_RSP_R2:
+			opc |= V08R07_SD_CMD_MODE_RSP_R2;
+			break;
+		case MMC_RSP_R3:
+			opc |= V08R07_SD_CMD_MODE_RSP_R3;
+			break;
+		default:
+			dev_warn(mmc_dev(host->mmc),
+				 "Unknown response type %d\n",
+				 mmc_resp_type(cmd));
+			return -EINVAL;
+		}
+	}
+
+	return opc;
+}
+
+static int v08r07_rq_start(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = mrq->cmd;
+	struct mmc_data *data = mrq->data;
+	int opc = v08r07_cmd_flags(host);
+	int i;
+
+	if (opc < 0)
+		return opc;
+
+	for (i = 1000; i; i--) {
+		if (!(v08r07_read(host, V08R07_SD_INFO2) & V08R07_SD_INFO2_CBSY))
+			break;
+		usleep_range(10, 100);
+	}
+
+	if (!i) {
+		dev_dbg(mmc_dev(host->mmc), "Command active, request aborted\n");
+		return -EAGAIN;
+	}
+
+	if (data) {
+		bool use_dma;
+		int ret = 0;
+
+		host->page_idx = 0;
+
+		if (cmd->opcode == SD_IO_RW_EXTENDED && data->blocks > 1) {
+			switch (data->blksz) {
+			case 512:
+				break;
+			case 32:
+			case 64:
+			case 128:
+			case 256:
+				if (mrq->stop)
+					ret = -EINVAL;
+				break;
+			default:
+				ret = -EINVAL;
+			}
+		} else if ((cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+			    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) &&
+			   data->blksz != 512) {
+			ret = -EINVAL;
+		}
+
+		if (ret < 0) {
+			dev_warn(mmc_dev(host->mmc), "%s(): %u blocks of %u bytes\n",
+				 __func__, data->blocks, data->blksz);
+			return -EINVAL;
+		}
+
+		if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+		    cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+		    (cmd->opcode == SD_IO_RW_EXTENDED &&
+		     data->blocks > 1))
+			v08r07_sg_prep(host);
+
+		v08r07_write(host, V08R07_SD_SIZE, data->blksz);
+
+		if ((data->blksz >= V08R07_MIN_DMA ||
+		     data->blocks > 1) &&
+		    (data->blksz % 4 ||
+		     data->sg->offset % 4))
+			dev_dbg(mmc_dev(host->mmc),
+				"Bad SG of %u: %ux%u @ %u\n", data->sg_len,
+				data->blksz, data->blocks, data->sg->offset);
+
+		/* Enable DMA for V08R07_MIN_DMA bytes or more */
+		use_dma = data->blksz >= V08R07_MIN_DMA &&
+			!(data->blksz % 4) &&
+			v08r07_dma_start(host) >= DMA_MIN_COOKIE;
+
+		if (use_dma)
+			v08r07_write(host, V08R07_CC_EXT_MODE, V08R07_CC_EXT_MODE_SDRW);
+
+		dev_dbg(mmc_dev(host->mmc),
+			"%s(): request opcode %u, %u blocks of %u bytes in %u segments, %s %s @+0x%x%s\n",
+			__func__, cmd->opcode, data->blocks, data->blksz,
+			data->sg_len, use_dma ? "DMA" : "PIO",
+			data->flags & MMC_DATA_READ ? "read" : "write",
+			data->sg->offset, mrq->stop ? " + stop" : "");
+	} else {
+		dev_dbg(mmc_dev(host->mmc), "%s(): request opcode %u\n",
+			__func__, cmd->opcode);
+	}
+
+	/* We have to get a command completion interrupt with DMA too */
+	v08r07_wait_for_resp(host);
+
+	host->wait = V08R07_WAIT_FOR_CMD;
+	schedule_delayed_work(&host->timeout_work, host->timeout * 4);
+
+	/* SEC bit is required to enable block counting by the core */
+	v08r07_write(host, V08R07_SD_STOP,
+		     data && data->blocks > 1 ? V08R07_SD_STOP_SEC : 0);
+	v08r07_write(host, V08R07_SD_ARG, cmd->arg);
+
+	/* Kick command execution */
+	v08r07_write(host, V08R07_SD_CMD, opc);
+
+	return 0;
+}
+
+static void v08r07_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct v08r07_host *host = mmc_priv(mmc);
+	int ret;
+
+	cancel_delayed_work_sync(&host->timeout_work);
+
+	host->mrq = mrq;
+	host->sg = NULL;
+
+	v08r07_timeout_set(host);
+	ret = v08r07_rq_start(host);
+	if (ret < 0) {
+		mrq->cmd->error = ret;
+		v08r07_request_done(host);
+	}
+}
+
+static int v08r07_get_cd(struct mmc_host *mmc)
+{
+	struct v08r07_host *host = mmc_priv(mmc);
+	/* Read is atomic, no need to lock */
+	u32 status = v08r07_read(host, V08R07_SD_INFO1) & V08R07_SD_INFO1_CD;
+
+/*
+ *	level	status.CD	CD_ACTIVE_HIGH	card present
+ *	1	0		0		0
+ *	1	0		1		1
+ *	0	1		0		1
+ *	0	1		1		0
+ */
+	return !status ^ !(mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
+}
+
+static int v08r07_get_ro(struct mmc_host *mmc)
+{
+	struct v08r07_host *host = mmc_priv(mmc);
+	/* No locking as above */
+	u32 status = v08r07_read(host, V08R07_SD_INFO1) & V08R07_SD_INFO1_WP;
+
+/*
+ *	level	status.WP	RO_ACTIVE_HIGH	card read-only
+ *	1	0		0		0
+ *	1	0		1		1
+ *	0	1		0		1
+ *	0	1		1		0
+ */
+	return !status ^ !(mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+}
+
+static void v08r07_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct v08r07_host *host = mmc_priv(mmc);
+
+	dev_dbg(mmc_dev(mmc), "%s(): %sable\n", __func__, enable ? "en" : "dis");
+
+	if (enable) {
+		host->sdio_mask = V08R07_SDIO_INFO1_IRQ & ~V08R07_SDIO_INFO1_IOIRQ;
+		v08r07_write(host, V08R07_SDIO_INFO1_MASK, host->sdio_mask);
+		v08r07_write(host, V08R07_SDIO_MODE, 1);
+	} else {
+		v08r07_write(host, V08R07_SDIO_MODE, 0);
+		v08r07_write(host, V08R07_SDIO_INFO1_MASK, V08R07_SDIO_INFO1_IRQ);
+		host->sdio_mask = V08R07_SDIO_INFO1_IRQ;
+	}
+}
+
+static struct mmc_host_ops v08r07_ops = {
+	.request	= v08r07_request,
+	.set_ios	= v08r07_set_ios,
+	.get_cd		= v08r07_get_cd,
+	.get_ro		= v08r07_get_ro,
+	.enable_sdio_irq = v08r07_enable_sdio_irq,
+};
+
+/*			State machine handlers				*/
+
+static void v08r07_resp_cmd12(struct v08r07_host *host)
+{
+	struct mmc_command *cmd = host->mrq->stop;
+	cmd->resp[0] = v08r07_read(host, V08R07_SD_RSP10);
+}
+
+static void v08r07_resp_read(struct v08r07_host *host)
+{
+	struct mmc_command *cmd = host->mrq->cmd;
+	u32 *rsp = cmd->resp, tmp = 0;
+	int i;
+
+/*
+ * RSP10	39-8
+ * RSP32	71-40
+ * RSP54	103-72
+ * RSP76	127-104
+ * R2-type response:
+ * resp[0]	= r[127..96]
+ * resp[1]	= r[95..64]
+ * resp[2]	= r[63..32]
+ * resp[3]	= r[31..0]
+ * Other responses:
+ * resp[0]	= r[39..8]
+ */
+
+	if (mmc_resp_type(cmd) == MMC_RSP_NONE)
+		return;
+
+	if (!(host->irq_status & V08R07_SD_INFO1_RSP_END)) {
+		dev_err(mmc_dev(host->mmc),
+			"CMD%d: response expected but is missing!\n", cmd->opcode);
+		return;
+	}
+
+	if (mmc_resp_type(cmd) & MMC_RSP_136)
+		for (i = 0; i < 4; i++) {
+			if (i)
+				rsp[3 - i] = tmp >> 24;
+			tmp = v08r07_read(host, V08R07_SD_RSP10 + i * 8);
+			rsp[3 - i] |= tmp << 8;
+		}
+	else if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+		 cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK)
+		/* Read RSP54 to avoid conflict with auto CMD12 */
+		rsp[0] = v08r07_read(host, V08R07_SD_RSP54);
+	else
+		rsp[0] = v08r07_read(host, V08R07_SD_RSP10);
+
+	dev_dbg(mmc_dev(host->mmc), "Response 0x%x\n", rsp[0]);
+}
+
+static int v08r07_blk_read(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	u32 *p;
+	int i, rest;
+
+	if (host->io_error) {
+		data->error = v08r07_error_code(host);
+		goto error;
+	}
+
+	if (host->pg.page) {
+		p = host->blk_page + host->offset;
+	} else {
+		p = v08r07_sg_map(host);
+		if (!p) {
+			data->error = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for (i = 0; i < data->blksz / 4; i++, p++)
+		*p = v08r07_read(host, V08R07_SD_BUF0);
+
+	rest = data->blksz % 4;
+	for (i = 0; i < (rest + 1) / 2; i++) {
+		u16 d = v08r07_read16(host, V08R07_SD_BUF0);
+		((u8 *)p)[2 * i] = ((u8 *)&d)[0];
+		if (rest > 1 && !i)
+			((u8 *)p)[2 * i + 1] = ((u8 *)&d)[1];
+	}
+
+	return 0;
+
+error:
+	dev_dbg(mmc_dev(host->mmc), "%s(): %d\n", __func__, data->error);
+	host->wait = V08R07_WAIT_FOR_REQUEST;
+	return data->error;
+}
+
+static int v08r07_blk_write(struct v08r07_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	u32 *p;
+	int i, rest;
+
+	if (host->io_error) {
+		data->error = v08r07_error_code(host);
+		goto error;
+	}
+
+	if (host->pg.page) {
+		p = host->blk_page + host->offset;
+	} else {
+		p = v08r07_sg_map(host);
+		if (!p) {
+			data->error = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for (i = 0; i < data->blksz / 4; i++, p++)
+		v08r07_write(host, V08R07_SD_BUF0, *p);
+
+	rest = data->blksz % 4;
+	for (i = 0; i < (rest + 1) / 2; i++) {
+		u16 d;
+		((u8 *)&d)[0] = ((u8 *)p)[2 * i];
+		if (rest > 1 && !i)
+			((u8 *)&d)[1] = ((u8 *)p)[2 * i + 1];
+		else
+			((u8 *)&d)[1] = 0;
+		v08r07_write16(host, V08R07_SD_BUF0, d);
+	}
+
+	return 0;
+
+error:
+	dev_dbg(mmc_dev(host->mmc), "%s(): %d\n", __func__, data->error);
+	host->wait = V08R07_WAIT_FOR_REQUEST;
+	return data->error;
+}
+
+static int v08r07_stop_cmd(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+
+	switch (mrq->cmd->opcode) {
+	case MMC_READ_MULTIPLE_BLOCK:
+	case MMC_WRITE_MULTIPLE_BLOCK:
+		if (mrq->stop->opcode == MMC_STOP_TRANSMISSION) {
+			host->wait = V08R07_WAIT_FOR_STOP;
+			return 0;
+		}
+		/* Unsupported STOP command */
+	default:
+		dev_err(mmc_dev(host->mmc),
+			"unsupported stop CMD%d for CMD%d\n",
+			mrq->stop->opcode, mrq->cmd->opcode);
+		mrq->stop->error = -EOPNOTSUPP;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static bool v08r07_end_cmd(struct v08r07_host *host)
+{
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_command *cmd = mrq->cmd;
+
+	if (host->io_error) {
+		cmd->error = v08r07_error_code(host);
+		return false;
+	}
+
+	v08r07_resp_read(host);
+
+	if (!mrq->data)
+		return false;
+
+	if (host->dma_active) {
+		v08r07_dma_kick(host);
+		if (!mrq->stop)
+			host->wait = V08R07_WAIT_FOR_DMA;
+		else if (v08r07_stop_cmd(host) < 0)
+			return false;
+	} else if (mrq->data->flags & MMC_DATA_READ) {
+		if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+		    (cmd->opcode == SD_IO_RW_EXTENDED &&
+		     mrq->data->blocks > 1))
+			host->wait = V08R07_WAIT_FOR_MREAD;
+		else
+			host->wait = V08R07_WAIT_FOR_READ;
+	} else {
+		if (cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK ||
+		    (cmd->opcode == SD_IO_RW_EXTENDED &&
+		     mrq->data->blocks > 1))
+			host->wait = V08R07_WAIT_FOR_MWRITE;
+		else
+			host->wait = V08R07_WAIT_FOR_WRITE;
+	}
+
+	return true;
+}
+
+static bool v08r07_read_block(struct v08r07_host *host)
+{
+	/* ACCESS_END IRQ is already unmasked */
+	int ret = v08r07_blk_read(host);
+
+	/*
+	 * Have to force unmapping both pages: the single block could have been
+	 * cross-page, in which case for single-block IO host->page_idx == 0.
+	 * So, if we don't force, the second page won't be unmapped.
+	 */
+	v08r07_sg_unmap(host, true);
+
+	if (ret < 0)
+		return false;
+
+	host->wait = V08R07_WAIT_FOR_DATA_END;
+	return true;
+}
+
+static bool v08r07_mread_block(struct v08r07_host *host)
+{
+	int ret = v08r07_blk_read(host);
+
+	if (ret < 0)
+		return false;
+
+	v08r07_sg_advance(host);
+
+	return !host->mrq->data->error &&
+		(host->wait != V08R07_WAIT_FOR_DATA_END || !host->mrq->stop);
+}
+
+static bool v08r07_write_block(struct v08r07_host *host)
+{
+	int ret = v08r07_blk_write(host);
+
+	/* See comment in v08r07_read_block() */
+	v08r07_sg_unmap(host, true);
+
+	if (ret < 0)
+		return false;
+
+	host->wait = V08R07_WAIT_FOR_DATA_END;
+	return true;
+}
+
+static bool v08r07_mwrite_block(struct v08r07_host *host)
+{
+	int ret = v08r07_blk_write(host);
+
+	if (ret < 0)
+		return false;
+
+	v08r07_sg_advance(host);
+
+	return !host->mrq->data->error &&
+		(host->wait != V08R07_WAIT_FOR_DATA_END || !host->mrq->stop);
+}
+
+/*			Interrupt & timeout handlers			*/
+
+static irqreturn_t v08r07_sd_bh(int irq, void *dev_id)
+{
+	struct v08r07_host *host = dev_id;
+	struct mmc_request *mrq;
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+	bool io_wait = false;
+
+	cancel_delayed_work_sync(&host->timeout_work);
+
+	mrq = host->mrq;
+	if (!mrq)
+		return IRQ_HANDLED;
+
+	cmd = mrq->cmd;
+	data = mrq->data;
+
+	switch (host->wait) {
+	case V08R07_WAIT_FOR_REQUEST:
+		/* We're too late, the timeout has already kicked in */
+		return IRQ_HANDLED;
+	case V08R07_WAIT_FOR_CMD:
+		/* Wait for data? */
+		io_wait = v08r07_end_cmd(host);
+		break;
+	case V08R07_WAIT_FOR_MREAD:
+		/* Wait for more data? */
+		io_wait = v08r07_mread_block(host);
+		break;
+	case V08R07_WAIT_FOR_READ:
+		/* Wait for data end? */
+		io_wait = v08r07_read_block(host);
+		break;
+	case V08R07_WAIT_FOR_MWRITE:
+		/* Wait data to write? */
+		io_wait = v08r07_mwrite_block(host);
+		break;
+	case V08R07_WAIT_FOR_WRITE:
+		/* Wait for data end? */
+		io_wait = v08r07_write_block(host);
+		break;
+	case V08R07_WAIT_FOR_DMA:
+		v08r07_dma_check_error(host);
+		break;
+	case V08R07_WAIT_FOR_STOP:
+		v08r07_write(host, V08R07_SD_STOP, 0);
+		if (host->io_error) {
+			int ret = v08r07_error_code(host);
+			if (mrq->stop)
+				mrq->stop->error = ret;
+			else
+				mrq->data->error = ret;
+			dev_warn(mmc_dev(host->mmc), "%s(): %d\n", __func__, ret);
+			break;
+		}
+		v08r07_resp_cmd12(host);
+		mrq->stop->error = 0;
+		break;
+	case V08R07_WAIT_FOR_DATA_END:
+		if (host->io_error) {
+			mrq->data->error = v08r07_error_code(host);
+			dev_warn(mmc_dev(host->mmc), "%s(): %d\n", __func__,
+				 mrq->data->error);
+		}
+		break;
+	default:
+		cmd->error = -EFAULT;
+		dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
+		v08r07_request_done(host);
+		return IRQ_HANDLED;
+	}
+
+	if (io_wait) {
+		schedule_delayed_work(&host->timeout_work, host->timeout * 4);
+		/* Wait for more data or ACCESS_END */
+		if (!host->dma_active)
+			v08r07_wait_for_brwe(host, mrq->data->flags & MMC_DATA_READ);
+		return IRQ_HANDLED;
+	}
+
+	if (!cmd->error) {
+		if (data) {
+			if (!data->error) {
+				if (host->wait != V08R07_WAIT_FOR_STOP &&
+				    host->mrq->stop &&
+				    !host->mrq->stop->error &&
+				    !v08r07_stop_cmd(host)) {
+					/* Sending STOP */
+					v08r07_wait_for_resp(host);
+
+					schedule_delayed_work(&host->timeout_work,
+							      host->timeout * 4);
+
+					return IRQ_HANDLED;
+				}
+
+				data->bytes_xfered = data->blocks * data->blksz;
+			} else {
+				/* Data error: might need to unmap the last page */
+				dev_warn(mmc_dev(host->mmc), "%s(): data error %d\n",
+					 __func__, data->error);
+				v08r07_sg_unmap(host, true);
+			}
+		} else if (cmd->opcode == MMC_APP_CMD) {
+			host->app_cmd = true;
+		}
+	}
+
+	v08r07_request_done(host);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t v08r07_sd(int irq, void *dev_id)
+{
+	struct v08r07_host *host = dev_id;
+	u16 status, status2, error;
+
+	status = v08r07_read(host, V08R07_SD_INFO1) & ~host->status_mask &
+		~V08R07_SD_INFO1_CARD;
+	status2 = v08r07_read(host, V08R07_SD_INFO2) & ~host->status2_mask;
+
+	v08r07_only_cd(host);
+
+	dev_dbg(mmc_dev(host->mmc),
+		"IRQ status = 0x%08x, status2 = 0x%08x\n", status, status2);
+
+	if (!status && !status2)
+		return IRQ_NONE;
+
+	error = status2 & V08R07_SD_INFO2_ERR;
+
+	/* Ack / clear interrupts */
+	if (V08R07_SD_INFO1_IRQ & status)
+		v08r07_write(host, V08R07_SD_INFO1,
+			     0xffff & ~(V08R07_SD_INFO1_IRQ & status));
+
+	if (V08R07_SD_INFO2_IRQ & status2) {
+		if (error)
+			/* In error cases BWE and BRE aren't cleared automatically */
+			status2 |= V08R07_SD_INFO2_BWE | V08R07_SD_INFO2_BRE;
+
+		v08r07_write(host, V08R07_SD_INFO2,
+			     0xffff & ~(V08R07_SD_INFO2_IRQ & status2));
+	}
+
+	host->io_error = error;
+	host->irq_status = status;
+
+	if (error) {
+		/* Don't pollute the log with unsupported command timeouts */
+		if (host->wait != V08R07_WAIT_FOR_CMD ||
+		    error != V08R07_SD_INFO2_RSP_TOUT)
+			dev_warn(mmc_dev(host->mmc),
+				 "%s(): INFO2 error bits 0x%08x\n",
+				 __func__, error);
+		else
+			dev_dbg(mmc_dev(host->mmc),
+				"%s(): INFO2 error bits 0x%08x\n",
+				__func__, error);
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t v08r07_sdio(int irq, void *dev_id)
+{
+	struct v08r07_host *host = dev_id;
+	u32 status = v08r07_read(host, V08R07_SDIO_INFO1) & ~host->sdio_mask;
+
+	dev_dbg(mmc_dev(host->mmc), "%s(): status 0x%x\n", __func__, status);
+
+	if (!status)
+		return IRQ_NONE;
+
+	v08r07_write(host, V08R07_SDIO_INFO1, ~status);
+
+	mmc_signal_sdio_irq(host->mmc);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t v08r07_cd(int irq, void *dev_id)
+{
+	struct v08r07_host *host = dev_id;
+	struct mmc_host *mmc = host->mmc;
+	u16 status;
+
+	/* We're only interested in hotplug events here */
+	status = v08r07_read(host, V08R07_SD_INFO1) & ~host->status_mask &
+		V08R07_SD_INFO1_CARD;
+
+	if (!status)
+		return IRQ_NONE;
+
+	/* Ack */
+	v08r07_write(host, V08R07_SD_INFO1, !status);
+
+	if (!work_pending(&mmc->detect.work) &&
+	    (((status & V08R07_SD_INFO1_CARD_INSERT) &&
+	      !mmc->card) ||
+	     ((status & V08R07_SD_INFO1_CARD_EJECT) &&
+	      mmc->card)))
+		mmc_detect_change(mmc, msecs_to_jiffies(100));
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Actually this should not be needed, if the built-in timeout works reliably in
+ * the both PIO cases and DMA never fails. But if DMA does fail, a timeout
+ * handler might be the only way to catch the error.
+ */
+static void v08r07_timeout_work(struct work_struct *work)
+{
+	struct delayed_work *d = container_of(work, struct delayed_work, work);
+	struct v08r07_host *host = container_of(d, struct v08r07_host, timeout_work);
+	struct mmc_request *mrq = host->mrq;
+	struct mmc_data *data = mrq ? mrq->data : NULL;
+
+	dev_warn(mmc_dev(host->mmc),
+		 "%s timeout wait %u CMD%d: IRQ 0x%08x:0x%08x, last IRQ 0x%08x\n",
+		 host->dma_active ? "DMA" : "PIO",
+		 host->wait, mrq ? mrq->cmd->opcode : -1,
+		 v08r07_read(host, V08R07_SD_INFO1),
+		 v08r07_read(host, V08R07_SD_INFO2), host->irq_status);
+
+	if (host->dma_active) {
+		v08r07_dma_kill(host);
+		v08r07_dma_stop_unmap(host);
+	}
+
+	switch (host->wait) {
+	default:
+		dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
+		/* mrq can be NULL in this actually impossible case */
+	case V08R07_WAIT_FOR_CMD:
+		v08r07_error_code(host);
+		if (mrq)
+			mrq->cmd->error = -ETIMEDOUT;
+		break;
+	case V08R07_WAIT_FOR_STOP:
+		v08r07_error_code(host);
+		mrq->stop->error = -ETIMEDOUT;
+		break;
+	case V08R07_WAIT_FOR_DMA:
+	case V08R07_WAIT_FOR_MREAD:
+	case V08R07_WAIT_FOR_MWRITE:
+	case V08R07_WAIT_FOR_READ:
+	case V08R07_WAIT_FOR_WRITE:
+		dev_dbg(mmc_dev(host->mmc),
+			"%c: page #%u @ +0x%x %ux%u in SG%u. Current SG %u bytes @ %u\n",
+			data->flags & MMC_DATA_READ ? 'R' : 'W', host->page_idx,
+			host->offset, data->blocks, data->blksz, data->sg_len,
+			sg_dma_len(host->sg), host->sg->offset);
+		v08r07_sg_unmap(host, true);
+		/*
+		 * If V08R07_WAIT_FOR_DATA_END times out, we have already unmapped
+		 * the page
+		 */
+	case V08R07_WAIT_FOR_DATA_END:
+		v08r07_error_code(host);
+		data->error = -ETIMEDOUT;
+	}
+
+	if (mrq)
+		v08r07_request_done(host);
+}
+
+/*			 Probe / release				*/
+
+static const struct of_device_id v08r07_of_match[] = {
+	{.compatible = "renesas,usdhi6rol0"},
+	{.compatible = "renesas,v08r07s01e"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, v08r07_of_match);
+
+static int v08r07_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mmc_host *mmc;
+	struct v08r07_host *host;
+	struct resource *res;
+	int irq_cd, irq_sd, irq_sdio;
+	u32 version;
+	int ret;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	irq_cd = platform_get_irq_byname(pdev, "card detect");
+	irq_sd = platform_get_irq_byname(pdev, "data");
+	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
+	if (irq_sd < 0 || irq_sdio < 0)
+		return -ENODEV;
+
+	mmc = mmc_alloc_host(sizeof(struct v08r07_host), dev);
+	if (!mmc)
+		return -ENOMEM;
+
+	ret = mmc_of_parse(mmc);
+	if (ret < 0)
+		goto e_free_mmc;
+
+	mmc_regulator_get_supply(mmc);
+
+	host		= mmc_priv(mmc);
+	host->mmc	= mmc;
+	host->wait	= V08R07_WAIT_FOR_REQUEST;
+	host->timeout	= msecs_to_jiffies(1000);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
+		goto e_free_mmc;
+	}
+
+	host->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(host->clk))
+		goto e_free_mmc;
+
+	host->imclk = clk_get_rate(host->clk);
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret < 0)
+		goto e_free_mmc;
+
+	version = v08r07_read(host, V08R07_VERSION);
+	if ((version & 0xfff) != 0xa0d) {
+		dev_err(dev, "Version not recognized %x\n", version);
+		goto e_clk_off;
+	}
+
+	dev_info(dev, "A V08R07S01E SD host detected with %d ports\n",
+		 v08r07_read(host, V08R07_SD_PORT_SEL) >> 8);
+
+	v08r07_mask_all(host);
+
+	if (irq_cd >= 0) {
+		ret = devm_request_irq(dev, irq_cd, v08r07_cd, 0,
+				       dev_name(dev), host);
+		if (ret < 0)
+			goto e_clk_off;
+	} else {
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq_sd, v08r07_sd, v08r07_sd_bh, 0,
+			       dev_name(dev), host);
+	if (ret < 0)
+		goto e_clk_off;
+
+	ret = devm_request_irq(dev, irq_sdio, v08r07_sdio, 0,
+			       dev_name(dev), host);
+	if (ret < 0)
+		goto e_clk_off;
+
+	INIT_DELAYED_WORK(&host->timeout_work, v08r07_timeout_work);
+
+	v08r07_dma_request(host, res->start);
+
+	mmc->ops = &v08r07_ops;
+	mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
+		MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_DDR50 | MMC_CAP_SDIO_IRQ;
+	/* Set .max_segs to some random number. Feel free to adjust. */
+	mmc->max_segs = 32;
+	mmc->max_blk_size = 512;
+	mmc->max_req_size = PAGE_CACHE_SIZE * mmc->max_segs;
+	mmc->max_blk_count = mmc->max_req_size / mmc->max_blk_size;
+	/*
+	 * Setting .max_seg_size to 1 page would simplify our page-mapping code,
+	 * But OTOH, having large segments makes DMA more efficient. We could
+	 * check, whether we managed to get DMA and fall back to 1 page
+	 * segments, but if we do manage to obtain DMA and then it fails at
+	 * run-time and we fall back to PIO, we will continue getting large
+	 * segments. So, we wouldn't be able to get rid of the code anyway.
+	 */
+	mmc->max_seg_size = mmc->max_req_size;
+	if (!mmc->f_max)
+		mmc->f_max = host->imclk;
+	mmc->f_min = host->imclk / 512;
+
+	platform_set_drvdata(pdev, host);
+
+	ret = mmc_add_host(mmc);
+	if (ret < 0)
+		goto e_clk_off;
+
+	return 0;
+
+e_clk_off:
+	clk_disable_unprepare(host->clk);
+e_free_mmc:
+	mmc_free_host(mmc);
+
+	return ret;
+}
+
+static int v08r07_remove(struct platform_device *pdev)
+{
+	struct v08r07_host *host = platform_get_drvdata(pdev);
+
+	mmc_remove_host(host->mmc);
+
+	v08r07_mask_all(host);
+	cancel_delayed_work_sync(&host->timeout_work);
+	v08r07_dma_release(host);
+	clk_disable_unprepare(host->clk);
+	mmc_free_host(host->mmc);
+
+	return 0;
+}
+
+static struct platform_driver v08r07_driver = {
+	.probe		= v08r07_probe,
+	.remove		= v08r07_remove,
+	.driver		= {
+		.name	= "v08r07s01e",
+		.owner	= THIS_MODULE,
+		.of_match_table = v08r07_of_match,
+	},
+};
+
+module_platform_driver(v08r07_driver);
+
+MODULE_DESCRIPTION("Renesas v08r07s01e SD/SDIO host driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:v08r07s01e");
+MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
-- 
1.9.1

