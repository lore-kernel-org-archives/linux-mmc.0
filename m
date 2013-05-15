From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 1/1] mmc: mxcmmc: setup mpc512x related clocks
Date: Wed, 15 May 2013 10:04:44 +0200
Message-ID: <20130515080444.GH32299@pengutronix.de>
References: <1368543609-11372-1-git-send-email-gsi@denx.de>
 <1368543609-11372-2-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46620 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108Ab3EOIEr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 04:04:47 -0400
Content-Disposition: inline
In-Reply-To: <1368543609-11372-2-git-send-email-gsi@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Anatolij Gustschin <agust@denx.de>

On Tue, May 14, 2013 at 05:00:09PM +0200, Gerhard Sittig wrote:
> the mxcmmc(4) driver is shared across the i.MX and MPC512x platforms,
> setup the 'sdhc_clk' instead of 'ipg' and 'per' in the mpc512x case
> 
> this change re-uses the i.MX 'per' clock related variable for everything
> SDHC/MMC related, and makes the 'ipg' clock related variable access
> conditional -- this approach is less intrusive than adding an #ifdef and
> two sets of variables everywhere
> 
> viewing the change with 'git diff -w' better reflects its nature
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/mmc/host/mxcmmc.c |   41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index d503635..b9d21cc 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1121,20 +1121,29 @@ static int mxcmci_probe(struct platform_device *pdev)
>  	host->res = r;
>  	host->irq = irq;
>  
> -	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(host->clk_ipg)) {
> -		ret = PTR_ERR(host->clk_ipg);
> -		goto out_iounmap;
> -	}
> +	if (!is_mpc512x_mmc(host)) {
> +		host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +		if (IS_ERR(host->clk_ipg)) {
> +			ret = PTR_ERR(host->clk_ipg);
> +			goto out_iounmap;
> +		}
>  
> -	host->clk_per = devm_clk_get(&pdev->dev, "per");
> -	if (IS_ERR(host->clk_per)) {
> -		ret = PTR_ERR(host->clk_per);
> -		goto out_iounmap;
> +		host->clk_per = devm_clk_get(&pdev->dev, "per");
> +		if (IS_ERR(host->clk_per)) {
> +			ret = PTR_ERR(host->clk_per);
> +			goto out_iounmap;
> +		}
> +	} else {
> +		host->clk_per = devm_clk_get(&pdev->dev, "sdhc_clk");
> +		if (IS_ERR(host->clk_per)) {
> +			ret = PTR_ERR(host->clk_per);
> +			goto out_iounmap;
> +		}
>  	}

No! The clocks we need are SDHC core specific, not powerPC/ARM
specific.

The clocks are modelled after the input clocks of the device, *not*
after what the SoC offers control over.

See "Figure 34-22. Clock Used in SDHC" in the MPC5121 Programming guide.
This shows that the SDHC core has a SDHC_CLK, IPG_CLK and IPG_CLK_S.
These are the 3 clocks the SDHC core needs and the driver has to request
them. If you do not have software control over all clocks, you still
have to provide dummy clocks.

That said, this is currently hard to implement as the clock support for
the MPC5121 is utterly broken. The MPC5121 clk_get implementation
currently ignores the device argument and relies only on the "sdhc_clk"
string.

Fix your platform code, then you don't have to mess with the driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
