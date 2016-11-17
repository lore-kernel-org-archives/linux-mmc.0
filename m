From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix the error handling for dma operation
Date: Thu, 17 Nov 2016 16:08:51 +0800
Message-ID: <75493dd3-f3c2-e7d7-0d21-01b430978cb6@rock-chips.com>
References: <20161117075347.9061-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:58815 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbcKQIJJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 03:09:09 -0500
In-Reply-To: <20161117075347.9061-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

Hi Jaehoon,

ÔÚ 2016/11/17 15:53, Jaehoon Chung Ð´µÀ:
> When OWN bit of dma descriptor is not cleared, then it returns -EINVAL.
> Then it has to fall back to PIO mode for current transfer.
>
> Host controller was already set to bits relevant to DMA operation.
> If needs to use the PIO mode, Host controller has to stop the DMA
> operation. (It's more stable than now.)
>

It looks good to me, but

> When it occurred error, it's not running any request.
>
> Fixes: 3b2a067b98b4 ("mmc: dw_mmc: avoid race condition of cpu and IDMAC")
>

I think the real fixes tag should indicate the another commit,
3fc7eaef44dbcbcd60 ("mmc: dw_mmc: Add external dma interface support")

otherwise,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9341b18..080003b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1058,6 +1058,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>  	spin_unlock_irqrestore(&host->irq_lock, irqflags);
>
>  	if (host->dma_ops->start(host, sg_len)) {
> +		host->dma_ops->stop(host);
>  		/* We can't do DMA, try PIO for this one */
>  		dev_dbg(host->dev,
>  			"%s: fall back to PIO mode for current transfer\n",
>


-- 
Best Regards
Shawn Lin

