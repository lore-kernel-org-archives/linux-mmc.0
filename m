From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V8] mmc : Add i.MX21 support to mxcmmc driver
Date: Thu, 16 Sep 2010 13:07:29 +0200
Message-ID: <20100916110729.GU1473@pengutronix.de>
References: <20100909220110.12456.14417.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57640 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0IPLHb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2010 07:07:31 -0400
Content-Disposition: inline
In-Reply-To: <20100909220110.12456.14417.stgit@srv002.fuzzey.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Fuzzey <mfuzzey@gmail.com>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org

On Fri, Sep 10, 2010 at 12:02:44AM +0200, Martin Fuzzey wrote:
> Even though the i.MX21 SDHC module has the same revision number as the i.MX27
> one there are a few differences!!
>         Some interrupt enables are inverted.
>         FIFO is only 16 bits wide.
>         The argument is written to 2x16bit registers (vs 1x32).
>         Interrupts must be acknowledged via the INT_CNTR register.
>         Card clock must be enabled for each request.
> 	For writes DMA must be enabled on command response not before.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>
> 
> ---
> Changes from V7 (February 2010):
> Rebased to 2.6.36-rc3
> 
>  arch/arm/mach-imx/clock-imx21.c |    4 +
>  drivers/mmc/host/mxcmmc.c       |  153 ++++++++++++++++++++++++++++++---------
>  2 files changed, 120 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
> index dafc271..076cd43 100644
> --- a/arch/arm/mach-imx/clock-imx21.c
> +++ b/arch/arm/mach-imx/clock-imx21.c
> @@ -1170,8 +1170,8 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[1])
>  	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[2])
>  	_REGISTER_CLOCK(NULL, "pwm", pwm_clk[0])
> -	_REGISTER_CLOCK(NULL, "sdhc1", sdhc_clk[0])
> -	_REGISTER_CLOCK(NULL, "sdhc2", sdhc_clk[1])
> +	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc_clk[0])
> +	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc_clk[1])
>  	_REGISTER_CLOCK(NULL, "cspi1", cspi_clk[0])
>  	_REGISTER_CLOCK(NULL, "cspi2", cspi_clk[1])
>  	_REGISTER_CLOCK(NULL, "cspi3", cspi_clk[2])

Please make a seperate patch from this hunk. This should go via the i.MX
tree.

I will give this a runtime test on !i.MX21 tomorrow. Otherwise the patch
looks fine to me.

Sascha

> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 350f78e..88dd31f 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -56,6 +56,8 @@
>  #define MMC_REG_INT_CNTR		0x24
>  #define MMC_REG_CMD			0x28
>  #define MMC_REG_ARG			0x2C
> +#define MMC_REG_ARGH			0x2C
> +#define MMC_REG_ARGL			0x30
>  #define MMC_REG_RES_FIFO		0x34
>  #define MMC_REG_BUFFER_ACCESS		0x38
>  
> @@ -145,6 +147,49 @@ struct mxcmci_host {
>  
>  static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
>  
> +static void mxcmci_write_arg(struct mxcmci_host *host, u32 arg)
> +{
> +	if (cpu_is_mx21()) {
> +		writel(arg >> 16, host->base + MMC_REG_ARGH);
> +		writel(arg & 0xFFFF, host->base + MMC_REG_ARGL);
> +	} else {
> +		writel(arg, host->base + MMC_REG_ARG);
> +	}
> +}
> +
> +static void mxcmci_ack_int(struct mxcmci_host *host, u32 stat)
> +{
> +	if (cpu_is_mx21()) {
> +		u32 intclr = readl(host->base + MMC_REG_INT_CNTR);
> +
> +		if (stat & STATUS_DATA_TRANS_DONE)
> +			intclr |= INT_READ_OP_EN;
> +		if (stat & STATUS_WRITE_OP_DONE)
> +			intclr |= INT_WRITE_OP_DONE_EN;
> +		if (stat & STATUS_END_CMD_RESP)
> +			intclr |= INT_END_CMD_RES_EN;
> +
> +		writel(intclr, host->base + MMC_REG_INT_CNTR);
> +	}
> +}
> +
> +static inline void mxcmci_set_int_cntr(struct mxcmci_host *host, u32 enables)
> +{
> +	if (cpu_is_mx21()) /* some interrupt enables have reverse polarity */
> +		enables ^=  0x1F;
> +	writel(enables, host->base + MMC_REG_INT_CNTR);
> +}
> +
> +static inline void mxcmci_start_clock(struct mxcmci_host *host)
> +{
> +	writew(STR_STP_CLK_START_CLK, host->base + MMC_REG_STR_STP_CLK);
> +}
> +
> +static inline void mxcmci_stop_clock(struct mxcmci_host *host)
> +{
> +	writew(STR_STP_CLK_STOP_CLK, host->base + MMC_REG_STR_STP_CLK);
> +}
> +
>  static inline int mxcmci_use_dma(struct mxcmci_host *host)
>  {
>  	return host->do_dma;
> @@ -221,7 +266,10 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  	}
>  	wmb();
>  
> -	imx_dma_enable(host->dma);
> +	/* MX21: unreliable writes if dma enabled here - do on command done */
> +	if (mxcmci_use_dma(host) &&
> +			(!cpu_is_mx21() || host->dma_dir == DMA_FROM_DEVICE))
> +		imx_dma_enable(host->dma);
>  #endif /* HAS_DMA */
>  	return 0;
>  }
> @@ -263,12 +311,16 @@ static int mxcmci_start_cmd(struct mxcmci_host *host, struct mmc_command *cmd,
>  	spin_lock_irqsave(&host->lock, flags);
>  	if (host->use_sdio)
>  		int_cntr |= INT_SDIO_IRQ_EN;
> -	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
> +	mxcmci_set_int_cntr(host, int_cntr);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	writew(cmd->opcode, host->base + MMC_REG_CMD);
> -	writel(cmd->arg, host->base + MMC_REG_ARG);
> +	mxcmci_write_arg(host, cmd->arg);
>  	writew(cmdat, host->base + MMC_REG_CMD_DAT_CONT);
> +	if (cpu_is_mx21()) {
> +		/* i.MX21 requires clock start after submitting command */
> +		mxcmci_start_clock(host);
> +	}
>  
>  	return 0;
>  }
> @@ -282,7 +334,7 @@ static void mxcmci_finish_request(struct mxcmci_host *host,
>  	spin_lock_irqsave(&host->lock, flags);
>  	if (host->use_sdio)
>  		int_cntr |= INT_SDIO_IRQ_EN;
> -	writel(int_cntr, host->base + MMC_REG_INT_CNTR);
> +	mxcmci_set_int_cntr(host, int_cntr);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	host->req = NULL;
> @@ -397,19 +449,29 @@ static int mxcmci_poll_status(struct mxcmci_host *host, u32 mask)
>  static int mxcmci_pull(struct mxcmci_host *host, void *_buf, int bytes)
>  {
>  	unsigned int stat;
> -	u32 *buf = _buf;
> -
> -	while (bytes > 3) {
> -		stat = mxcmci_poll_status(host,
> +	u16 *buf16 = _buf;
> +	u32 *buf32 = _buf;
> +	int count = 0;
> +	int fifo_size = host->cmdat & CMD_DAT_CONT_BUS_WIDTH_4 ? 64 : 16;
> +	int buffer_width = cpu_is_mx21() ? 2 : 4;
> +
> +	while (bytes >= buffer_width) {
> +		if (count % fifo_size == 0) {
> +			stat = mxcmci_poll_status(host,
>  				STATUS_BUF_READ_RDY | STATUS_READ_OP_DONE);
> -		if (stat)
> -			return stat;
> -		*buf++ = readl(host->base + MMC_REG_BUFFER_ACCESS);
> -		bytes -= 4;
> +			if (stat)
> +				return stat;
> +		}
> +		if (buffer_width == 2)
> +			*buf16++ = (u16)readl(
> +				host->base + MMC_REG_BUFFER_ACCESS);
> +		else
> +			*buf32++ = readl(host->base + MMC_REG_BUFFER_ACCESS);
> +		bytes -= buffer_width;
> +		count += buffer_width;
>  	}
>  
>  	if (bytes) {
> -		u8 *b = (u8 *)buf;
>  		u32 tmp;
>  
>  		stat = mxcmci_poll_status(host,
> @@ -417,7 +479,10 @@ static int mxcmci_pull(struct mxcmci_host *host, void *_buf, int bytes)
>  		if (stat)
>  			return stat;
>  		tmp = readl(host->base + MMC_REG_BUFFER_ACCESS);
> -		memcpy(b, &tmp, bytes);
> +		if (buffer_width == 2)
> +			memcpy((u8 *)buf16, &tmp, bytes);
> +		else
> +			memcpy((u8 *)buf32, &tmp, bytes);
>  	}
>  
>  	return 0;
> @@ -426,33 +491,41 @@ static int mxcmci_pull(struct mxcmci_host *host, void *_buf, int bytes)
>  static int mxcmci_push(struct mxcmci_host *host, void *_buf, int bytes)
>  {
>  	unsigned int stat;
> -	u32 *buf = _buf;
> -
> -	while (bytes > 3) {
> -		stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
> -		if (stat)
> -			return stat;
> -		writel(*buf++, host->base + MMC_REG_BUFFER_ACCESS);
> -		bytes -= 4;
> +	u16 *buf16 = _buf;
> +	u32 *buf32 = _buf;
> +	int count = 0;
> +	int fifo_size = host->cmdat & CMD_DAT_CONT_BUS_WIDTH_4 ? 64 : 16;
> +	int buffer_width = cpu_is_mx21() ? 2 : 4;
> +
> +	while (bytes >= buffer_width) {
> +		if (count % fifo_size == 0) {
> +			stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
> +			if (stat)
> +				return stat;
> +		}
> +		if (buffer_width == 2)
> +			writel(*buf16++, host->base + MMC_REG_BUFFER_ACCESS);
> +		else
> +			writel(*buf32++, host->base + MMC_REG_BUFFER_ACCESS);
> +		bytes -= buffer_width;
> +		count += buffer_width;
>  	}
>  
>  	if (bytes) {
> -		u8 *b = (u8 *)buf;
>  		u32 tmp;
>  
>  		stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
>  		if (stat)
>  			return stat;
>  
> -		memcpy(&tmp, b, bytes);
> +		if (buffer_width == 2)
> +			memcpy(&tmp, (u8 *)buf16, bytes);
> +		else
> +			memcpy(&tmp, (u8 *)buf32, bytes);
>  		writel(tmp, host->base + MMC_REG_BUFFER_ACCESS);
>  	}
>  
> -	stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
> -	if (stat)
> -		return stat;
> -
> -	return 0;
> +	return mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
>  }
>  
>  static int mxcmci_transfer_data(struct mxcmci_host *host)
> @@ -540,13 +613,20 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
>  		return;
>  	}
>  
> +	if (!host->data)
> +		return;
> +
> +#ifdef HAS_DMA
>  	/* For the DMA case the DMA engine handles the data transfer
>  	 * automatically. For non DMA we have to do it ourselves.
>  	 * Don't do it in interrupt context though.
>  	 */
> -	if (!mxcmci_use_dma(host) && host->data)
> +	if (mxcmci_use_dma(host)) {
> +		if (cpu_is_mx21() && host->dma_dir == DMA_TO_DEVICE)
> +			imx_dma_enable(host->dma);
> +	} else
> +#endif
>  		schedule_work(&host->datawork);
> -
>  }
>  
>  static irqreturn_t mxcmci_irq(int irq, void *devid)
> @@ -559,6 +639,7 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
>  	stat = readl(host->base + MMC_REG_STATUS);
>  	writel(stat & ~(STATUS_SDIO_INT_ACTIVE | STATUS_DATA_TRANS_DONE |
>  			STATUS_WRITE_OP_DONE), host->base + MMC_REG_STATUS);
> +	mxcmci_ack_int(host, stat);
>  
>  	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
>  
> @@ -689,9 +770,9 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	if (ios->clock) {
>  		mxcmci_set_clk_rate(host, ios->clock);
> -		writew(STR_STP_CLK_START_CLK, host->base + MMC_REG_STR_STP_CLK);
> +		mxcmci_start_clock(host);
>  	} else {
> -		writew(STR_STP_CLK_STOP_CLK, host->base + MMC_REG_STR_STP_CLK);
> +		mxcmci_stop_clock(host);
>  	}
>  
>  	host->clock = ios->clock;
> @@ -845,7 +926,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>  	/* recommended in data sheet */
>  	writew(0x2db4, host->base + MMC_REG_READ_TO);
>  
> -	writel(host->default_irq_mask, host->base + MMC_REG_INT_CNTR);
> +	mxcmci_set_int_cntr(host, host->default_irq_mask);
>  
>  #ifdef HAS_DMA
>  	host->dma = imx_dma_request_by_prio(DRIVER_NAME, DMA_PRIO_LOW);
> @@ -862,7 +943,9 @@ static int mxcmci_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = imx_dma_config_channel(host->dma,
> -				     IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_FIFO,
> +				    (cpu_is_mx21() ?
> +					IMX_DMA_MEMSIZE_16 : IMX_DMA_MEMSIZE_32)
> +					| IMX_DMA_TYPE_FIFO,
>  				     IMX_DMA_MEMSIZE_32 | IMX_DMA_TYPE_LINEAR,
>  				     r->start, 0);
>  	if (ret) {
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
