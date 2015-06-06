From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mmc: host: pxamci: switch over to dmaengine use
Date: Sat,  6 Jun 2015 23:15:22 +0200
Message-ID: <1433625322-28449-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:17795 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbFFVRJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Jun 2015 17:17:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>

From: Daniel Mack <zonque@gmail.com>

Switch over pxamci to dmaengine. This prepares the devicetree full
support of pxamci.

This was successfully tested on a PXA3xx board, as well as PXA27x.

Signed-off-by: Daniel Mack <zonque@gmail.com>
[adapted to pxa-dma]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mmc/host/pxamci.c | 200 ++++++++++++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 86 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 1b6d0bf..1420f29 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -22,7 +22,9 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/pxa-dma.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/mmc/host.h>
@@ -37,7 +39,6 @@
 #include <asm/sizes.h>
 
 #include <mach/hardware.h>
-#include <mach/dma.h>
 #include <linux/platform_data/mmc-pxamci.h>
 
 #include "pxamci.h"
@@ -58,7 +59,6 @@ struct pxamci_host {
 	struct clk		*clk;
 	unsigned long		clkrate;
 	int			irq;
-	int			dma;
 	unsigned int		clkrt;
 	unsigned int		cmdat;
 	unsigned int		imask;
@@ -69,8 +69,10 @@ struct pxamci_host {
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
 
+	struct dma_chan		*dma_chan_rx;
+	struct dma_chan		*dma_chan_tx;
+	dma_cookie_t		dma_cookie;
 	dma_addr_t		sg_dma;
-	struct pxa_dma_desc	*sg_cpu;
 	unsigned int		dma_len;
 
 	unsigned int		dma_dir;
@@ -173,14 +175,18 @@ static void pxamci_disable_irq(struct pxamci_host *host, unsigned int mask)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void pxamci_dma_irq(void *param);
+
 static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 {
+	struct dma_async_tx_descriptor *tx;
+	enum dma_data_direction direction;
+	struct dma_slave_config	config;
+	struct dma_chan *chan;
 	unsigned int nob = data->blocks;
 	unsigned long long clks;
 	unsigned int timeout;
-	bool dalgn = 0;
-	u32 dcmd;
-	int i;
+	int ret;
 
 	host->data = data;
 
@@ -195,54 +201,48 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 	timeout = (unsigned int)clks + (data->timeout_clks << host->clkrt);
 	writel((timeout + 255) / 256, host->base + MMC_RDTO);
 
+	memset(&config, 0, sizeof(config));
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	config.src_addr = host->res->start + MMC_RXFIFO;
+	config.dst_addr = host->res->start + MMC_TXFIFO;
+	config.src_maxburst = 32;
+	config.dst_maxburst = 32;
+
 	if (data->flags & MMC_DATA_READ) {
 		host->dma_dir = DMA_FROM_DEVICE;
-		dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
-		DRCMR(host->dma_drcmrtx) = 0;
-		DRCMR(host->dma_drcmrrx) = host->dma | DRCMR_MAPVLD;
+		direction = DMA_DEV_TO_MEM;
+		chan = host->dma_chan_rx;
 	} else {
 		host->dma_dir = DMA_TO_DEVICE;
-		dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
-		DRCMR(host->dma_drcmrrx) = 0;
-		DRCMR(host->dma_drcmrtx) = host->dma | DRCMR_MAPVLD;
+		direction = DMA_MEM_TO_DEV;
+		chan = host->dma_chan_tx;
 	}
 
-	dcmd |= DCMD_BURST32 | DCMD_WIDTH1;
+	config.direction = direction;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret < 0) {
+		dev_err(mmc_dev(host->mmc), "dma slave config failed\n");
+		return;
+	}
 
-	host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+	host->dma_len = dma_map_sg(chan->device->dev, data->sg, data->sg_len,
 				   host->dma_dir);
 
-	for (i = 0; i < host->dma_len; i++) {
-		unsigned int length = sg_dma_len(&data->sg[i]);
-		host->sg_cpu[i].dcmd = dcmd | length;
-		if (length & 31 && !(data->flags & MMC_DATA_READ))
-			host->sg_cpu[i].dcmd |= DCMD_ENDIRQEN;
-		/* Not aligned to 8-byte boundary? */
-		if (sg_dma_address(&data->sg[i]) & 0x7)
-			dalgn = 1;
-		if (data->flags & MMC_DATA_READ) {
-			host->sg_cpu[i].dsadr = host->res->start + MMC_RXFIFO;
-			host->sg_cpu[i].dtadr = sg_dma_address(&data->sg[i]);
-		} else {
-			host->sg_cpu[i].dsadr = sg_dma_address(&data->sg[i]);
-			host->sg_cpu[i].dtadr = host->res->start + MMC_TXFIFO;
-		}
-		host->sg_cpu[i].ddadr = host->sg_dma + (i + 1) *
-					sizeof(struct pxa_dma_desc);
+	tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,
+				     DMA_PREP_INTERRUPT);
+	if (!tx) {
+		dev_err(mmc_dev(host->mmc), "prep_slave_sg() failed\n");
+		return;
 	}
-	host->sg_cpu[host->dma_len - 1].ddadr = DDADR_STOP;
-	wmb();
 
-	/*
-	 * The PXA27x DMA controller encounters overhead when working with
-	 * unaligned (to 8-byte boundaries) data, so switch on byte alignment
-	 * mode only if we have unaligned data.
-	 */
-	if (dalgn)
-		DALGN |= (1 << host->dma);
-	else
-		DALGN &= ~(1 << host->dma);
-	DDADR(host->dma) = host->sg_dma;
+	if (!(data->flags & MMC_DATA_READ)) {
+		tx->callback = pxamci_dma_irq;
+		tx->callback_param = host;
+	}
+
+	host->dma_cookie = dmaengine_submit(tx);
 
 	/*
 	 * workaround for erratum #91:
@@ -251,7 +251,7 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 	 * before starting DMA.
 	 */
 	if (!cpu_is_pxa27x() || data->flags & MMC_DATA_READ)
-		DCSR(host->dma) = DCSR_RUN;
+		dma_async_issue_pending(chan);
 }
 
 static void pxamci_start_cmd(struct pxamci_host *host, struct mmc_command *cmd, unsigned int cmdat)
@@ -343,7 +343,7 @@ static int pxamci_cmd_done(struct pxamci_host *host, unsigned int stat)
 		 * enable DMA late
 		 */
 		if (cpu_is_pxa27x() && host->data->flags & MMC_DATA_WRITE)
-			DCSR(host->dma) = DCSR_RUN;
+			dma_async_issue_pending(host->dma_chan_tx);
 	} else {
 		pxamci_finish_request(host, host->mrq);
 	}
