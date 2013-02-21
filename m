From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: tegra: use mmc_of_parse to get the support of
 standard MMC DT bindings
Date: Thu, 21 Feb 2013 16:15:11 +0800
Message-ID: <1361434511.5678.102.camel@jlo-ubuntu-64.nvidia.com>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com>
	 <1361343902-15223-3-git-send-email-josephl@nvidia.com>
	 <512502D7.4090605@wwwdotorg.org>
	 <1361413425.5678.8.camel@jlo-ubuntu-64.nvidia.com>
	 <5125A075.5000000@wwwdotorg.org>
	 <1361427997.5678.59.camel@jlo-ubuntu-64.nvidia.com>
	 <20130221080306.GA7718@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130221080306.GA7718-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2013-02-21 at 16:03 +0800, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Feb 21, 2013 at 02:26:37PM +0800, Joseph Lo wrote:
> > On Thu, 2013-02-21 at 12:20 +0800, Stephen Warren wrote:
> > > On 02/20/2013 07:23 PM, Joseph Lo wrote:
> > > > On Thu, 2013-02-21 at 01:07 +0800, Stephen Warren wrote:
> > > >> On 02/20/2013 12:05 AM, Joseph Lo wrote:
> > > >>> Updating the sdhci-tegra driver to use mmc_of_parse to support standard
> > > >>> MMC DT bindings. Then we can remove the redundant code that already support
> > > 
> > > >>> @@ -220,15 +203,12 @@ static void sdhci_tegra_parse_dt(struct device *dev,
> > > >>>  					struct sdhci_tegra *tegra_host)
> > > >>>  {
> > > >> ...
> > > >>> +	struct sdhci_host *host;
> > > >> ...
> > > >>> +	host = platform_get_drvdata(to_platform_device(dev));
> > > >>> +	mmc_of_parse(host->mmc);
> > > >>>  }
> > > >>
> > > >> It might be simpler to change the function prototype to simply pass in
> > > >> the host object too.
> > > > 
> > > > It's a interface problem that I can't fix now. If sdhci core is going to
> > > > integrate mmc_of_parse into sdhci_get_of_property and mmc_gpio_get_ro
> > > > into somethere sdhci_do_get_ro, then we can refine later.
> > > 
> > > I meant to change the prototype of sdhci_tegra_parse_dt(). It would be
> > > simple to change that function in this patch.
> > 
> > Hmm. It might not too much different. Which version you prefer?
> > 
> > 1. Original version
> > 
> > 2.
> >  static void sdhci_tegra_parse_dt(struct device *dev,
> > -                                       struct sdhci_tegra *tegra_host)
> > +                                       struct sdhci_host *host)
> >  {
> >         struct device_node *np = dev->of_node;
> > -       struct sdhci_host *host;
> > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +       struct sdhci_tegra *tegra_host = pltfm_host->priv;
> >  
> >         tegra_host->power_gpio = of_get_named_gpio(np, "power-gpios",0);
> > -
> > -       host = platform_get_drvdata(to_platform_device(dev));
> >         mmc_of_parse(host->mmc);
> >  }
> >  
> > @@ -240,7 +239,7 @@ static int sdhci_tegra_probe(struct platform_device
> > *pdev)
> >         tegra_host->soc_data = soc_data;
> >         pltfm_host->priv = tegra_host;
> >  
> > -       sdhci_tegra_parse_dt(&pdev->dev, tegra_host);
> > +       sdhci_tegra_parse_dt(&pdev->dev, host);
> >  
> 
> I personally prefer this second version. It keeps with the tradition to
> pass a struct device into the *_parse_dt() and also provides easy access
> to the sdhci_host.
> 
> And on a side-note:
> 
> 	host = platform_get_drvdata(to_platform_device(dev));
> 
> can be more simply written as:
> 
> 	host = dev_get_drvdata(dev);
> 
Indeed, it's simpler and works. Thanks for sharing. :)
