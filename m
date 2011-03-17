From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] dw_mmc: set fixed burst in BMOD register
Date: Thu, 17 Mar 2011 14:24:07 -0400
Message-ID: <m31v25ppvc.fsf@pullcord.laptop.org>
References: <4D670F0D.8020102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46206 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754907Ab1CQS1B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 14:27:01 -0400
In-Reply-To: <4D670F0D.8020102@samsung.com> (Jaehoon Chung's message of "Fri,
	25 Feb 2011 11:08:13 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi Will,

On Thu, Feb 24 2011, Jaehoon Chung wrote:
> This patch is applied fixed burst.
> If use internal DMA controller, i think that need to set this bit.
>
> I tested when set this bit or not. I found that increase performance with IDMAC
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 58476c1..46e5a89 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -315,7 +315,7 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
>  
>  	/* Stop the IDMAC running */
>  	temp = mci_readl(host, BMOD);
> -	temp &= ~SDMMC_IDMAC_ENABLE;
> +	temp &= ~(SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB);
>  	mci_writel(host, BMOD, temp);
>  }
>  
> @@ -384,7 +384,7 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>  
>  	/* Enable the IDMAC */
>  	temp = mci_readl(host, BMOD);
> -	temp |= SDMMC_IDMAC_ENABLE;
> +	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
>  	mci_writel(host, BMOD, temp);
>  
>  	/* Start it running */

Any thoughts on this patch?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