@@ -354,13 +354,17 @@ static int pxamci_cmd_done(struct pxamci_host *host, unsigned int stat)
 static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 {
 	struct mmc_data *data = host->data;
+	struct dma_chan *chan;
 
 	if (!data)
 		return 0;
 
-	DCSR(host->dma) = 0;
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		     host->dma_dir);
+	if (data->flags & MMC_DATA_READ)
+		chan = host->dma_chan_rx;
+	else
+		chan = host->dma_chan_tx;
+	dma_unmap_sg(chan->device->dev,
+		     data->sg, data->sg_len, host->dma_dir);
 
 	if (stat & STAT_READ_TIME_OUT)
 		data->error = -ETIMEDOUT;
@@ -552,20 +556,37 @@ static const struct mmc_host_ops pxamci_ops = {
 	.enable_sdio_irq	= pxamci_enable_sdio_irq,
 };
 
-static void pxamci_dma_irq(int dma, void *devid)
+static void pxamci_dma_irq(void *param)
 {
-	struct pxamci_host *host = devid;
-	int dcsr = DCSR(dma);
-	DCSR(dma) = dcsr & ~DCSR_STOPIRQEN;
+	struct pxamci_host *host = param;
+	struct dma_tx_state state;
+	enum dma_status status;
+	struct dma_chan *chan;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (!host->data)
+		goto out_unlock;
 
-	if (dcsr & DCSR_ENDINTR) {
+	if (host->data->flags & MMC_DATA_READ)
+		chan = host->dma_chan_rx;
+	else
+		chan = host->dma_chan_tx;
+
+	status = dmaengine_tx_status(chan, host->dma_cookie, &state);
+
+	if (likely(status == DMA_COMPLETE)) {
 		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
 	} else {
-		pr_err("%s: DMA error on channel %d (DCSR=%#x)\n",
-		       mmc_hostname(host->mmc), dma, dcsr);
+		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
+			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
 		host->data->error = -EIO;
 		pxamci_data_done(host, 0);
 	}
+
+out_unlock:
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static irqreturn_t pxamci_detect_irq(int irq, void *devid)
@@ -625,7 +646,9 @@ static int pxamci_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct pxamci_host *host = NULL;
 	struct resource *r, *dmarx, *dmatx;
+	struct pxad_param param_rx, param_tx;
 	int ret, irq, gpio_cd = -1, gpio_ro = -1, gpio_power = -1;
+	dma_cap_mask_t mask;
 
 	ret = pxamci_of_init(pdev);
 	if (ret)
@@ -671,7 +694,6 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-	host->dma = -1;
 	host->pdata = pdev->dev.platform_data;
 	host->clkrt = CLKRT_OFF;
 
@@ -702,12 +724,6 @@ static int pxamci_probe(struct platform_device *pdev)
 				     MMC_CAP_SD_HIGHSPEED;
 	}
 
-	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE, &host->sg_dma, GFP_KERNEL);
-	if (!host->sg_cpu) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	spin_lock_init(&host->lock);
 	host->res = r;
 	host->irq = irq;
