From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sat, 5 Feb 2011 10:18:41 +0800
Message-ID: <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>
List-Id: linux-mmc@vger.kernel.org

This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
The driver calls into mxs-dma via generic dmaengine api for both pio
and data transfer.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/mmc.h |   15 +
 drivers/mmc/host/Kconfig             |    9 +
 drivers/mmc/host/Makefile            |    1 +
 drivers/mmc/host/mxs-mmc.c           |  884 ++++++++++++++++++++++++++++++++++
 4 files changed, 909 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/mmc.h
 create mode 100644 drivers/mmc/host/mxs-mmc.c

diff --git a/arch/arm/mach-mxs/include/mach/mmc.h b/arch/arm/mach-mxs/include/mach/mmc.h
new file mode 100644
index 0000000..42a1842
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/mmc.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MXS_MMC_H__
+#define __MACH_MXS_MMC_H__
+
+struct mxs_mmc_platform_data {
+	int wp_gpio;	/* write protect pin */
+};
+#endif /* __MACH_MXS_MMC_H__ */
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index afe8c6f..42a9e21 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -319,6 +319,15 @@ config MMC_MXC
 
 	  If unsure, say N.
 
+config MMC_MXS
+	tristate "Freescale MXS Multimedia Card Interface support"
+	depends on ARCH_MXS
+	help
+	  This selects the Freescale SSP MMC controller found on MXS based
+	  platforms like mx23/28.
+
+	  If unsure, say N.
+
 config MMC_TIFM_SD
 	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e834fb2..30aa686 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_IMX)		+= imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
+obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 obj-$(CONFIG_MMC_SDHCI_PXA)	+= sdhci-pxa.o
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
new file mode 100644
index 0000000..4bcc5f0
--- /dev/null
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -0,0 +1,884 @@
+/*
+ * Portions copyright (C) 2003 Russell King, PXA MMCI Driver
+ * Portions copyright (C) 2004-2005 Pierre Ossman, W83L51xD SD/MMC driver
+ *
+ * Copyright 2008 Embedded Alley Solutions, Inc.
+ * Copyright 2009-2011 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/highmem.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/completion.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
+#include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
+
+#include <mach/mxs.h>
+#include <mach/common.h>
+#include <mach/dma.h>
+#include <mach/mmc.h>
+
+#define DRIVER_NAME	"mxs-mmc"
+
+/* card detect polling timeout */
+#define MXS_MMC_DETECT_TIMEOUT			(HZ/2)
+
+#define SSP_VERSION_LATEST	4
+#define ssp_is_old()		(host->version < SSP_VERSION_LATEST)
+
+/* SSP registers */
+#define HW_SSP_CTRL0				0x000
+#define  BM_SSP_CTRL0_RUN			(1 << 29)
+#define  BM_SSP_CTRL0_SDIO_IRQ_CHECK		(1 << 28)
+#define  BM_SSP_CTRL0_IGNORE_CRC		(1 << 26)
+#define  BM_SSP_CTRL0_READ			(1 << 25)
+#define  BM_SSP_CTRL0_DATA_XFER			(1 << 24)
+#define  BP_SSP_CTRL0_BUS_WIDTH			(22)
+#define  BM_SSP_CTRL0_BUS_WIDTH			(0x3 << 22)
+#define  BM_SSP_CTRL0_WAIT_FOR_IRQ		(1 << 21)
+#define  BM_SSP_CTRL0_LONG_RESP			(1 << 19)
+#define  BM_SSP_CTRL0_GET_RESP			(1 << 17)
+#define  BM_SSP_CTRL0_ENABLE			(1 << 16)
+#define  BP_SSP_CTRL0_XFER_COUNT		(0)
+#define  BM_SSP_CTRL0_XFER_COUNT		(0xffff)
+#define HW_SSP_CMD0				0x010
+#define  BM_SSP_CMD0_DBL_DATA_RATE_EN		(1 << 25)
+#define  BM_SSP_CMD0_SLOW_CLKING_EN		(1 << 22)
+#define  BM_SSP_CMD0_CONT_CLKING_EN		(1 << 21)
+#define  BM_SSP_CMD0_APPEND_8CYC		(1 << 20)
+#define  BP_SSP_CMD0_BLOCK_SIZE			(16)
+#define  BM_SSP_CMD0_BLOCK_SIZE			(0xf << 16)
+#define  BP_SSP_CMD0_BLOCK_COUNT		(8)
+#define  BM_SSP_CMD0_BLOCK_COUNT		(0xff << 8)
+#define  BP_SSP_CMD0_CMD			(0)
+#define  BM_SSP_CMD0_CMD			(0xff)
+#define HW_SSP_CMD1				0x020
+#define HW_SSP_XFER_SIZE			0x030
+#define HW_SSP_BLOCK_SIZE			0x040
+#define  BP_SSP_BLOCK_SIZE_BLOCK_COUNT		(4)
+#define  BM_SSP_BLOCK_SIZE_BLOCK_COUNT		(0xffffff << 4)
+#define  BP_SSP_BLOCK_SIZE_BLOCK_SIZE		(0)
+#define  BM_SSP_BLOCK_SIZE_BLOCK_SIZE		(0xf)
+#define HW_SSP_TIMING				(ssp_is_old() ? 0x050 : 0x070)
+#define  BP_SSP_TIMING_TIMEOUT			(16)
+#define  BM_SSP_TIMING_TIMEOUT			(0xffff << 16)
+#define  BP_SSP_TIMING_CLOCK_DIVIDE		(8)
+#define  BM_SSP_TIMING_CLOCK_DIVIDE		(0xff << 8)
+#define  BP_SSP_TIMING_CLOCK_RATE		(0)
+#define  BM_SSP_TIMING_CLOCK_RATE		(0xff)
+#define HW_SSP_CTRL1				(ssp_is_old() ? 0x060 : 0x080)
+#define  BM_SSP_CTRL1_SDIO_IRQ			(1 << 31)
+#define  BM_SSP_CTRL1_SDIO_IRQ_EN		(1 << 30)
+#define  BM_SSP_CTRL1_RESP_ERR_IRQ		(1 << 29)
+#define  BM_SSP_CTRL1_RESP_ERR_IRQ_EN		(1 << 28)
+#define  BM_SSP_CTRL1_RESP_TIMEOUT_IRQ		(1 << 27)
+#define  BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN	(1 << 26)
+#define  BM_SSP_CTRL1_DATA_TIMEOUT_IRQ		(1 << 25)
+#define  BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN	(1 << 24)
+#define  BM_SSP_CTRL1_DATA_CRC_IRQ		(1 << 23)
+#define  BM_SSP_CTRL1_DATA_CRC_IRQ_EN		(1 << 22)
+#define  BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ		(1 << 21)
+#define  BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ_EN	(1 << 20)
+#define  BM_SSP_CTRL1_RECV_TIMEOUT_IRQ		(1 << 17)
+#define  BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN	(1 << 16)
+#define  BM_SSP_CTRL1_FIFO_OVERRUN_IRQ		(1 << 15)
+#define  BM_SSP_CTRL1_FIFO_OVERRUN_IRQ_EN	(1 << 14)
+#define  BM_SSP_CTRL1_DMA_ENABLE		(1 << 13)
+#define  BM_SSP_CTRL1_POLARITY			(1 << 9)
+#define  BP_SSP_CTRL1_WORD_LENGTH		(4)
+#define  BM_SSP_CTRL1_WORD_LENGTH		(0xf << 4)
+#define  BP_SSP_CTRL1_SSP_MODE			(0)
+#define  BM_SSP_CTRL1_SSP_MODE			(0xf)
+#define HW_SSP_SDRESP0				(ssp_is_old() ? 0x080 : 0x0a0)
+#define HW_SSP_SDRESP1				(ssp_is_old() ? 0x090 : 0x0b0)
+#define HW_SSP_SDRESP2				(ssp_is_old() ? 0x0a0 : 0x0c0)
+#define HW_SSP_SDRESP3				(ssp_is_old() ? 0x0b0 : 0x0d0)
+#define HW_SSP_STATUS				(ssp_is_old() ? 0x0c0 : 0x100)
+#define  BM_SSP_STATUS_CARD_DETECT		(1 << 28)
+#define  BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
+#define  BM_SSP_STATUS_RESP_CRC_ERR		(1 << 16)
+#define  BM_SSP_STATUS_RESP_ERR			(1 << 15)
+#define  BM_SSP_STATUS_RESP_TIMEOUT		(1 << 14)
+#define  BM_SSP_STATUS_TIMEOUT			(1 << 12)
+#define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 0x130)
+#define  BP_SSP_VERSION_MAJOR			(24)
+
+#define BF_SSP(value, field)	(((value) << BP_##field) & BM_##field)
+
+#define MXS_MMC_IRQ_BITS	(BM_SSP_CTRL1_SDIO_IRQ		| \
+				BM_SSP_CTRL1_RESP_ERR_IRQ	| \
+				BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	| \
+				BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	| \
+				BM_SSP_CTRL1_DATA_CRC_IRQ	| \
+				BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ	| \
+				BM_SSP_CTRL1_RECV_TIMEOUT_IRQ   | \
+				BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
+
+#define MXS_MMC_ERR_BITS	(BM_SSP_CTRL1_RESP_ERR_IRQ    	| \
+				BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	| \
+				BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	| \
+				BM_SSP_CTRL1_DATA_CRC_IRQ	| \
+				BM_SSP_CTRL1_RECV_TIMEOUT_IRQ)
+
+struct mxs_mmc_host {
+	struct device			*dev;
+	struct mmc_host			*mmc;
+	struct resource			*res;
+	struct resource			*dma_res;
+	struct clk			*clk;
+	unsigned int			clk_rate;
+	unsigned int			version;
+
+	struct mmc_request		*mrq;
+	struct mmc_command		*cmd;
+	struct mmc_data			*data;
+
+	unsigned char			bus_width;
+	unsigned			present:1;
+	struct timer_list		timer;
+
+	void __iomem			*base;
+	int				irq;
+	struct dma_chan         	*dmach;
+	struct dma_async_tx_descriptor	*desc;
+	unsigned int			dma_dir;
+
+	struct mxs_dma_data		dma_data;
+	struct completion 		done;
+	u32				status;
+	spinlock_t			lock;
+	int				sdio_irq_en;
+};
+
+#define SSP_PIO_NUM	3
+static u32 ssp_pio_words[SSP_PIO_NUM];
+
+static int mxs_mmc_get_ro(struct mmc_host *mmc)
+{
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+	struct mxs_mmc_platform_data *pdata = host->dev->platform_data;
+
+	if (!pdata)
+		return -EFAULT;
+
+	if (!gpio_is_valid(pdata->wp_gpio))
+		return -EINVAL;
+
+	return gpio_get_value(pdata->wp_gpio);
+}
+
+static void mxs_mmc_reset(struct mxs_mmc_host *host)
+{
+	u32 ctrl0, ctrl1;
+
+	mxs_reset_block(host->base);
+
+	ctrl0 = BM_SSP_CTRL0_IGNORE_CRC;
+	ctrl1 = BF_SSP(0x3, SSP_CTRL1_SSP_MODE) |
+		BF_SSP(0x7, SSP_CTRL1_WORD_LENGTH) |
+		BM_SSP_CTRL1_DMA_ENABLE |
+		BM_SSP_CTRL1_POLARITY |
+		BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN |
+		BM_SSP_CTRL1_DATA_CRC_IRQ_EN |
+		BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN |
+		BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN |
+		BM_SSP_CTRL1_RESP_ERR_IRQ_EN;
+
+	__raw_writel(BF_SSP(0xffff, SSP_TIMING_TIMEOUT) |
+		     BF_SSP(2, SSP_TIMING_CLOCK_DIVIDE) |
+		     BF_SSP(0, SSP_TIMING_CLOCK_RATE),
+		     host->base + HW_SSP_TIMING);
+
+	if (host->sdio_irq_en) {
+		ctrl0 |= BM_SSP_CTRL0_SDIO_IRQ_CHECK;
+		ctrl1 |= BM_SSP_CTRL1_SDIO_IRQ_EN;
+       }
+
+	__raw_writel(ctrl0, host->base + HW_SSP_CTRL0);
+	__raw_writel(ctrl1, host->base + HW_SSP_CTRL1);
+}
+
+static inline int mxs_mmc_is_plugged(struct mxs_mmc_host *host)
+{
+	return !(__raw_readl(host->base + HW_SSP_STATUS) &
+			BM_SSP_STATUS_CARD_DETECT);
+}
+
+static void mxs_mmc_detect_poll(unsigned long arg)
+{
+	struct mxs_mmc_host *host = (struct mxs_mmc_host *)arg;
+	int card_status;
+
+	card_status = mxs_mmc_is_plugged(host);
+	if (card_status != host->present) {
+		mxs_mmc_reset(host);
+		host->present = card_status;
+		mmc_detect_change(host->mmc, 0);
+	}
+
+	mod_timer(&host->timer, jiffies + MXS_MMC_DETECT_TIMEOUT);
+}
+
+static void mxs_mmc_dma_irq_callback(void *param)
+{
+	struct mxs_mmc_host *host = param;
+
+	host->status = __raw_readl(host->base + HW_SSP_STATUS);
+	complete(&host->done);
+}
+
+static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
+{
+	struct mxs_mmc_host *host = dev_id;
+	u32 stat;
+
+	stat = __raw_readl(host->base + HW_SSP_CTRL1);
+	__mxs_clrl(stat & MXS_MMC_IRQ_BITS, host->base + HW_SSP_CTRL1);
+
+	if (host->cmd && (stat & MXS_MMC_ERR_BITS))
+		host->status = __raw_readl(host->base + HW_SSP_STATUS);
+
+	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
+		mmc_signal_sdio_irq(host->mmc);
+
+	return IRQ_HANDLED;
+}
+
+static inline int mxs_mmc_cmd_error(u32 status)
+{
+	int err = 0;
+
+	if (status & BM_SSP_STATUS_TIMEOUT)
+		err = -ETIMEDOUT;
+	else if (status & BM_SSP_STATUS_RESP_TIMEOUT)
+		err = -ETIMEDOUT;
+	else if (status & BM_SSP_STATUS_RESP_CRC_ERR)
+		err = -EILSEQ;
+	else if (status & BM_SSP_STATUS_RESP_ERR)
+		err = -EIO;
+
+	return err;
+}
+
+static void mxs_mmc_do_dma(struct mxs_mmc_host *host,
+		enum dma_data_direction direction, unsigned int wait4end)
+{
+	struct mmc_command *cmd = host->cmd;
+	struct mmc_data *data = cmd->data;
+	struct scatterlist * sgl;
+	unsigned int sg_len;
+
+	if (direction == DMA_NONE) {
+		/* pio dma */
+		sgl = (struct scatterlist *) ssp_pio_words;
+		sg_len = SSP_PIO_NUM;
+	} else {
+		/* data dma */
+		dma_map_sg(host->dev, data->sg, data->sg_len, direction);
+		sgl = data->sg;
+		sg_len = data->sg_len;
+	}
+
+	host->desc = host->dmach->device->device_prep_slave_sg(host->dmach,
+					sgl, sg_len, direction, wait4end);
+	if (!host->desc) {
+		dev_err(host->dev, "%s: failed to setup dma\n", __func__);
+		goto out_dma_unmap;
+	}
+
+	host->desc->callback = mxs_mmc_dma_irq_callback;
+	host->desc->callback_param = host;
+
+	init_completion(&host->done);
+	dmaengine_submit(host->desc);
+	wait_for_completion(&host->done);
+
+out_dma_unmap:
+	if (direction != DMA_NONE)
+		dma_unmap_sg(host->dev, data->sg, data->sg_len, direction);
+}
+
+static void mxs_mmc_bc(struct mxs_mmc_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+	u32 ctrl0, cmd0, cmd1;
+
+	ctrl0 = BM_SSP_CTRL0_ENABLE | BM_SSP_CTRL0_IGNORE_CRC;
+	cmd0 = BF_SSP(cmd->opcode, SSP_CMD0_CMD) | BM_SSP_CMD0_APPEND_8CYC;
+	cmd1 = cmd->arg;
+
+	if (host->sdio_irq_en) {
+		ctrl0 |= BM_SSP_CTRL0_SDIO_IRQ_CHECK;
+		cmd0 |= BM_SSP_CMD0_CONT_CLKING_EN | BM_SSP_CMD0_SLOW_CLKING_EN;
+	}
+
+	ssp_pio_words[0] = ctrl0;
+	ssp_pio_words[1] = cmd0;
+	ssp_pio_words[2] = cmd1;
+	mxs_mmc_do_dma(host, DMA_NONE, 1);
+
+	cmd->error = mxs_mmc_cmd_error(host->status);
+	if (cmd->error)
+		dev_dbg(host->dev, "%s: command error %d, status 0x%08x\n",
+					__func__, cmd->error, host->status);
+}
+
+static void mxs_mmc_ac(struct mxs_mmc_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+	u32 ignore_crc, get_resp, long_resp;
+	u32 ctrl0, cmd0, cmd1;
+
+	ignore_crc = (mmc_resp_type(cmd) & MMC_RSP_CRC) ?
+			0 : BM_SSP_CTRL0_IGNORE_CRC;
+	get_resp = (mmc_resp_type(cmd) & MMC_RSP_PRESENT) ?
+			BM_SSP_CTRL0_GET_RESP : 0;
+	long_resp = (mmc_resp_type(cmd) & MMC_RSP_136) ?
+			BM_SSP_CTRL0_LONG_RESP : 0;
+
+	ctrl0 = BM_SSP_CTRL0_ENABLE | ignore_crc | get_resp | long_resp;
+	cmd0 = BF_SSP(cmd->opcode, SSP_CMD0_CMD);
+	cmd1 = cmd->arg;
+
+	if (host->sdio_irq_en) {
+		ctrl0 |= BM_SSP_CTRL0_SDIO_IRQ_CHECK;
+		cmd0 |= BM_SSP_CMD0_CONT_CLKING_EN | BM_SSP_CMD0_SLOW_CLKING_EN;
+	}
+
+	ssp_pio_words[0] = ctrl0;
+	ssp_pio_words[1] = cmd0;
+	ssp_pio_words[2] = cmd1;
+	mxs_mmc_do_dma(host, DMA_NONE, 1);
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		while (__raw_readl(host->base + HW_SSP_CTRL0)
+				& BM_SSP_CTRL0_RUN)
+			continue;
+		break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1B:
+	case MMC_RSP_R3:
+		cmd->resp[0] = __raw_readl(host->base + HW_SSP_SDRESP0);
+		break;
+	case MMC_RSP_R2:
+		cmd->resp[3] = __raw_readl(host->base + HW_SSP_SDRESP0);
+		cmd->resp[2] = __raw_readl(host->base + HW_SSP_SDRESP1);
+		cmd->resp[1] = __raw_readl(host->base + HW_SSP_SDRESP2);
+		cmd->resp[0] = __raw_readl(host->base + HW_SSP_SDRESP3);
+		break;
+	default:
+		dev_warn(host->dev, "unsupported response type 0x%x\n",
+						mmc_resp_type(cmd));
+		BUG();
+		break;
+	}
+
+	cmd->error = mxs_mmc_cmd_error(host->status);
+	if (cmd->error)
+		dev_dbg(host->dev, "%s: command error %d, status 0x%08x\n",
+					__func__, cmd->error, host->status);
+}
+
+static unsigned short mxs_ns_to_ssp_ticks(unsigned clock_rate, unsigned ns)
+{
+	const unsigned int ssp_timeout_mul = 4096;
+	/*
+	 * Calculate ticks in ms since ns are large numbers
+	 * and might overflow
+	 */
+	const unsigned int clock_per_ms = clock_rate / 1000;
+	const unsigned int ms = ns / 1000;
+	const unsigned int ticks = ms * clock_per_ms;
+	const unsigned int ssp_ticks = ticks / ssp_timeout_mul;
+
+	BUG_ON(ssp_ticks == 0);
+	return ssp_ticks;
+}
+
+static void mxs_mmc_adtc(struct mxs_mmc_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+	u32 ignore_crc, get_resp, long_resp, read;
+	u32 ctrl0, cmd0, cmd1;
+	u32 timeout, val;
+	u32 data_size = cmd->data->blksz * cmd->data->blocks;
+	u32 log2_blksz;
+
+	ignore_crc = (mmc_resp_type(cmd) & MMC_RSP_CRC) ?
+			0 : BM_SSP_CTRL0_IGNORE_CRC;
+	get_resp = (mmc_resp_type(cmd) & MMC_RSP_PRESENT) ?
+			BM_SSP_CTRL0_GET_RESP : 0;
+	long_resp = (mmc_resp_type(cmd) & MMC_RSP_136) ?
+			BM_SSP_CTRL0_LONG_RESP : 0;
+
+	if (cmd->data->flags & MMC_DATA_WRITE) {
+		host->dma_dir = DMA_TO_DEVICE;
+		read = 0;
+	} else {
+		host->dma_dir = DMA_FROM_DEVICE;
+		read = BM_SSP_CTRL0_READ;
+	}
+
+	ctrl0 = BF_SSP(host->bus_width, SSP_CTRL0_BUS_WIDTH) |
+		ignore_crc | get_resp | long_resp |
+		BM_SSP_CTRL0_DATA_XFER | read |
+		BM_SSP_CTRL0_WAIT_FOR_IRQ |
+		BM_SSP_CTRL0_ENABLE;
+
+	cmd0 = BF_SSP(cmd->opcode, SSP_CMD0_CMD);
+
+	/* get logarithm to base 2 of block size for setting register */
+	log2_blksz = ilog2(cmd->data->blksz);
+
+	/* xfer count, block size and count need to be set differently */
+	if (ssp_is_old()) {
+		ctrl0 |= BF_SSP(data_size, SSP_CTRL0_XFER_COUNT);
+		cmd0 |= BF_SSP(log2_blksz, SSP_CMD0_BLOCK_SIZE) |
+			BF_SSP(cmd->data->blocks - 1, SSP_CMD0_BLOCK_COUNT);
+	} else {
+		__raw_writel(data_size, host->base + HW_SSP_XFER_SIZE);
+		__raw_writel(BF_SSP(log2_blksz, SSP_BLOCK_SIZE_BLOCK_SIZE) |
+			BF_SSP(cmd->data->blocks - 1, SSP_BLOCK_SIZE_BLOCK_COUNT),
+			host->base + HW_SSP_BLOCK_SIZE);
+	}
+
+	if ((cmd->opcode == MMC_STOP_TRANSMISSION) ||
+			(cmd->opcode == SD_IO_RW_EXTENDED))
+		cmd0 |= BM_SSP_CMD0_APPEND_8CYC;
+
+	cmd1 = cmd->arg;
+
+	if (host->sdio_irq_en) {
+		ctrl0 |= BM_SSP_CTRL0_SDIO_IRQ_CHECK;
+		cmd0 |= BM_SSP_CMD0_CONT_CLKING_EN | BM_SSP_CMD0_SLOW_CLKING_EN;
+	}
+
+	/* set the timeout count */
+	timeout = mxs_ns_to_ssp_ticks(host->clk_rate, cmd->data->timeout_ns);
+	val = __raw_readl(host->base + HW_SSP_TIMING);
+	val &= ~(BM_SSP_TIMING_TIMEOUT);
+	val |= BF_SSP(timeout, SSP_TIMING_TIMEOUT);
+	__raw_writel(val, host->base + HW_SSP_TIMING);
+
+	/* pio dma */
+	ssp_pio_words[0] = ctrl0;
+	ssp_pio_words[1] = cmd0;
+	ssp_pio_words[2] = cmd1;
+	mxs_mmc_do_dma(host, DMA_NONE, 0);
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R3:
+		cmd->resp[0] = __raw_readl(host->base + HW_SSP_SDRESP0);
+		break;
+	case MMC_RSP_R2:
+		cmd->resp[3] = __raw_readl(host->base + HW_SSP_SDRESP0);
+		cmd->resp[2] = __raw_readl(host->base + HW_SSP_SDRESP1);
+		cmd->resp[1] = __raw_readl(host->base + HW_SSP_SDRESP2);
+		cmd->resp[0] = __raw_readl(host->base + HW_SSP_SDRESP3);
+		break;
+	default:
+		dev_warn(host->dev, "unsupported response type 0x%x\n",
+						mmc_resp_type(cmd));
+		BUG();
+		break;
+	}
+
+	/* data dma */
+	mxs_mmc_do_dma(host, host->dma_dir, 1);
+
+	cmd->data->bytes_xfered = data_size;
+
+	cmd->error = mxs_mmc_cmd_error(host->status);
+	if (cmd->error)
+		dev_dbg(host->dev, "%s: command error %d, status 0x%08x\n",
+					__func__, cmd->error, host->status);
+}
+
+static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
+				   struct mmc_command *cmd)
+{
+	host->cmd = cmd;
+
+	switch (mmc_cmd_type(cmd)) {
+	case MMC_CMD_BC:
+		mxs_mmc_bc(host);
+		break;
+	case MMC_CMD_BCR:
+		mxs_mmc_ac(host);
+		break;
+	case MMC_CMD_AC:
+		mxs_mmc_ac(host);
+		break;
+	case MMC_CMD_ADTC:
+		mxs_mmc_adtc(host);
+		break;
+	default:
+		dev_warn(host->dev, "unknown MMC command\n");
+		BUG();
+		break;
+	}
+}
+
+static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+
+	BUG_ON(host->mrq != NULL);
+
+	host->mrq = mrq;
+	mxs_mmc_start_cmd(host, mrq->cmd);
+
+	if (mrq->data && mrq->data->stop) {
+		dev_dbg(host->dev, "Stop opcode is %u\n",
+				mrq->data->stop->opcode);
+		mxs_mmc_start_cmd(host, mrq->data->stop);
+	}
+
+	host->mrq = NULL;
+	mmc_request_done(mmc, mrq);
+}
+
+static void mxs_mmc_set_clk_rate(struct mxs_mmc_host *host, unsigned int rate)
+{
+	unsigned int ssp_rate, bit_rate;
+	u32 div1, div2;
+	u32 val;
+
+	ssp_rate = clk_get_rate(host->clk);
+
+	for (div1 = 2; div1 < 254; div1 += 2) {
+		div2 = ssp_rate / rate / div1;
+		if (div2 < 0x100)
+			break;
+	}
+
+	if (div1 >= 254) {
+		dev_err(host->dev, "cannot set clock to %d\n", rate);
+		return;
+	}
+
+	if (div2 == 0)
+		bit_rate = ssp_rate / div1;
+	else
+		bit_rate = ssp_rate / div1 / div2;
+
+	val = __raw_readl(host->base + HW_SSP_TIMING);
+	val &= ~(BM_SSP_TIMING_CLOCK_DIVIDE | BM_SSP_TIMING_CLOCK_RATE);
+	val |= BF_SSP(div1, SSP_TIMING_CLOCK_DIVIDE);
+	val |= BF_SSP(div2 - 1, SSP_TIMING_CLOCK_RATE);
+	__raw_writel(val, host->base + HW_SSP_TIMING);
+
+	host->clk_rate = bit_rate;
+
+	dev_dbg(host->dev, "div1 %d, div2 %d, ssp %d, bit %d, rate %d\n",
+				div1, div2, ssp_rate, bit_rate, rate);
+}
+
+static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+
+	if (ios->bus_width == MMC_BUS_WIDTH_8)
+		host->bus_width = 2;
+	else if (ios->bus_width == MMC_BUS_WIDTH_4)
+		host->bus_width = 1;
+	else
+		host->bus_width = 0;
+
+	if (ios->clock)
+		mxs_mmc_set_clk_rate(host, ios->clock);
+}
+
+static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	host->sdio_irq_en = enable;
+
+	if (enable) {
+		__mxs_setl(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
+				host->base + HW_SSP_CTRL0);
+		__mxs_setl(BM_SSP_CTRL1_SDIO_IRQ_EN,
+				host->base + HW_SSP_CTRL1);
+
+		if (__raw_readl(host->base + HW_SSP_STATUS) &
+					BM_SSP_STATUS_SDIO_IRQ)
+			mmc_signal_sdio_irq(host->mmc);
+
+	} else {
+		__mxs_clrl(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
+				host->base + HW_SSP_CTRL0);
+		__mxs_clrl(BM_SSP_CTRL1_SDIO_IRQ_EN,
+				host->base + HW_SSP_CTRL1);
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static const struct mmc_host_ops mxs_mmc_ops = {
+	.request = mxs_mmc_request,
+	.get_ro = mxs_mmc_get_ro,
+	.set_ios = mxs_mmc_set_ios,
+	.enable_sdio_irq = mxs_mmc_enable_sdio_irq,
+};
+
+static bool mxs_mmc_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct mxs_mmc_host *host = param;
+
+	/* apbh dma gets dev_id 0 */
+	if (chan->device->dev_id)
+		return false;
+
+	if (chan->chan_id != host->dma_res->start)
+		return false;
+
+	chan->private = &host->dma_data;
+
+	return true;
+}
+
+static int mxs_mmc_probe(struct platform_device *pdev)
+{
+	struct mxs_mmc_host *host;
+	struct mmc_host *mmc;
+	struct resource *iores, *dmares, *r;
+	int ret = 0, irq_err, irq_dma;
+	dma_cap_mask_t mask;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	irq_err = platform_get_irq(pdev, 0);
+	irq_dma = platform_get_irq(pdev, 1);
+	if (!iores || !dmares || irq_err < 0 || irq_dma < 0)
+		return -EINVAL;
+
+	r = request_mem_region(iores->start, resource_size(iores), pdev->name);
+	if (!r)
+		return -EBUSY;
+
+	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto out_release_mem;
+	}
+
+	host = mmc_priv(mmc);
+	host->base = ioremap(r->start, resource_size(r));
+	if (!host->base) {
+		ret = -ENOMEM;
+		goto out_mmc_free;
+	}
+
+	/* only major verion does matter */
+	host->version = __raw_readl(host->base + HW_SSP_VERSION) >>
+					BP_SSP_VERSION_MAJOR;
+
+	host->mmc = mmc;
+	host->dev = &pdev->dev;
+	host->res = r;
+	host->dma_res = dmares;
+	host->irq = irq_err;
+	host->sdio_irq_en = 0;
+
+	host->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(host->clk)) {
+		ret = PTR_ERR(host->clk);
+		goto out_iounmap;
+	}
+	clk_enable(host->clk);
+
+	mxs_mmc_reset(host);
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	host->dma_data.chan_irq = irq_dma;
+	host->dmach = dma_request_channel(mask, mxs_mmc_dma_filter, host);
+	if (!host->dmach) {
+		dev_err(host->dev, "failed to request dma\n");
+		goto out_clk_put;
+	}
+
+	/* set mmc core parameters */
+	mmc->ops = &mxs_mmc_ops;
+	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
+		    MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
+		    MMC_CAP_SDIO_IRQ;
+
+	mmc->f_min = 400000;
+	mmc->f_max = 288000000;
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
+	mmc->max_segs = 53;
+	mmc->max_blk_size = 1 << 0xf;
+	mmc->max_blk_count = (ssp_is_old()) ? 0xff : 0xffffff;
+	mmc->max_req_size = (ssp_is_old()) ? 0xffff : 0xffffffff;
+	mmc->max_seg_size = dma_get_max_seg_size(host->dmach->device->dev);
+
+	ret = request_irq(host->irq, mxs_mmc_irq_handler, 0,
+				DRIVER_NAME, host);
+	if (ret)
+		goto out_free_dma;
+
+	/* current card status */
+	host->present = mxs_mmc_is_plugged(host);
+
+	/* card detection polling timer */
+	init_timer(&host->timer);
+	host->timer.function = mxs_mmc_detect_poll;
+	host->timer.data = (unsigned long) host;
+	host->timer.expires = jiffies + MXS_MMC_DETECT_TIMEOUT;
+	add_timer(&host->timer);
+
+	platform_set_drvdata(pdev, mmc);
+
+	spin_lock_init(&host->lock);
+
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto out_del_timer;
+
+	dev_info(host->dev, "initialized\n");
+
+	return 0;
+
+out_del_timer:
+	del_timer(&host->timer);
+	free_irq(host->irq, host);
+out_free_dma:
+	if (host->dmach)
+		dma_release_channel(host->dmach);
+out_clk_put:
+	clk_disable(host->clk);
+	clk_put(host->clk);
+out_iounmap:
+	iounmap(host->base);
+out_mmc_free:
+	mmc_free_host(mmc);
+out_release_mem:
+	release_mem_region(iores->start, resource_size(iores));
+	return ret;
+}
+
+static int mxs_mmc_remove(struct platform_device *pdev)
+{
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+
+	platform_set_drvdata(pdev, NULL);
+
+	mmc_remove_host(mmc);
+
+	del_timer(&host->timer);
+
+	free_irq(host->irq, host);
+
+	if (host->dmach)
+		dma_release_channel(host->dmach);
+
+	clk_disable(host->clk);
+	clk_put(host->clk);
+
+	iounmap(host->base);
+
+	mmc_free_host(mmc);
+
+	release_mem_region(host->res->start, resource_size(host->res));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mxs_mmc_suspend(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+	int ret = 0;
+
+	if (mmc)
+		ret = mmc_suspend_host(mmc);
+
+	clk_disable(host->clk);
+
+	return ret;
+}
+
+static int mxs_mmc_resume(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mxs_mmc_host *host = mmc_priv(mmc);
+	int ret = 0;
+
+	clk_enable(host->clk);
+
+	if (mmc)
+		ret = mmc_resume_host(mmc);
+
+	return ret;
+}
+
+static const struct dev_pm_ops mxs_mmc_pm_ops = {
+	.suspend	= mxs_mmc_suspend,
+	.resume		= mxs_mmc_resume,
+};
+#endif
+
+static struct platform_driver mxs_mmc_driver = {
+	.probe		= mxs_mmc_probe,
+	.remove		= mxs_mmc_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &mxs_mmc_pm_ops,
+#endif
+	},
+};
+
+static int __init mxs_mmc_init(void)
+{
+	return platform_driver_register(&mxs_mmc_driver);
+}
+
+static void __exit mxs_mmc_exit(void)
+{
+	platform_driver_unregister(&mxs_mmc_driver);
+}
+
+module_init(mxs_mmc_init);
+module_exit(mxs_mmc_exit);
+
+MODULE_DESCRIPTION("FREESCALE MXS MMC peripheral");
+MODULE_LICENSE("GPL");
-- 
1.7.1
