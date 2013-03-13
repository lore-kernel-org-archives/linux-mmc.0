From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: move host->data_offset init earlier
Date: Wed, 13 Mar 2013 15:53:10 +0900
Message-ID: <51402256.3030704@samsung.com>
References: <1363085034-9270-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1363085034-9270-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi James,

There is no reason that can't change the verid check position.
So this patch looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 03/12/2013 07:43 PM, James Hogan wrote:
> host->data_offset is initialised at the end of the probe function
> depending on the VERID register, and is used for PIO operations. Move
> this initialisation earlier, before IRQs or slots are initialised, to be
> sure that PIO won't occur prior to host->data_offset being initialised.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> Note, I didn't actually observe this problem occuring, but I think in
> theory it could happen.
> 
>  drivers/mmc/host/dw_mmc.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1a42c7c..7556456 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2289,6 +2289,18 @@ int dw_mci_probe(struct dw_mci *host)
>  	mci_writel(host, CLKENA, 0);
>  	mci_writel(host, CLKSRC, 0);
>  
> +	/*
> +	 * In 2.40a spec, Data offset is changed.
> +	 * Need to check the version-id and set data-offset for DATA register.
> +	 */
> +	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
> +	dev_info(host->dev, "Version ID is %04x\n", host->verid);
> +
> +	if (host->verid < DW_MMC_240A)
> +		host->data_offset = DATA_OFFSET;
> +	else
> +		host->data_offset = DATA_240A_OFFSET;
> +
>  	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
>  	host->card_workqueue = alloc_workqueue("dw-mci-card",
>  			WQ_MEM_RECLAIM | WQ_NON_REENTRANT, 1);
> @@ -2337,18 +2349,6 @@ int dw_mci_probe(struct dw_mci *host)
>  		goto err_workqueue;
>  	}
>  
> -	/*
> -	 * In 2.40a spec, Data offset is changed.
> -	 * Need to check the version-id and set data-offset for DATA register.
> -	 */
> -	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
> -	dev_info(host->dev, "Version ID is %04x\n", host->verid);
> -
> -	if (host->verid < DW_MMC_240A)
> -		host->data_offset = DATA_OFFSET;
> -	else
> -		host->data_offset = DATA_240A_OFFSET;
> -
>  	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>  		dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
>  
> 
