From: Marek Vasut <marex@denx.de>
Subject: Re: mmc: mxs: DEADLOCK
Date: Tue, 10 Jul 2012 17:02:52 +0200
Message-ID: <201207101702.52632.marex@denx.de>
References: <4FFC367A.8020100@bluegiga.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44517 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab2GJPCz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 11:02:55 -0400
In-Reply-To: <4FFC367A.8020100@bluegiga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Koen Beel <koen.beel@barco.com>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

Dear Lauri Hintsala,

[...]

> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int irq,
> void *dev_id)
>   	writel(stat & MXS_MMC_IRQ_BITS,
>   	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
> 
> +	spin_unlock(&host->lock);
> +
>   	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
>   		mmc_signal_sdio_irq(host->mmc);
> 
> -	spin_unlock(&host->lock);
> -

Spinlock in irq handler is interesting too ;-)

>   	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
>   		cmd->error = -ETIMEDOUT;
>   	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
> 
> 
> Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
> mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
> acquire lock while it is already acquired.
> 
> 
> Best regards,
> Lauri Hintsala

Best regards,
Marek Vasut
