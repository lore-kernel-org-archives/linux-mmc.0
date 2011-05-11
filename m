From: Huang Changming-R66093 <R66093@freescale.com>
Subject: RE: [PATCH] mmc: fixed wrong SD card detection
Date: Wed, 11 May 2011 10:30:21 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1154BAB5@039-SN1MPN1-005.039d.mgd.msft.net>
References: <4DC3C1A8.1050104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:17747 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab1EKPqe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 11:46:34 -0400
In-Reply-To: <4DC3C1A8.1050104@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

I don't see this.
Maybe that is your hardware issue.

Thanks and Best Regards
Jerry Huang


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
> Sent: Friday, May 06, 2011 5:39 PM
> To: linux-mmc@vger.kernel.org
> Cc: Chris Ball; Kyungmin Park
> Subject: [PATCH] mmc: fixed wrong SD card detection
> 
> This patch added mmc_power_off after mmc_attach_sd()
> 
> i found that didn't detect the second card insert.(using SDHCI) you can
> see the below log.
> 
> i want to know that somebody know this issue...
> 
> ->first card inserted (correct card detect)
> # mmc1: new SDHC card at address e624
> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>  mmcblk1: p1
> #
> # mmc1: card e624 removed
> -> second card inserted
> mmc1: error -110 whilst initialising SD card
> mmc1: Card removed during transfer!
> mmc1: Resetting controller.
> -> third card inserted
> mmc1: new SDHC card at address e624
> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>  mmcblk1: p1
> 
> I added mmc_power_off() after only mmc_attach_sd().
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 1dbc185..d5d8ac0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1522,8 +1522,10 @@ static int mmc_rescan_try_freq(struct mmc_host
> *host, unsigned freq)
>  	/* Order's important: probe SDIO, then SD, then MMC */
>  	if (!mmc_attach_sdio(host))
>  		return 0;
> -	if (!mmc_attach_sd(host))
> +	if (!mmc_attach_sd(host)) {
> +		mmc_power_off(host);
>  		return 0;
> +	}
>  	if (!mmc_attach_mmc(host))
>  		return 0;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


