From: James Hogan <james@albanarts.com>
Subject: Re: mmc: dw_mmc: fixed compile error when disable CONFIG_MMC_DW_IDMAC
Date: Thu, 16 Feb 2012 23:22:11 +0000
Message-ID: <20120216232211.GA1955@balrog>
References: <4F3C67BA.7040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36025 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab2BPXWR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2012 18:22:17 -0500
Received: by eaah12 with SMTP id h12so1101673eaa.19
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2012 15:22:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F3C67BA.7040309@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

On Thu, Feb 16, 2012 at 11:19:38AM +0900, Jaehoon Chung wrote:
> When disable CONFIG_MMC_DW_IDMAC, can see the compiler error.
> Because in dw_mci_post_req(), called the dw_mci_get_dma_dir().
> But that function is in #ifdef CONFIG_MMC_DW_IDMAC.
> 
> I think that function is generic function.
> Not need the CONFIG_MMC_DW_IDMAC.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I've also tested and confirmed that this fixes a compiler error
introduced in 3ec7699d3bb1b0ee7f6e8588974a209d47fc64b2 ("mmc: dw_mmc:
Add support for pre_req and post_req"), however that patch also seems to
have regressed by disabled DMA when not using the internal DMAC. 

Specifically dw_mci_pre_dma_transfer() returns -ENOSYS when not using
internal DMAC, which makes dw_mci_submit_data_dma() now return early:

+       sg_len = dw_mci_pre_dma_transfer(host, data, 0);
+       if (sg_len < 0)
+               return sg_len;

I think that 3ec7699d3bb1b0ee7f6e8588974a209d47fc64b2 should be
removed/reverted until it is fixed.

Regards
James

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
