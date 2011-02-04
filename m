From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Fri, 4 Feb 2011 21:26:52 +0100
Message-ID: <201102042126.52701.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64189 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab1BDU1O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 15:27:14 -0500
In-Reply-To: <1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>, cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org

On Saturday 05 February 2011 03:18:41 Shawn Guo wrote:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.

Hi Shawn,

The driver looks good coding-style wise, but it's my impression that
you do some thing less efficient or more complex than necessary. To
be more specific:

> +struct mxs_mmc_host {

It seems you have a number of members in this struct that only
add confusion but are not actually needed, so just get rid of
them:

> +	struct device			*dev;

mmc_host->parent ?

> +	struct resource			*res;
> +	struct resource			*dma_res;
> +	struct clk			*clk;

are visible in the parent.

> +	unsigned int			version;

unused

> +	struct mmc_command		*cmd;

mrq->cmd ?

> +	struct mmc_data			*data;

unused

> +	unsigned			present:1;

Your card detection by polling through this variable is
really bad for power management. Is there really no interrupt
that gets triggered when installing or removing a card?

Also, please try to avoid bit fields. 'bool' variables are
fine for flags.

> +	unsigned int			dma_dir;

not needed, a local variable would be just fine.

> +	struct mxs_dma_data		dma_data;

Why do you need host specific DMA structures? Please stick to
the generic dma-engine API if possible.

> +	struct completion 		done;

The mmc layer already comes with a generic completion that you
can and should use, mainly for performance reasons. Adding your
own completion forces every single request to go through an
additional context switch, compared to just returning from
the request function when you have scheduled the command, and
calling mmc_request_done from the interrupt handler.

> +	u32				status;

Won't be needed any more when you complete the requests at
interrupt time.

> +#define SSP_PIO_NUM	3
> +static u32 ssp_pio_words[SSP_PIO_NUM];

I don't think this is safe: This is a global variable, so if you have
multiple controllers, they would access the same data. Why not integrate
it into the host data structure?

> +
> +static void mxs_mmc_reset(struct mxs_mmc_host *host)
> +{
> +	u32 ctrl0, ctrl1;
> +
> +	mxs_reset_block(host->base);
> +
> +	ctrl0 = BM_SSP_CTRL0_IGNORE_CRC;
> +	ctrl1 = BF_SSP(0x3, SSP_CTRL1_SSP_MODE) |
> +		BF_SSP(0x7, SSP_CTRL1_WORD_LENGTH) |
> +		BM_SSP_CTRL1_DMA_ENABLE |
> +		BM_SSP_CTRL1_POLARITY |
> +		BM_SSP_CTRL1_RECV_TIMEOUT_IRQ_EN |
> +		BM_SSP_CTRL1_DATA_CRC_IRQ_EN |
> +		BM_SSP_CTRL1_DATA_TIMEOUT_IRQ_EN |
> +		BM_SSP_CTRL1_RESP_TIMEOUT_IRQ_EN |
> +		BM_SSP_CTRL1_RESP_ERR_IRQ_EN;
> +
> +	__raw_writel(BF_SSP(0xffff, SSP_TIMING_TIMEOUT) |
> +		     BF_SSP(2, SSP_TIMING_CLOCK_DIVIDE) |
> +		     BF_SSP(0, SSP_TIMING_CLOCK_RATE),
> +		     host->base + HW_SSP_TIMING);

Please use proper MMIO accessors like writel() and readl() that
are known to be safe here. The __raw_ variants are not really
meant for device drivers, which can lead to very subtle bugs.

> +static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
> +{
> +	struct mxs_mmc_host *host = dev_id;
> +	u32 stat;
> +
> +	stat = __raw_readl(host->base + HW_SSP_CTRL1);
> +	__mxs_clrl(stat & MXS_MMC_IRQ_BITS, host->base + HW_SSP_CTRL1);
> +
> +	if (host->cmd && (stat & MXS_MMC_ERR_BITS))
> +		host->status = __raw_readl(host->base + HW_SSP_STATUS);
> +
> +	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> +		mmc_signal_sdio_irq(host->mmc);
> +
> +	return IRQ_HANDLED;
> +}

You use spin_lock_irqsave in mxs_mmc_enable_sdio_irq, but don't
actually use the spinlock in the interrupt handler. This means
that either your interrupt handler is broken because it doesn't
lock, or that you don't actually need the _irqsave part.

> +static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct mxs_mmc_host *host = mmc_priv(mmc);
> +
> +	BUG_ON(host->mrq != NULL);
> +
> +	host->mrq = mrq;
> +	mxs_mmc_start_cmd(host, mrq->cmd);
> +
> +	if (mrq->data && mrq->data->stop) {
> +		dev_dbg(host->dev, "Stop opcode is %u\n",
> +				mrq->data->stop->opcode);
> +		mxs_mmc_start_cmd(host, mrq->data->stop);
> +	}
> +
> +	host->mrq = NULL;
> +	mmc_request_done(mmc, mrq);
> +}

As mentioned above, the mmc_request_done() shouldn't really be needed here,
it's more efficient to do it in the interrupt handler.

	Arnd
