From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Move of_match_table out of CONFIG_PM
Date: Wed, 06 Jun 2012 10:17:05 -0400
Message-ID: <87wr3k34pq.fsf@octavius.laptop.org>
References: <1337574807-8637-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52522 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab2FFORP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jun 2012 10:17:15 -0400
In-Reply-To: <1337574807-8637-1-git-send-email-marex@denx.de> (Marek Vasut's
	message of "Mon, 21 May 2012 06:33:27 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org

Hi,

On Mon, May 21 2012, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
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

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
