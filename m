From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] mmc: mxcmmc: add mpc512x SDHC support
Date: Thu, 14 Mar 2013 17:50:08 +0100
Message-ID: <1589714.JH7YyAvXz1@wuerfel>
References: <1363279254-22351-1-git-send-email-agust@denx.de> <1363279254-22351-2-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63943 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab3CNQuP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 12:50:15 -0400
In-Reply-To: <1363279254-22351-2-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Thursday 14 March 2013 17:40:49 Anatolij Gustschin wrote:

> +
> +struct mxcmci_reg_ops mxcmci_reg_ops = {
> +	.read_l = mpcmci_readl,
> +	.write_l = mpcmci_writel,
> +	.read_w = mpcmci_readw,
> +	.write_w = mpcmci_writew,
> +};
> +#else
> +struct mxcmci_reg_ops mxcmci_reg_ops;
> +#endif

Should the struct be static?

> +static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
> +{
> +	if (host->reg_ops->read_l)
> +		return host->reg_ops->read_l(host, reg);
> +	else
> +		return readl(host->base + reg);
> +}

This seems a bit strange. I would suggest you either use the ops structure
all the time and provide an imx variant, or you make it completely
compile-time selected.

> @@ -1026,24 +1115,33 @@ static int mxcmci_probe(struct platform_device *pdev)
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

Does mpc512x have no clock management? I think it should still
work without modifications if CONFIG_HAVE_CLK is disabled.
In that case, devm_clk_get() will return NULL and we don't
error out here.

	Arnd
