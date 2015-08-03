From: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 5/6] mmc: sdhci-esdhc-imx: config watermark level
 and burst length
Date: Mon, 3 Aug 2015 18:14:26 +0800
Message-ID: <20150803101423.GA24870@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-6-git-send-email-haibo.chen@freescale.com>
 <20150731145140.GE27806@shlinux1.ap.freescale.net>
 <20150731151345.GX7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150731151345.GX7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, johan.derycke-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 31, 2015 at 04:13:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 31, 2015 at 10:51:41PM +0800, Dong Aisheng wrote:
> > On Wed, Jul 29, 2015 at 05:03:56PM +0800, Haibo Chen wrote:
> > > i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,200MHZ
> > > DDR mode. So the I/O speed improve a lot compare to SD3.0
> > > 
> > > The default burst length is 8, if we don't change this value, in
> > > HS400 mode, when we do eMMC read operation, we can find that the
> > > clock signal will stop for a period of time. This means the speed
> > > of data moving on AHB bus is slower than I/O speed. So we should
> > > improve the speed of data moving on AHB bus.
> > > 
> > > For imx7d usdhc, this patch set the burst length as 16, and set
> > > watermark level as 64. The test result is the clock signal has
> > > no stop during the eMMC HS400 operation. For other imx usdhc, remain
> > > the default value: burst length as 8, watermark level as 16.
> > > 
> > > Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index 158f93b..37d0095 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -239,6 +239,11 @@ static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
> > >  	return data->socdata == &usdhc_imx6q_data;
> > >  }
> > >  
> > > +static inline int is_imx7d_usdhc(struct pltfm_imx_data *data)
> > > +{
> > > +	return data->socdata == &usdhc_imx7d_data;
> > > +}
> > 
> > Can we using flag to check instead of adding more is_imx_usdhc()?
> 
> No, not more flags.  Do the job properly and parameterise the differences.
> 

Hi Russell,

Thanks for the review.

I mean using the exist flag to do like:
if (imx_data->socdata->flags & ESDHC_FLAG_SUP_HS400)
        writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
else    
        writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
Not adding another new flag.

ESDHC_FLAG_SUP_HS400 represents the new feature support of HS400 which is
already added in patch
[PATCH v3 1/6] mmc: sdhci-esdhc-imx: add imx7d support and support HS400

> > >  static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
> > >  {
> > >  	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
> > > @@ -1145,7 +1150,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> > >  	 * to something insane.  Change it back here.
> > >  	 */
> > >  	if (esdhc_is_usdhc(imx_data)) {
> > > -		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
> > > +		if (is_imx7d_usdhc(imx_data))
> > > +			writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> > > +		else
> > > +			writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
> 
> So the value to be written to this register should come from the
> driver data, which is already used as a struct esdhc_soc_data to
> extrapolate out the differences.
> 
> Going down the flag path will lead you to an even more of a stinking
> shitpile than sdhci already is - if another version of the SoC requires
> a different value there, what are you going to do?  Add yet another
> flag for the next value?  What are you going to do when you have 16
> different values?  Use 16 different flags?  Clearly that path is insane.
> 

I understand your concern for the potential bad situation.

Here the watermark level setting of mx7d is dependant on the new feature
of HS400, so it seems make senese to use that flag to set value and does
not need adding new flag.

Actually that is the current approach for uSDHC driver to distinguish
the difference between register offset/settings by checking feature flags.
e.g. ESDHC_FLAG_USDHC, ESDHC_FLAG_STD_TUNING, ESDHC_FLAG_HS200 and etc.
This approach can save us a lot more flags for SoC checking for common
feature part. And up till now, things seem good.

If really new SoC comes while it requires a different value, if it's feature
dependant, we may still use feature flag for it.
If not, probably a quirk may be needed if it's IP limitation.

If it's normal situation and such situation happened too many in the future,
we may choose to parameterise all these normal feature independent settings
into esdhc_soc_data to avoid adding meaningless flags.
e.g.
static struct esdhc_soc_data usdhc_imx6sx_data = {
        .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
                        | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
        .wml = 32,
};

static struct esdhc_soc_data usdhc_imx7d_data = {
        .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
                        | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
        .wml = 64,
};

But currently i still did not see such urgent requirement to do it for only
water mark level settings.

Regards
Dong Aisheng

> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
