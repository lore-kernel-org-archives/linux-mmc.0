From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
Date: Tue, 30 Aug 2011 09:17:31 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279D49@HQMAIL01.nvidia.com>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
 <201108300952.02418.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201108300952.02418.marvin24-Mmb7MZpHnFY@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Dietich <marvin24-Mmb7MZpHnFY@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Marc Dietich wrote at Tuesday, August 30, 2011 1:52 AM:
...
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
...
> > @@ -95,12 +94,10 @@ static irqreturn_t carddetect_irq(int irq, void *data)
> >
> >  static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
> >  {
> > -	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> > -	struct tegra_sdhci_platform_data *plat;
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
> >  	u32 ctrl;
> >
> > -	plat = pdev->dev.platform_data;
> > -
> >  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> >  	if (plat->is_8bit && bus_width == MMC_BUS_WIDTH_8) {
> >  		ctrl &= ~SDHCI_CTRL_4BITBUS;
> 
> what about 8 bit support?

I didn't understand the question at first; I assume you're asking about
8-bit support in the device-tree binding/parsing.

Yes, that's a missing feature, and I should add it. Thanks for pointing
that out.

(I'll also fix the binding docs issue that Shawn pointed out while I'm
at it).

-- 
nvpublic
