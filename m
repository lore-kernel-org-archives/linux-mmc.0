From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 3/8] sdhci: sdhci-esdhc-imx: support real clock on and off
 for imx6q
Date: Thu, 5 Sep 2013 22:59:51 +0800
Message-ID: <CAA+hA=Qap2QXzJPq+yEm+uC779xTrpg3M8SHWPk3gXSVheMiUQ@mail.gmail.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
	<1378299257-2980-4-git-send-email-b29396@freescale.com>
	<20130905043227.GB775@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:64569 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab3IEO7w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2013 10:59:52 -0400
Received: by mail-qa0-f43.google.com with SMTP id bv4so2764428qab.16
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 07:59:51 -0700 (PDT)
In-Reply-To: <20130905043227.GB775@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, anton@enomsg.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 5, 2013 at 12:32 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Wed, Sep 04, 2013 at 08:54:12PM +0800, Dong Aisheng wrote:
> > The signal voltage switch follow requires to shutdown and output
>
> s/follow/flow
>
> > clock in a specific sequence according to standard host controller
> > v3.0 spec. In that timing, the card must really receive clock or not.
> >
> > However, for i.MX6Q, the uSDHC will not output clock even the clock
> > is enabled until there is command or data in transfer on the bus,
> > which will then cause singal voltage switch always to fail.
> >
> > For i.MX6Q, we clear ESDHC_VENDOR_SPEC_FRC_SDCLK_ON bit to let
> > controller to gate off clock automatically and set that bit
> > to force clock output if clock is on.
> >
> > This is required by SD3.0 support.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c |    3 ---
> >  drivers/mmc/host/sdhci-esdhc.h     |   29 ++++++++++++++++++++++++++---
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 1dd5ba8..3118a82 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -31,9 +31,6 @@
> >  #include "sdhci-esdhc.h"
> >
> >  #define      ESDHC_CTRL_D3CD                 0x08
> > -/* VENDOR SPEC register */
> > -#define ESDHC_VENDOR_SPEC            0xc0
> > -#define  ESDHC_VENDOR_SPEC_SDIO_QUIRK        (1 << 1)
> >  #define ESDHC_WTMK_LVL                       0x44
> >  #define ESDHC_MIX_CTRL                       0x48
> >  #define  ESDHC_MIX_CTRL_AC23EN               (1 << 7)
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> > index a2a0642..86fcd5b 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -14,6 +14,8 @@
> >  #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
> >  #define _DRIVERS_MMC_SDHCI_ESDHC_H
> >
> > +#include <linux/of.h>
> > +
> >  /*
> >   * Ops and quirks for the Freescale eSDHC controller.
> >   */
> > @@ -33,6 +35,12 @@
> >  #define ESDHC_CLOCK_HCKEN    0x00000002
> >  #define ESDHC_CLOCK_IPGEN    0x00000001
> >
> > +/* VENDOR SPEC register */
> > +#define ESDHC_VENDOR_SPEC            0xc0
> > +#define  ESDHC_VENDOR_SPEC_SDIO_QUIRK        (1 << 1)
> > +#define  ESDHC_VENDOR_SPEC_VSELECT   (1 << 1)
>
> It would be better to introduce the macro only when it's actually being
> used.
>

Correct.

> > +#define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON (1 << 8)
> > +
> >  /* pltfm-specific */
> >  #define ESDHC_HOST_CONTROL_LE        0x20
> >
> > @@ -52,12 +60,20 @@
> >  static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
> >                                  unsigned int host_clock)
> >  {
> > +     struct device *dev;
> >       int pre_div = 2;
> >       int div = 1;
> > -     u32 temp;
> > -
> > -     if (clock == 0)
> > +     u32 temp, val;
> > +
> > +     dev = mmc_dev(host->mmc);
> > +     if (clock == 0) {
> > +             if (of_device_is_compatible(dev->of_node, "fsl,imx6q-usdhc")) {
> > +                     val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> > +                     writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> > +                             host->ioaddr + ESDHC_VENDOR_SPEC);
> > +             }
>
> To me, maintaining this esdhc_set_clock() for both imx and powerpc makes
> no sense now.  I think it might be the time to have different versions
> of the function for imx and powerpc, just in esdhc_pltfm_set_clock() and
> esdhc_of_set_clock() respectively.

I agree with you.
Since later i will need add a few more imx6q specific things in this
common headfile
which seems not good.
So it would be better to end this dependency ASAP.
I could move that code into esdhc_pltfm_set_clock in next version
if no objections from others people.

Regards
Dong Aisheng

>
> Shawn
>
> >               goto out;
> > +     }
> >
> >       temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> >       temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
> > @@ -81,6 +97,13 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock,
> >               | (div << ESDHC_DIVIDER_SHIFT)
> >               | (pre_div << ESDHC_PREDIV_SHIFT));
> >       sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > +
> > +     if (of_device_is_compatible(dev->of_node, "fsl,imx6q-usdhc")) {
> > +             val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> > +             writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> > +                     host->ioaddr + ESDHC_VENDOR_SPEC);
> > +     }
> > +
> >       mdelay(1);
> >  out:
> >       host->clock = clock;
> > --
> > 1.7.1
> >
> >
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
