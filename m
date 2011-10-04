From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mmc: sdhci-tegra: Add #ifdef CONFIG_OF guard for
 of_find_property
Date: Tue, 4 Oct 2011 12:32:32 -0600
Message-ID: <20111004183232.GF2870@ponder.secretlab.ca>
References: <1317614852.30838.1.camel@phoenix>
 <4E897318.3090004@compulab.co.il>
 <74CDBE0F657A3D45AFBB94109FB122FF173A2C6C97@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173A2C6C97@HQMAIL01.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 03, 2011 at 08:59:45AM -0700, Stephen Warren wrote:
> Igor Grinberg wrote at Monday, October 03, 2011 2:32 AM:
> > Hi Axel,
> > 
> > On 10/03/11 06:07, Axel Lin wrote:
> > > I got below build error with "make tegra_defconfig;make"
> > > Add #ifdef CONFIG_OF guard for of_find_property to fix below build error:
> > >
> > >   CC      drivers/mmc/host/sdhci-tegra.o
> > > drivers/mmc/host/sdhci-tegra.c: In function 'sdhci_tegra_dt_parse_pdata':
> > > drivers/mmc/host/sdhci-tegra.c:157: error: implicit declaration of function 'of_find_property'
> ...
> > > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> ...
> > > @@ -154,8 +154,11 @@ static struct tegra_sdhci_platform_data * __devinit sdhci_tegra_dt_parse_pdata(
> > >  	plat->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
> > >  	plat->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
> > >  	plat->power_gpio = of_get_named_gpio(np, "power-gpios", 0);
> > > +
> > > +#ifdef CONFIG_OF
> > >  	if (of_find_property(np, "support-8bit", NULL))
> > >  		plat->is_8bit = 1;
> > > +#endif
> > 
> > Shouldn't we add a stub for the of_find_property() method to include/linux/of.h
> > instead of adding more ifdefs?
> > Or may be use of_get_property() method instead?
> 
> I submitted a patch to add a stub of_find_property a little while back.
> Per https://lkml.org/lkml/2011/9/22/301, Grant applied it already. I'm
> not sure why it hasn't shown up in linux-next, since Grant's repo wasn't
> affected by the kernel.org downtime.
> 
> Sorry for the breakage.

That's because I forgot to push out the tree.  :-(  Sorry.  I've just
fixed it now.

g.
