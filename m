From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] goldfish: emulated MMC device
Date: Mon, 21 Jan 2013 23:43:46 +0000
Message-ID: <20130121234339.19859.80987.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33141 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab3AUXXW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 18:23:22 -0500
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id r0M06jQv012883
	for <linux-mmc@vger.kernel.org>; Tue, 22 Jan 2013 00:06:51 GMT
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

=46rom: Mike Lockwood <lockwood@android.com>

This driver handles the virtual MMC device present in the Goldfish emul=
ator.
The patch folds together initial work from Mike Lockwood and patches by
San Mehat, Jun Nakajima and Tom Keel <thomas.keel@intel.com> plus clean=
ups
by Alan Cox to get it all into 3.6 shape.

Signed-off-by: Mike A. Chan <mikechan@google.com>
[cleaned up and x86 support added]
Signed-off-by: Sheng Yang <sheng@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@intel.com>
Signed-off-by: Xiaohui Xin <xiaohui.xin@intel.com>
Signed-off-by: Jun Nakajima <jun.nakajima@intel.com>
Signed-off-by: Bruce Beare <bruce.j.beare@intel.com>
[Moved to 3.4]
Signed-off-by: Tom Keel <thomas.keel@intel.com>
[Moved to 3.7]
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/Kconfig    |    7 +
 drivers/mmc/host/Makefile   |    1=20
 drivers/mmc/host/goldfish.c |  566 +++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 574 insertions(+)
 create mode 100644 drivers/mmc/host/goldfish.c


diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7684f7f..aebe265 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -372,6 +372,13 @@ config MMC_DAVINCI
           If you have an DAVINCI board with a Multimedia Card slot,
           say Y or M here.  If unsure, say N.
=20
+config MMC_GOLDFISH
+	tristate "goldfish qemu Multimedia Card Interface support"
+	depends on GOLDFISH
+	help
+	  This selects the Goldfish Multimedia card Interface emulation
+	  found on the Goldfish Android virtual device emulation.
+
 config MMC_SPI
 	tristate "MMC/SD/SDIO over SPI"
 	depends on SPI_MASTER && !HIGHMEM && HAS_DMA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index d5ea0722..82eba3e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MMC_TIFM_SD)	+=3D tifm_sd.o
 obj-$(CONFIG_MMC_MSM)		+=3D msm_sdcc.o
 obj-$(CONFIG_MMC_MVSDIO)	+=3D mvsdio.o
 obj-$(CONFIG_MMC_DAVINCI)       +=3D davinci_mmc.o
+obj-$(CONFIG_MMC_GOLDFISH)	+=3D goldfish.o
 obj-$(CONFIG_MMC_SPI)		+=3D mmc_spi.o
 ifeq ($(CONFIG_OF),y)
 obj-$(CONFIG_MMC_SPI)		+=3D of_mmc_spi.o
