From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: host: omap_hsmmc: add a verbose print to enable
 CONFIG_REGULATOR_PBIAS
Date: Thu, 14 Jan 2016 17:25:49 +0000
Message-ID: <20160114172549.GC5783@n2100.arm.linux.org.uk>
References: <1452762920-2588-1-git-send-email-kishon@ti.com>
 <20160114120706.GA12774@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:37934 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbcANR0P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2016 12:26:15 -0500
Content-Disposition: inline
In-Reply-To: <20160114120706.GA12774@earth>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, ivo.g.dimitrov.75@gmail.com, aaro.koskinen@iki.fi, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, pavel@ucw.cz, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel@lists.infradead.org

On Thu, Jan 14, 2016 at 01:07:06PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 14, 2016 at 02:45:20PM +0530, Kishon Vijay Abraham I wrote:
> > Since v4.3+, CONFIG_REGULATOR_PBIAS should be enabled (for platforms that
> > have PBIAS regulator) in order for MMC1 to work.
> > 
> > Add a more verbose print to help enable CONFIG_REGULATOR_PBIAS for users
> > using a olddefconfig or a custom .config.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/mmc/host/omap_hsmmc.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index 7fb0753..7086bd6 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -503,8 +503,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> >  	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
> >  	if (IS_ERR(host->pbias)) {
> >  		ret = PTR_ERR(host->pbias);
> > -		if ((ret != -ENODEV) && host->dev->of_node)
> > +		if ((ret != -ENODEV) && host->dev->of_node) {
> > +			dev_err(host->dev,
> > +			"SD card detect fail? enable CONFIG_REGULATOR_PBIAS\n");
> >  			return ret;
> > +		}
> >  		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
> >  			PTR_ERR(host->pbias));
> >  		host->pbias = NULL;
> 
> 
> Is there a good reason against adding "depends on REGULATOR_PBIAS"
> to MMC_OMAP_HS?

There are very good reasons not to do this: that will result in
configurations where MMC_OMAP_HS was set but without REGULATOR_PBIAS
ending up with MMC_OMAP_HS being disabled.  That doesn't help the
root problem, which is "why has the kernel boot regressed for my
previous working configuration?"

The solution proposed here adds a message to the boot which points
out fair and square what needs to be done to rectify the boot
failure.  Adding a dependency just brings up the question "where
has my MMC driver gone?"

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
