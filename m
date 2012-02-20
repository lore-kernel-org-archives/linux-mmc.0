From: James Hogan <james.hogan@imgtec.com>
Subject: Re: mmc: dw_mmc: fixed compile error when disable CONFIG_MMC_DW_IDMAC
Date: Mon, 20 Feb 2012 12:10:08 +0000
Message-ID: <4F423820.10000@imgtec.com>
References: <4F3C67BA.7040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:15775 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2BTMZZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Feb 2012 07:25:25 -0500
In-Reply-To: <4F3C67BA.7040309@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

On 16/02/12 02:19, Jaehoon Chung wrote:
> When disable CONFIG_MMC_DW_IDMAC, can see the compiler error.
> Because in dw_mci_post_req(), called the dw_mci_get_dma_dir().
> But that function is in #ifdef CONFIG_MMC_DW_IDMAC.
> 
> I think that function is generic function.
> Not need the CONFIG_MMC_DW_IDMAC.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f9457e5..692c3ba 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -295,7 +295,6 @@ static void dw_mci_stop_dma(struct dw_mci *host)
>  	}
>  }
>  
> -#ifdef CONFIG_MMC_DW_IDMAC
>  static int dw_mci_get_dma_dir(struct mmc_data *data)
>  {
>  	if (data->flags & MMC_DATA_WRITE)
> @@ -304,6 +303,7 @@ static int dw_mci_get_dma_dir(struct mmc_data *data)
>  		return DMA_FROM_DEVICE;
>  }
>  
> +#ifdef CONFIG_MMC_DW_IDMAC
>  static void dw_mci_dma_cleanup(struct dw_mci *host)
>  {
>  	struct mmc_data *data = host->data;