diff --git a/drivers/mmc/host/goldfish.c b/drivers/mmc/host/goldfish.c
new file mode 100644
index 0000000..5763f78
--- /dev/null
+++ b/drivers/mmc/host/goldfish.c
@@ -0,0 +1,566 @@
+/*
+ *  Copyright 2007, Google Inc.
+ *  Copyright 2012, Intel Inc.
+ *
+ *  based on omap.c driver, which was
+ *  Copyright (C) 2004 Nokia Corporation
+ *  Written by Tuukka Tikkanen and Juha Yrj=F6l=E4<juha.yrjola@nokia.c=
om>
+ *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
+ *  Other hacks (DMA, SD, etc) by David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/major.h>
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/hdreg.h>
+#include <linux/kdev_t.h>
+#include <linux/blkdev.h>
+#include <linux/mutex.h>
+#include <linux/scatterlist.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/scatterlist.h>
+
+#include <asm/types.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define DRIVER_NAME "goldfish_mmc"
+
+#define BUFFER_SIZE   16384
+
+#define GOLDFISH_MMC_READ(host, addr)   (readl(host->reg_base + addr))
+#define GOLDFISH_MMC_WRITE(host, addr, x)   (writel(x, host->reg_base =
+ addr))
+
+
+enum {
+	/* status register */
+	MMC_INT_STATUS	        =3D 0x00,
+	/* set this to enable IRQ */
+	MMC_INT_ENABLE	        =3D 0x04,
+	/* set this to specify buffer address */
+	MMC_SET_BUFFER          =3D 0x08,
+
+	/* MMC command number */
+	MMC_CMD	                =3D 0x0C,
+
+	/* MMC argument */
+	MMC_ARG	                =3D 0x10,
+
+	/* MMC response (or R2 bits 0 - 31) */
+	MMC_RESP_0		        =3D 0x14,
+
+	/* MMC R2 response bits 32 - 63 */
+	MMC_RESP_1		        =3D 0x18,
+
+	/* MMC R2 response bits 64 - 95 */
+	MMC_RESP_2		        =3D 0x1C,
+
+	/* MMC R2 response bits 96 - 127 */
+	MMC_RESP_3		        =3D 0x20,
+
+	MMC_BLOCK_LENGTH        =3D 0x24,
+	MMC_BLOCK_COUNT         =3D 0x28,
+
+	/* MMC state flags */
+	MMC_STATE               =3D 0x2C,
+
+	/* MMC_INT_STATUS bits */
+
+	MMC_STAT_END_OF_CMD     =3D 1U << 0,
+	MMC_STAT_END_OF_DATA    =3D 1U << 1,
+	MMC_STAT_STATE_CHANGE   =3D 1U << 2,
+	MMC_STAT_CMD_TIMEOUT    =3D 1U << 3,
+
+	/* MMC_STATE bits */
+	MMC_STATE_INSERTED     =3D 1U << 0,
+	MMC_STATE_READ_ONLY    =3D 1U << 1,
+};
+
+/*
+ * Command types
+ */
+#define OMAP_MMC_CMDTYPE_BC	0
+#define OMAP_MMC_CMDTYPE_BCR	1
+#define OMAP_MMC_CMDTYPE_AC	2
+#define OMAP_MMC_CMDTYPE_ADTC	3
+
+
+struct goldfish_mmc_host {
+	struct mmc_request	*mrq;
+	struct mmc_command	*cmd;
+	struct mmc_data		*data;
+	struct mmc_host		*mmc;
+	struct device		*dev;
+	unsigned char		id; /* 16xx chips have 2 MMC blocks */
+	void __iomem		*virt_base;
+	unsigned int		phys_base;
+	int			irq;
+	unsigned char		bus_mode;
+	unsigned char		hw_bus_mode;
+
+	unsigned int		sg_len;
+	unsigned		dma_done:1;
+	unsigned		dma_in_use:1;
+
+	void __iomem		*reg_base;
+};
+
+static inline int
+goldfish_mmc_cover_is_open(struct goldfish_mmc_host *host)
+{
+	return 0;
+}
+
+static ssize_t
+goldfish_mmc_show_cover_switch(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct goldfish_mmc_host *host =3D dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", goldfish_mmc_cover_is_open(host) ? "open"=
 :
+			"closed");
+}
+
+static DEVICE_ATTR(cover_switch, S_IRUGO, goldfish_mmc_show_cover_swit=
ch, NULL);
+
+static void
+goldfish_mmc_start_command(struct goldfish_mmc_host *host, struct mmc_=
command *cmd)
+{
+	u32 cmdreg;
+	u32 resptype;
+	u32 cmdtype;
+
+	host->cmd =3D cmd;
+
+	resptype =3D 0;
+	cmdtype =3D 0;
+
+	/* Our hardware needs to know exact type */
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
+		/* resp 1, 1b, 6, 7 */
+		resptype =3D 1;
+		break;
+	case MMC_RSP_R2:
+		resptype =3D 2;
+		break;
+	case MMC_RSP_R3:
+		resptype =3D 3;
+		break;
+	default:
+		dev_err(mmc_dev(host->mmc),
+			"Invalid response type: %04x\n", mmc_resp_type(cmd));
+		break;
+	}
+
+	if (mmc_cmd_type(cmd) =3D=3D MMC_CMD_ADTC)
+		cmdtype =3D OMAP_MMC_CMDTYPE_ADTC;
+	else if (mmc_cmd_type(cmd) =3D=3D MMC_CMD_BC)
+		cmdtype =3D OMAP_MMC_CMDTYPE_BC;
+	else if (mmc_cmd_type(cmd) =3D=3D MMC_CMD_BCR)
+		cmdtype =3D OMAP_MMC_CMDTYPE_BCR;
+	else
+		cmdtype =3D OMAP_MMC_CMDTYPE_AC;
+
+	cmdreg =3D cmd->opcode | (resptype << 8) | (cmdtype << 12);
+
+	if (host->bus_mode =3D=3D MMC_BUSMODE_OPENDRAIN)
+		cmdreg |=3D 1 << 6;
+
+	if (cmd->flags & MMC_RSP_BUSY)
+		cmdreg |=3D 1 << 11;
+
+	if (host->data && !(host->data->flags & MMC_DATA_WRITE))
+		cmdreg |=3D 1 << 15;
+
+	GOLDFISH_MMC_WRITE(host, MMC_ARG, cmd->arg);
+	GOLDFISH_MMC_WRITE(host, MMC_CMD, cmdreg);
+}
+
+static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
+							struct mmc_data *data)
+{
+	if (host->dma_in_use) {
+		enum dma_data_direction dma_data_dir;
+
+		if (data->flags & MMC_DATA_WRITE)
+			dma_data_dir =3D DMA_TO_DEVICE;
+		else
+			dma_data_dir =3D DMA_FROM_DEVICE;
+
+		if (dma_data_dir =3D=3D DMA_FROM_DEVICE) {
+			/*
+			 * We don't really have DMA, so we need
+			 * to copy from our platform driver buffer
+			 */
+			uint8_t *dest =3D (uint8_t *)sg_virt(data->sg);
+			memcpy(dest, host->virt_base, data->sg->length);
+		}
+		host->data->bytes_xfered +=3D data->sg->length;
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
+								dma_data_dir);
+	}
+
+	host->data =3D NULL;
+	host->sg_len =3D 0;
+
+	/* NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
+	 * dozens of requests until the card finishes writing data.
+	 * It'd be cheaper to just wait till an EOFB interrupt arrives...
+	 */
+
+	if (!data->stop) {
+		host->mrq =3D NULL;
+		mmc_request_done(host->mmc, data->mrq);
+		return;
+	}
+
+	goldfish_mmc_start_command(host, data->stop);
+}
+
+static void goldfish_mmc_end_of_data(struct goldfish_mmc_host *host,
+							struct mmc_data *data)
+{
+	if (!host->dma_in_use) {
+		goldfish_mmc_xfer_done(host, data);
+		return;
+	}
+	if (host->dma_done)
+		goldfish_mmc_xfer_done(host, data);
+}
+
+static void goldfish_mmc_cmd_done(struct goldfish_mmc_host *host,
+						struct mmc_command *cmd)
+{
+	host->cmd =3D NULL;
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136) {
+			/* response type 2 */
+			cmd->resp[3] =3D
+				GOLDFISH_MMC_READ(host, MMC_RESP_0);
+			cmd->resp[2] =3D
+				GOLDFISH_MMC_READ(host, MMC_RESP_1);
+			cmd->resp[1] =3D
+				GOLDFISH_MMC_READ(host, MMC_RESP_2);
+			cmd->resp[0] =3D
+				GOLDFISH_MMC_READ(host, MMC_RESP_3);
+		} else {
+			/* response types 1, 1b, 3, 4, 5, 6 */
+			cmd->resp[0] =3D
+				GOLDFISH_MMC_READ(host, MMC_RESP_0);
+		}
+	}
+
+	if (host->data =3D=3D NULL || cmd->error) {
+		host->mrq =3D NULL;
+		mmc_request_done(host->mmc, cmd->mrq);
+	}
+}
+
+static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
+{
+	struct goldfish_mmc_host *host =3D (struct goldfish_mmc_host *)dev_id=
;
+	u16 status;
+	int end_command =3D 0;
+	int end_transfer =3D 0;
+	int transfer_error =3D 0;
+	int state_changed =3D 0;
+	int cmd_timeout =3D 0;
+
+	while ((status =3D GOLDFISH_MMC_READ(host, MMC_INT_STATUS)) !=3D 0) {
+		GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
+
+		if (status & MMC_STAT_END_OF_CMD)
+			end_command =3D 1;
+
+		if (status & MMC_STAT_END_OF_DATA)
+			end_transfer =3D 1;
+
+		if (status & MMC_STAT_STATE_CHANGE)
+			state_changed =3D 1;
+
+                if (status & MMC_STAT_CMD_TIMEOUT) {
+			end_command =3D 0;
+			cmd_timeout =3D 1;
+                }
+	}
+
+	if (cmd_timeout) {
+		struct mmc_request *mrq =3D host->mrq;
+		mrq->cmd->error =3D -ETIMEDOUT;
+		host->mrq =3D NULL;
+		mmc_request_done(host->mmc, mrq);
+	}
+
+	if (end_command)
+		goldfish_mmc_cmd_done(host, host->cmd);
+
+	if (transfer_error)
+		goldfish_mmc_xfer_done(host, host->data);
+	else if (end_transfer) {
+		host->dma_done =3D 1;
+		goldfish_mmc_end_of_data(host, host->data);
+	} else if (host->data !=3D NULL) {
+		/*
+		 * WORKAROUND -- after porting this driver from 2.6 to 3.4,
+		 * during device initialization, cases where host->data is
+		 * non-null but end_transfer is false would occur. Doing
+		 * nothing in such cases results in no further interrupts,
+		 * and initialization failure.
+		 * TODO -- find the real cause.
+		 */
+		host->dma_done =3D 1;
+		goldfish_mmc_end_of_data(host, host->data);
+	}
+
+	if (state_changed) {
+		u32 state =3D GOLDFISH_MMC_READ(host, MMC_STATE);
+		pr_info("%s: Card detect now %d\n", __func__,
+			(state & MMC_STATE_INSERTED));
+		mmc_detect_change(host->mmc, 0);
+	}
+
+	if (!end_command && !end_transfer &&
+	    !transfer_error && !state_changed && !cmd_timeout) {
+		status =3D GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
+		dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
+		if (status !=3D 0) {
+			GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
+			GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE, 0);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
+						struct mmc_request *req)
+{
+	struct mmc_data *data =3D req->data;
+	int block_size;
+	unsigned sg_len;
+	enum dma_data_direction dma_data_dir;
+
+	host->data =3D data;
+	if (data =3D=3D NULL) {
+		GOLDFISH_MMC_WRITE(host, MMC_BLOCK_LENGTH, 0);
+		GOLDFISH_MMC_WRITE(host, MMC_BLOCK_COUNT, 0);
+		host->dma_in_use =3D 0;
+		return;
+	}
+
+	block_size =3D data->blksz;
+
+	GOLDFISH_MMC_WRITE(host, MMC_BLOCK_COUNT, data->blocks - 1);
+	GOLDFISH_MMC_WRITE(host, MMC_BLOCK_LENGTH, block_size - 1);
+
+	/* cope with calling layer confusion; it issues "single
+	 * block" writes using multi-block scatterlists.
+	 */
+	sg_len =3D (data->blocks =3D=3D 1) ? 1 : data->sg_len;
+
+	if (data->flags & MMC_DATA_WRITE)
+		dma_data_dir =3D DMA_TO_DEVICE;
+	else
+		dma_data_dir =3D DMA_FROM_DEVICE;
+
+	host->sg_len =3D dma_map_sg(mmc_dev(host->mmc), data->sg,
+				sg_len, dma_data_dir);
+	host->dma_done =3D 0;
+	host->dma_in_use =3D 1;
+
+	if (dma_data_dir =3D=3D DMA_TO_DEVICE) {
+		/* we don't really have DMA, so we need to copy to our
+		   platform driver buffer */
+		const uint8_t *src =3D (uint8_t *)sg_virt(data->sg);
+		memcpy(host->virt_base, src, data->sg->length);
+	}
+}
+
+static void goldfish_mmc_request(struct mmc_host *mmc, struct mmc_requ=
est *req)
+{
+	struct goldfish_mmc_host *host =3D mmc_priv(mmc);
+
+	WARN_ON(host->mrq !=3D NULL);
+
+	host->mrq =3D req;
+	goldfish_mmc_prepare_data(host, req);
+	goldfish_mmc_start_command(host, req->cmd);
+
+	/* this is to avoid accidentally being detected as an SDIO card
+	   in mmc_attach_sdio() */
+	if (req->cmd->opcode =3D=3D SD_IO_SEND_OP_COND &&
+		req->cmd->flags =3D=3D (MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR))
+		req->cmd->error =3D -EINVAL;
+}
+
+static void goldfish_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios =
*ios)
+{
+	struct goldfish_mmc_host *host =3D mmc_priv(mmc);
+
+	host->bus_mode =3D ios->bus_mode;
+	host->hw_bus_mode =3D host->bus_mode;
+}
+
+static int goldfish_mmc_get_ro(struct mmc_host *mmc)
+{
+	uint32_t state;
+	struct goldfish_mmc_host *host =3D mmc_priv(mmc);
+
+	state =3D GOLDFISH_MMC_READ(host, MMC_STATE);
+	return ((state & MMC_STATE_READ_ONLY) !=3D 0);
+}
+
+static const struct mmc_host_ops goldfish_mmc_ops =3D {
+	.request	=3D goldfish_mmc_request,
+	.set_ios	=3D goldfish_mmc_set_ios,
+	.get_ro		=3D goldfish_mmc_get_ro,
+};
+
+static int goldfish_mmc_probe(struct platform_device *pdev)
+{
+	struct mmc_host *mmc;
+	struct goldfish_mmc_host *host =3D NULL;
+	struct resource *res;
+	int ret =3D 0;
+	int irq;
+	dma_addr_t buf_addr;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq =3D platform_get_irq(pdev, 0);
+	if (res =3D=3D NULL || irq < 0)
+		return -ENXIO;
+
+	mmc =3D mmc_alloc_host(sizeof(struct goldfish_mmc_host), &pdev->dev);
+	if (mmc =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto err_alloc_host_failed;
+	}
+
+	host =3D mmc_priv(mmc);
+	host->mmc =3D mmc;
+
+	pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->end)=
;
+	host->reg_base =3D ioremap(res->start, res->end - res->start + 1);
+	if (host->reg_base =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto ioremap_failed;
+	}
+	host->virt_base =3D dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
+							&buf_addr, GFP_KERNEL);
+
+	if (host->virt_base =3D=3D 0) {
+		ret =3D -ENOMEM;
+		goto dma_alloc_failed;
+	}
+	host->phys_base =3D buf_addr;
+
+	host->id =3D pdev->id;
+	host->irq =3D irq;
+
+	mmc->ops =3D &goldfish_mmc_ops;
+	mmc->f_min =3D 400000;
+	mmc->f_max =3D 24000000;
+	mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
+	mmc->caps =3D MMC_CAP_4_BIT_DATA;
+
+	/* Use scatterlist DMA to reduce per-transfer costs.
+	 * NOTE max_seg_size assumption that small blocks aren't
+	 * normally used (except e.g. for reading SD registers).
+	 */
+	mmc->max_segs =3D 32;
+	mmc->max_blk_size =3D 2048;	/* MMC_BLOCK_LENGTH is 11 bits (+1) */
+	mmc->max_blk_count =3D 2048;	/* MMC_BLOCK_COUNT is 11 bits (+1) */
+	mmc->max_req_size =3D BUFFER_SIZE;
+	mmc->max_seg_size =3D mmc->max_req_size;
+
+	ret =3D request_irq(host->irq, goldfish_mmc_irq, 0, DRIVER_NAME, host=
);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed IRQ Adding goldfish MMC\n");
+
+		goto err_request_irq_failed;
+	}
+
+	host->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, host);
+
+	ret =3D device_create_file(&pdev->dev, &dev_attr_cover_switch);
+	if (ret)
+		dev_warn(mmc_dev(host->mmc),
+				"Unable to create sysfs attributes\n");
+
+	GOLDFISH_MMC_WRITE(host, MMC_SET_BUFFER, host->phys_base);
+	GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE,
+		MMC_STAT_END_OF_CMD | MMC_STAT_END_OF_DATA |
+		MMC_STAT_STATE_CHANGE | MMC_STAT_CMD_TIMEOUT);
+
+	mmc_add_host(mmc);
+	return 0;
+
+err_request_irq_failed:
+	dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base,
+							host->phys_base);
+dma_alloc_failed:
+	iounmap(host->reg_base);
+ioremap_failed:
+	mmc_free_host(host->mmc);
+err_alloc_host_failed:
+	return ret;
+}
+
+static int goldfish_mmc_remove(struct platform_device *pdev)
+{
+	struct goldfish_mmc_host *host =3D platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	BUG_ON(host =3D=3D NULL);
+
+	mmc_remove_host(host->mmc);
+	free_irq(host->irq, host);
+	dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base, host->phy=
s_base);
+	iounmap(host->reg_base);
+	mmc_free_host(host->mmc);
+	return 0;
+}
+
+static struct platform_driver goldfish_mmc_driver =3D {
+	.probe		=3D goldfish_mmc_probe,
+	.remove		=3D goldfish_mmc_remove,
+	.driver		=3D {
+		.name	=3D DRIVER_NAME,
+	},
+};
+
+module_platform_driver(goldfish_mmc_driver);
+MODULE_LICENSE("GPL v2");

