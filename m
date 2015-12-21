From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/17] mmc: core: shut up "voltage-ranges unspecified"
 pr_info()
Date: Mon, 21 Dec 2015 10:24:02 +0000
Message-ID: <20151221102402.GW8644@n2100.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
 <E1aAO8O-0007xP-Do@rmk-PC.arm.linux.org.uk>
 <CAPDyKFqcZf+AsfDKSupVdrxcbwifQiYgyPkypaSYWu4vpqz4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39458 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbLUKYV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 05:24:21 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFqcZf+AsfDKSupVdrxcbwifQiYgyPkypaSYWu4vpqz4dg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Dec 21, 2015 at 11:18:15AM +0100, Ulf Hansson wrote:
> On 19 December 2015 at 21:29, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > Each time a driver such as sdhci-esdhc-imx is probed, we get a info
> > printk complaining that the DT voltage-ranges property has not been
> > specified.
> >
> > However, the DT binding specifically says that the voltage-ranges
> > property is optional.  That means we should not be complaining that
> > DT hasn't specified this property: by indicating that it's optional,
> > it is valid not to have the property in DT.
> 
> Agree!
> 
> >
> > Silence the warning if the property is missing.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/mmc/core/core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 5ae89e48fd85..b5e663b67cb5 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1220,8 +1220,12 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
> >
> >         voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> >         num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> > -       if (!voltage_ranges || !num_ranges) {
> > -               pr_info("%s: voltage-ranges unspecified\n", np->full_name);
> > +       if (!voltage_ranges) {
> > +               pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
> > +               return -EINVAL;
> 
> Because it's optional, I don't think we should return an error code here.

Maybe, but that's changing the behaviour beyond what I said in the
commit message, hence should be a separate patch so that if it causes
problems, then it can be reverted independently of this fix.

> > +       }
> > +       if (!num_ranges) {
> > +               pr_err("%s: voltage-ranges empty\n", np->full_name);
> >                 return -EINVAL;
> 
> Ditto.

For this one, it's entirely reasonable - it's a mal-formed voltage-ranges
property.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
