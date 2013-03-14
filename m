From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5] mmc: mxcmmc: add mpc512x SDHC support
Date: Thu, 14 Mar 2013 21:05:56 +0100
Message-ID: <20130314200556.GR1906@pengutronix.de>
References: <1363279254-22351-1-git-send-email-agust@denx.de>
 <1363279254-22351-2-git-send-email-agust@denx.de>
 <1589714.JH7YyAvXz1@wuerfel> <20130314191332.44ca64c9@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130314191332.44ca64c9@crub>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 14, 2013 at 07:13:32PM +0100, Anatolij Gustschin wrote:
> On Thu, 14 Mar 2013 17:50:08 +0100
> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> 
> > On Thursday 14 March 2013 17:40:49 Anatolij Gustschin wrote:
> > 
> > > +
> > > +struct mxcmci_reg_ops mxcmci_reg_ops = {
> > > +	.read_l = mpcmci_readl,
> > > +	.write_l = mpcmci_writel,
> > > +	.read_w = mpcmci_readw,
> > > +	.write_w = mpcmci_writew,
> > > +};
> > > +#else
> > > +struct mxcmci_reg_ops mxcmci_reg_ops;
> > > +#endif
> > 
> > Should the struct be static?
> 
> yes, it should.
> 
> > > +static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
> > > +{
> > > +	if (host->reg_ops->read_l)
> > > +		return host->reg_ops->read_l(host, reg);
> > > +	else
> > > +		return readl(host->base + reg);
> > > +}
> > 
> > This seems a bit strange. I would suggest you either use the ops structure
> > all the time and provide an imx variant, or you make it completely
> > compile-time selected.
> 
> I wanted to avoid additional levels of indirection and function calls
> on i.MX. If something like
> 
> static inline u32 mxcmci_readl(struct mxcmci_host *host, int reg)
> {
> #if IS_ENABLED(CONFIG_PPC_MPC512x)
> 	return in_be32(host->base + reg);
> #else
> 	return readl(host->base + reg); 
> #endif

I really wish we would have native endianess accessors...

> 
> is acceptable, I'll use it.

Looks better to me.

> > > @@ -1026,24 +1115,33 @@ static int mxcmci_probe(struct platform_device *pdev)
> > >  	host->res = r;
> > >  	host->irq = irq;
> > >  
> > > -	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > > -	if (IS_ERR(host->clk_ipg)) {
> > > -		ret = PTR_ERR(host->clk_ipg);
> > > -		goto out_iounmap;
> > > -	}
> > > +	if (!is_mpc512x_mmc(host)) {
> > > +		host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > > +		if (IS_ERR(host->clk_ipg)) {
> > > +			ret = PTR_ERR(host->clk_ipg);
> > > +			goto out_iounmap;
> > > +		}
> > 
> > Does mpc512x have no clock management? I think it should still
> > work without modifications if CONFIG_HAVE_CLK is disabled.
> > In that case, devm_clk_get() will return NULL and we don't
> > error out here.
> 
> It does have some clock management (a platform clock driver) and
> the platform selects CONFIG_HAVE_CLK. But we do not have "ipg"
> and "per" clocks on that platform, but "sdhc_clk" instead.

The clocks should be modelled after the input clocks the MMC controller
has, not after the clocks the SoC provides control for. So if you cannot
software control a clock then you should provide a dummy clock for it.

That said, 'ipg' is not a very good name for a mpc SoC,
something like 'bus' would probably be better.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