@@ -728,32 +744,45 @@ static int pxamci_probe(struct platform_device *pdev)
 	writel(64, host->base + MMC_RESTO);
 	writel(host->imask, host->base + MMC_I_MASK);
 
-	host->dma = pxa_request_dma(DRIVER_NAME, DMA_PRIO_LOW,
-				    pxamci_dma_irq, host);
-	if (host->dma < 0) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	ret = request_irq(host->irq, pxamci_irq, 0, DRIVER_NAME, host);
 	if (ret)
 		goto out;
 
 	platform_set_drvdata(pdev, mmc);
 
-	dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!dmarx) {
-		ret = -ENXIO;
+	if (!pdev->dev.of_node) {
+		dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (!dmarx || !dmatx) {
+			ret = -ENXIO;
+			goto out;
+		}
+		param_rx.prio = PXAD_PRIO_LOWEST;
+		param_rx.drcmr = dmarx->start;
+		param_tx.prio = PXAD_PRIO_LOWEST;
+		param_tx.drcmr = dmatx->start;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	host->dma_chan_rx =
+		dma_request_slave_channel_compat(mask, pxad_filter_fn,
+						 &param_rx, &pdev->dev, "rx");
+	if (host->dma_chan_rx == NULL) {
+		dev_err(&pdev->dev, "unable to request rx dma channel\n");
+		ret = -ENODEV;
 		goto out;
 	}
-	host->dma_drcmrrx = dmarx->start;
 
-	dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!dmatx) {
-		ret = -ENXIO;
+	host->dma_chan_tx =
+		dma_request_slave_channel_compat(mask, pxad_filter_fn,
+						 &param_tx,  &pdev->dev, "tx");
+	if (host->dma_chan_tx == NULL) {
+		dev_err(&pdev->dev, "unable to request tx dma channel\n");
+		ret = -ENODEV;
 		goto out;
 	}
-	host->dma_drcmrtx = dmatx->start;
 
 	if (host->pdata) {
 		gpio_cd = host->pdata->gpio_card_detect;
@@ -814,12 +843,12 @@ err_gpio_ro:
 	gpio_free(gpio_power);
  out:
 	if (host) {
-		if (host->dma >= 0)
-			pxa_free_dma(host->dma);
+		if (host->dma_chan_rx)
+			dma_release_channel(host->dma_chan_rx);
+		if (host->dma_chan_tx)
+			dma_release_channel(host->dma_chan_tx);
 		if (host->base)
 			iounmap(host->base);
-		if (host->sg_cpu)
-			dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 		if (host->clk)
 			clk_put(host->clk);
 	}
@@ -863,13 +892,12 @@ static int pxamci_remove(struct platform_device *pdev)
 		       END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
 		       host->base + MMC_I_MASK);
 
-		DRCMR(host->dma_drcmrrx) = 0;
-		DRCMR(host->dma_drcmrtx) = 0;
-
 		free_irq(host->irq, host);
-		pxa_free_dma(host->dma);
+		dmaengine_terminate_all(host->dma_chan_rx);
+		dmaengine_terminate_all(host->dma_chan_tx);
+		dma_release_channel(host->dma_chan_rx);
+		dma_release_channel(host->dma_chan_tx);
 		iounmap(host->base);
-		dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 
 		clk_put(host->clk);
 
-- 
2.1.4

