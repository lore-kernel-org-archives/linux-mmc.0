From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: get capabilities from DT
Date: Sun, 25 Aug 2013 00:23:49 -0400
Message-ID: <87li3qpfe2.fsf@octavius.laptop.org>
References: <1376512813-27892-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50823 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088Ab3HYEXy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Aug 2013 00:23:54 -0400
In-Reply-To: <1376512813-27892-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Wed, 14 Aug 2013 22:40:13 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balajitk@ti.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Aug 14 2013, Daniel Mack wrote:
> When used in DT mode, the omap hsmmc driver has to take capabilites
> given in DT by calling mmc_of_parse().
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 1865321..31337c1 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1907,7 +1907,15 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  	if (mmc_slot(host).nonremovable)
>  		mmc->caps |= MMC_CAP_NONREMOVABLE;
>  
> -	mmc->pm_caps = mmc_slot(host).pm_caps;
> +	if (pdev->dev.of_node) {
> +		ret = mmc_of_parse(mmc);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "mmc_of_parse() failed: %d\n", ret);
> +			goto err_irq;
> +		}
> +	} else {
> +		mmc->pm_caps = mmc_slot(host).pm_caps;
> +	}
>  
>  	omap_hsmmc_conf_bus_power(host);

Balaji, please can you review this patch?  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
