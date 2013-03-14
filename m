From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/5] mmc: mxcmmc: add mpc512x SDHC support
Date: Thu, 14 Mar 2013 19:13:32 +0100
Message-ID: <20130314191332.44ca64c9@crub>
References: <1363279254-22351-1-git-send-email-agust@denx.de>
	<1363279254-22351-2-git-send-email-agust@denx.de>
	<1589714.JH7YyAvXz1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34383 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933275Ab3CNSNd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 14:13:33 -0400
In-Reply-To: <1589714.JH7YyAvXz1@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Thu, 14 Mar 2013 17:50:08 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 14 March 2013 17:40:49 Anatolij Gustschin wrote:
> 
> > +
> > +struct mxcmci_reg_ops mxcmci_reg_ops = {
> > +	.read_l = mpcmci_readl,
> > +	.write_l = mpcmci_writel,
> > +	.read_w = mpcmci_readw,
> > +	.write_w = mpcmci_writew,
> > +};
> > +#else
> > +struct mxcmci_reg_ops mxcmci_reg_ops;
> > +#endif
> 
> Should the struct be static?

yes, it should.

> > +static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
> > +{
> > +	if (host->reg_ops->read_l)
> > +		return host->reg_ops->read_l(host, reg);
> > +	else
> > +		return readl(host->base + reg);
> > +}
> 
> This seems a bit strange. I would suggest you either use the ops structure
> all the time and provide an imx variant, or you make it completely
> compile-time selected.

I wanted to avoid additional levels of indirection and function calls
on i.MX. If something like

static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
{
#if IS_ENABLED(CONFIG_PPC_MPC512x)
	return in_be32(host->base + reg);
#else
	return readl(host->base + reg); 
#endif
}

is acceptable, I'll use it.

> > @@ -1026,24 +1115,33 @@ static int mxcmci_probe(struct platform_device *pdev)
> >  	host->res = r;
> >  	host->irq = irq;
> >  
> > -	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > -	if (IS_ERR(host->clk_ipg)) {
> > -		ret = PTR_ERR(host->clk_ipg);
> > -		goto out_iounmap;
> > -	}
> > +	if (!is_mpc512x_mmc(host)) {
> > +		host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > +		if (IS_ERR(host->clk_ipg)) {
> > +			ret = PTR_ERR(host->clk_ipg);
> > +			goto out_iounmap;
> > +		}
> 
> Does mpc512x have no clock management? I think it should still
> work without modifications if CONFIG_HAVE_CLK is disabled.
> In that case, devm_clk_get() will return NULL and we don't
> error out here.

It does have some clock management (a platform clock driver) and
the platform selects CONFIG_HAVE_CLK. But we do not have "ipg"
and "per" clocks on that platform, but "sdhc_clk" instead.

Thanks,

Anatolij
