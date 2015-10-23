From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [patch] mmc: dw_mmc: NULL dereference in error message
Date: Fri, 23 Oct 2015 09:58:07 +0900
Message-ID: <5629861F.2060905@samsung.com>
References: <20151022195346.GD24439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-reply-to: <20151022195346.GD24439@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org, CPGS <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Thanks for pointing out.
I will pick this patch at my repository.

Best Regards,
Jaehoon Chung

On 10/23/2015 04:53 AM, Dan Carpenter wrote:
> The "host->dms->ch" pointer is NULL here so we can't use it to print the
> error message.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6e600e8..f877b2c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -752,9 +752,7 @@ static int dw_mci_edmac_init(struct dw_mci *host)
>  
>  	host->dms->ch = dma_request_slave_channel(host->dev, "rx-tx");
>  	if (!host->dms->ch) {
> -		dev_err(host->dev,
> -			"Failed to get external DMA channel %d\n",
> -			host->dms->ch->chan_id);
> +		dev_err(host->dev, "Failed to get external DMA channel.\n");
>  		kfree(host->dms);
>  		host->dms = NULL;
>  		return -ENXIO;
> 

