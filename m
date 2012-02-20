From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix disableing DMA in Non-IDMAC
Date: Mon, 20 Feb 2012 12:10:54 +0000
Message-ID: <4F42384E.8020006@imgtec.com>
References: <001e01ccef73$97aee200$c70ca600$%jun@samsung.com> <CAAG0J9-wRLj29=LztT4Ppi7q6Q=4dm29vHODk9KdVAGWKMJgUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:47238 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2BTM0W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Feb 2012 07:26:22 -0500
In-Reply-To: <CAAG0J9-wRLj29=LztT4Ppi7q6Q=4dm29vHODk9KdVAGWKMJgUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, James Hogan <james@albanarts.com>, Will Newton <will.newton@imgtec.com>

Hi,

On 20/02/12 12:03, Seungwon Jeon wrote:
> dw_mci_pre_dma_transfer() is valid only if internal DMA. In case of
> using other DMA it returns -ENOSYS. It prevents the DMA operations.
> This patch makes dw_mci_pre_dma_transfer() effective in all DMA case.
> 
> Reported-by: James Hogan <james@albanarts.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

I've tested, and this seems to work for me (no IDMAC) as long as your
other patch is applied first of course ("fixed compile error when
disable CONFIG_MMC_DW_IDMAC").

Probably worth fixing the typo in the subject too (s/disableing/disabling/).

Otherwise, Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
>  drivers/mmc/host/dw_mmc.c |   25 +++++++++----------------
>  1 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 692c3ba..bf3c9b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -429,6 +429,15 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>  	return 0;
>  }
> 
> +static struct dw_mci_dma_ops dw_mci_idmac_ops = {
> +	.init = dw_mci_idmac_init,
> +	.start = dw_mci_idmac_start_dma,
> +	.stop = dw_mci_idmac_stop_dma,
> +	.complete = dw_mci_idmac_complete_dma,
> +	.cleanup = dw_mci_dma_cleanup,
> +};
> +#endif /* CONFIG_MMC_DW_IDMAC */
> +
>  static int dw_mci_pre_dma_transfer(struct dw_mci *host,
>  				   struct mmc_data *data,
>  				   bool next)
> @@ -468,22 +477,6 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
>  	return sg_len;
>  }
> 
> -static struct dw_mci_dma_ops dw_mci_idmac_ops = {
> -	.init = dw_mci_idmac_init,
> -	.start = dw_mci_idmac_start_dma,
> -	.stop = dw_mci_idmac_stop_dma,
> -	.complete = dw_mci_idmac_complete_dma,
> -	.cleanup = dw_mci_dma_cleanup,
> -};
> -#else
> -static int dw_mci_pre_dma_transfer(struct dw_mci *host,
> -				   struct mmc_data *data,
> -				   bool next)
> -{
> -	return -ENOSYS;
> -}
> -#endif /* CONFIG_MMC_DW_IDMAC */
> -
>  static void dw_mci_pre_req(struct mmc_host *mmc,
>  			   struct mmc_request *mrq,
>  			   bool is_first_req)

