From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 3/4] MXS-MMC: Move of_match_table out of CONFIG_PM
Date: Mon, 21 May 2012 12:09:03 +0800
Message-ID: <20120521040902.GE5810@S2100-06.ap.freescale.net>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <1337562140-5739-3-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:57846 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab2EUDtc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 23:49:32 -0400
Content-Disposition: inline
In-Reply-To: <1337562140-5739-3-git-send-email-marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

Hi Chris,

Do you want me to queue this up for 3.5-rc with arm-soc tree or you can
do that with mmc tree?  In case you can take care of it:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Marek,

In case Chris want to take the patch and would ask you to repost it to
copy linux-mmc, please fix the subject prefix also.

Regards,
Shawn

On Mon, May 21, 2012 at 03:02:19AM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/host/mxs-mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 34a9026..277161d 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -894,8 +894,8 @@ static struct platform_driver mxs_mmc_driver = {
>  		.owner	= THIS_MODULE,
>  #ifdef CONFIG_PM
>  		.pm	= &mxs_mmc_pm_ops,
> -		.of_match_table = mxs_mmc_dt_ids,
>  #endif
> +		.of_match_table = mxs_mmc_dt_ids,
>  	},
>  };
>  
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

