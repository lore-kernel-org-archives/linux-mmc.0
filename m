From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 16 Feb 2011 05:26:11 +0800
Message-ID: <20110215212610.GE10990@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
 <20110213192609.GA21429@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:46121
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113Ab1BON13 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 08:27:29 -0500
Received: from mail24-va3 (localhost.localdomain [127.0.0.1])	by
 mail24-va3-R.bigfish.com (Postfix) with ESMTP id 983781C02A1	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 13:27:27 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.249])	by
 mail24-va3.bigfish.com (Postfix) with ESMTP id 072FC177004F	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 13:27:27 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id p1FDRM8V020399	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 06:27:22 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 p1FDRL7O007824	for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 07:27:21
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110213192609.GA21429@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Chris,

On Sun, Feb 13, 2011 at 07:26:09PM +0000, Chris Ball wrote:
> Hi Shawn,
> 
> On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Please add a Reviewed-by: from Arnd and a Tested-by: from Lothar.
> Could you add a MODULE_AUTHOR() field, too?
> 
OK.  It will be - MODULE_AUTHOR("Freescale Semiconductor");

> I could take the drivers/mmc files through the MMC tree and have you
> submit the architecture patches separately, or you can send everything
> through an ARM tree with my ACK -- whichever you prefer.
> 
I will send this single patch in v3 with new comments/concerns
addressed for you to pick up on  MMC tree, and follow up others with
Sascha.

> Here's an indentation patch:
> 
Thanks.

Regards,
Shawn

> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index f359093..3a609f9 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -127,13 +127,13 @@
>  #define BF_SSP(value, field)	(((value) << BP_SSP_##field) & BM_SSP_##field)
>  
>  #define MXS_MMC_IRQ_BITS	(BM_SSP_CTRL1_SDIO_IRQ		| \
> -				BM_SSP_CTRL1_RESP_ERR_IRQ	| \
> -				BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	| \
> -				BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	| \
> -				BM_SSP_CTRL1_DATA_CRC_IRQ	| \
> -				BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ	| \
> -				BM_SSP_CTRL1_RECV_TIMEOUT_IRQ   | \
> -				BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
> +				 BM_SSP_CTRL1_RESP_ERR_IRQ	| \
> +				 BM_SSP_CTRL1_RESP_TIMEOUT_IRQ	| \
> +				 BM_SSP_CTRL1_DATA_TIMEOUT_IRQ	| \
> +				 BM_SSP_CTRL1_DATA_CRC_IRQ	| \
> +				 BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ	| \
> +				 BM_SSP_CTRL1_RECV_TIMEOUT_IRQ  | \
> +				 BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
>  
>  #define SSP_PIO_NUM	3
>  
> @@ -165,7 +165,7 @@ static int mxs_mmc_get_ro(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
>  	struct mxs_mmc_platform_data *pdata =
> -			mmc_dev(host->mmc)->platform_data;
> +		mmc_dev(host->mmc)->platform_data;
>  
>  	if (!pdata)
>  		return -EFAULT;
> @@ -181,7 +181,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>  	struct mxs_mmc_host *host = mmc_priv(mmc);
>  
>  	return !(readl(host->base + HW_SSP_STATUS) &
> -			BM_SSP_STATUS_CARD_DETECT);
> +		 BM_SSP_STATUS_CARD_DETECT);
>  }
>  
>  static void mxs_mmc_reset(struct mxs_mmc_host *host)
> @@ -202,21 +202,21 @@ static void mxs_mmc_reset(struct mxs_mmc_host *host)
>  		BM_SSP_CTRL1_RESP_ERR_IRQ_EN;
>  
>  	writel(BF_SSP(0xffff, TIMING_TIMEOUT) |
> -		     BF_SSP(2, TIMING_CLOCK_DIVIDE) |
> -		     BF_SSP(0, TIMING_CLOCK_RATE),
> -		     host->base + HW_SSP_TIMING);
> +	       BF_SSP(2, TIMING_CLOCK_DIVIDE) |
> +	       BF_SSP(0, TIMING_CLOCK_RATE),
> +	       host->base + HW_SSP_TIMING);
>  
>  	if (host->sdio_irq_en) {
>  		ctrl0 |= BM_SSP_CTRL0_SDIO_IRQ_CHECK;
>  		ctrl1 |= BM_SSP_CTRL1_SDIO_IRQ_EN;
> -       }
> +	}
>  
>  	writel(ctrl0, host->base + HW_SSP_CTRL0);
>  	writel(ctrl1, host->base + HW_SSP_CTRL1);
>  }
>  
>  static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
> -				struct mmc_command *cmd);
> +			      struct mmc_command *cmd);
>  
>  static void mxs_mmc_request_done(struct mxs_mmc_host *host)
>  {
> @@ -240,13 +240,13 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
>  		break;
>  	default:
>  		dev_warn(mmc_dev(host->mmc),
> -			"%s: unsupported response type 0x%x\n",
> -			__func__, mmc_resp_type(cmd));
> +			 "%s: unsupported response type 0x%x\n",
> +			 __func__, mmc_resp_type(cmd));
>  	}
>  
>  	if (data) {
>  		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> -				data->sg_len, host->dma_dir);
> +			     data->sg_len, host->dma_dir);
>  		/*
>  		 * If there was an error on any block, we mark all
>  		 * data blocks as being in error.
> @@ -285,7 +285,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
>  
>  	stat = readl(host->base + HW_SSP_CTRL1);
>  	writel(stat & MXS_MMC_IRQ_BITS,
> -		host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
> +	       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
>  
>  	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>  		mmc_signal_sdio_irq(host->mmc);
> @@ -299,7 +299,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
>  
>  	if (data) {
>  		if (stat & (BM_SSP_CTRL1_DATA_TIMEOUT_IRQ |
> -				BM_SSP_CTRL1_RECV_TIMEOUT_IRQ))
> +			    BM_SSP_CTRL1_RECV_TIMEOUT_IRQ))
>  			data->error = -ETIMEDOUT;
>  		else if (stat & BM_SSP_CTRL1_DATA_CRC_IRQ)
>  			data->error = -EILSEQ;
> @@ -313,7 +313,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
>  }
>  
>  static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> -		struct mxs_mmc_host *host, unsigned int append)
> +	struct mxs_mmc_host *host, unsigned int append)
>  {
>  	struct dma_async_tx_descriptor *desc;
>  	struct mmc_data *data = host->data;
> @@ -323,7 +323,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
>  	if (data) {
>  		/* data */
>  		dma_map_sg(mmc_dev(host->mmc), data->sg,
> -				data->sg_len, host->dma_dir);
> +			   data->sg_len, host->dma_dir);
>  		sgl = data->sg;
>  		sg_len = data->sg_len;
>  	} else {
> @@ -340,7 +340,7 @@ static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
>  	} else {
>  		if (data)
>  			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> -					data->sg_len, host->dma_dir);
> +				     data->sg_len, host->dma_dir);
>  	}
>  
>  	return desc;
> @@ -374,7 +374,7 @@ static void mxs_mmc_bc(struct mxs_mmc_host *host)
>  
>  out:
>  	dev_warn(mmc_dev(host->mmc),
> -		"%s: failed to prep dma\n", __func__);
> +		 "%s: failed to prep dma\n", __func__);
>  }
>  
>  static void mxs_mmc_ac(struct mxs_mmc_host *host)
> @@ -413,7 +413,7 @@ static void mxs_mmc_ac(struct mxs_mmc_host *host)
>  
>  out:
>  	dev_warn(mmc_dev(host->mmc),
> -		"%s: failed to prep dma\n", __func__);
> +		 "%s: failed to prep dma\n", __func__);
>  }
>  
>  static unsigned short mxs_ns_to_ssp_ticks(unsigned clock_rate, unsigned ns)
> @@ -492,12 +492,12 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
>  	} else {
>  		writel(data_size, host->base + HW_SSP_XFER_SIZE);
>  		writel(BF_SSP(log2_blksz, BLOCK_SIZE_BLOCK_SIZE) |
> -			BF_SSP(blocks - 1, BLOCK_SIZE_BLOCK_COUNT),
> -			host->base + HW_SSP_BLOCK_SIZE);
> +		       BF_SSP(blocks - 1, BLOCK_SIZE_BLOCK_COUNT),
> +		       host->base + HW_SSP_BLOCK_SIZE);
>  	}
>  
>  	if ((cmd->opcode == MMC_STOP_TRANSMISSION) ||
> -			(cmd->opcode == SD_IO_RW_EXTENDED))
> +	    (cmd->opcode == SD_IO_RW_EXTENDED))
>  		cmd0 |= BM_SSP_CMD0_APPEND_8CYC;
>  
>  	cmd1 = cmd->arg;
> @@ -535,11 +535,11 @@ static void mxs_mmc_adtc(struct mxs_mmc_host *host)
>  	return;
>  out:
>  	dev_warn(mmc_dev(host->mmc),
> -		"%s: failed to prep dma\n", __func__);
> +		 "%s: failed to prep dma\n", __func__);
>  }
>  
>  static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
> -				   struct mmc_command *cmd)
> +			      struct mmc_command *cmd)
>  {
>  	host->cmd = cmd;
>  
> @@ -558,7 +558,7 @@ static void mxs_mmc_start_cmd(struct mxs_mmc_host *host,
>  		break;
>  	default:
>  		dev_warn(mmc_dev(host->mmc),
> -			"%s: unknown MMC command\n", __func__);
> +			 "%s: unknown MMC command\n", __func__);
>  		break;
>  	}
>  }
> @@ -636,18 +636,18 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  
>  	if (enable) {
>  		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
> -			host->base + HW_SSP_CTRL0 + MXS_SET_ADDR);
> +		       host->base + HW_SSP_CTRL0 + MXS_SET_ADDR);
>  		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> -			host->base + HW_SSP_CTRL1 + MXS_SET_ADDR);
> +		       host->base + HW_SSP_CTRL1 + MXS_SET_ADDR);
>  
>  		if (readl(host->base + HW_SSP_STATUS) & BM_SSP_STATUS_SDIO_IRQ)
>  			mmc_signal_sdio_irq(host->mmc);
>  
>  	} else {
>  		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
> -			host->base + HW_SSP_CTRL0 + MXS_CLR_ADDR);
> +		       host->base + HW_SSP_CTRL0 + MXS_CLR_ADDR);
>  		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> -			host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
> +		       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
>  	}
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
> @@ -710,7 +710,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  
>  	/* only major verion does matter */
>  	host->version = readl(host->base + HW_SSP_VERSION) >>
> -				BP_SSP_VERSION_MAJOR;
> +			BP_SSP_VERSION_MAJOR;
>  
>  	host->mmc = mmc;
>  	host->res = r;
> @@ -755,8 +755,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mmc);
>  
> -	ret = request_irq(host->irq, mxs_mmc_irq_handler, 0,
> -				DRIVER_NAME, host);
> +	ret = request_irq(host->irq, mxs_mmc_irq_handler, 0, DRIVER_NAME, host);
>  	if (ret)
>  		goto out_free_dma;
>  
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

