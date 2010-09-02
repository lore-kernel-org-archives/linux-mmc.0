From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Thu, 02 Sep 2010 19:47:11 +0900
Message-ID: <005301cb4a8c$38844320$a98cc960$%kim@samsung.com>
References: <4C7CDA39.1020907@samsung.com>
 <005101cb4a88$7283d080$578b7180$%kim@samsung.com>
 <AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:25119 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0IBKrG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 06:47:06 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L8400MF78MGSX10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 19:47:04 +0900 (KST)
Received: from kgenekim ([12.23.103.96])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L84009DH8MG4A@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 19:47:04 +0900 (KST)
In-reply-to: <AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kyungmin Park' <kyungmin.park@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Ben Dooks' <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

Kyungmin Park wrote:
>=20
> On Thu, Sep 2, 2010 at 7:20 PM, Kukjin Kim <kgene.kim@samsung.com> wr=
ote:
> > Jaehoon Chung wrote:
> >>
> >> This is sdhci-s3c patch for c210.
> >> c210 didn't use divider of host controller.
> >>
> >> Host Controller need other clock setting methods.
> >>
> >> So I add the callback functions for s5pc210.
> >> also I set 400KHz for initial clock.
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> =A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
   ^^^
Unnecessary whitespace

If your patch includes arch/arm stuff, please add Linux-arm-kernel
maillinglist.
(Cc'ed that)

> >>
> >> ---
> >> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 19 ++++++++
> >> =A0drivers/mmc/host/sdhci-s3c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
68
> >> ++++++++++++++++++++++++++++
> >> =A02 files changed, 87 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h
b/arch/arm/plat-
> >> samsung/include/plat/sdhci.h
> >> index 30844c2..7c75ee3 100644
> >> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> >> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> >> @@ -15,6 +15,8 @@
> >> =A0#ifndef __PLAT_S3C_SDHCI_H
> >> =A0#define __PLAT_S3C_SDHCI_H __FILE__
> >>
> >> +#include <plat/devs.h>
> >> +
> >> =A0struct platform_device;
> >> =A0struct mmc_host;
> >> =A0struct mmc_card;
> >> @@ -288,4 +290,21 @@ static inline void s5pv210_default_sdhci3(voi=
d) {
}
> >>
> >> =A0#endif /* CONFIG_S5PV210_SETUP_SDHCI */
> >>
> >> +/* re-define device name depending on support. */
> >> +static inline void s3c_hsmmc_setname(char *name)
> >> +{
> >> +#ifdef CONFIG_S3C_DEV_HSMMC
> >> + =A0 =A0 s3c_device_hsmmc0.name =3D name;
> >> +#endif
> >> +#ifdef CONFIG_S3C_DEV_HSMMC1
> >> + =A0 =A0 s3c_device_hsmmc1.name =3D name;
> >> +#endif
> >> +#ifdef CONFIG_S3C_DEV_HSMMC2
> >> + =A0 =A0 s3c_device_hsmmc2.name =3D name;
> >> +#endif
> >> +#ifdef CONFIG_S3C_DEV_HSMMC3
> >> + =A0 =A0 s3c_device_hsmmc3.name =3D name;
> >> +#endif
> >> +}
> >> +
> >> =A0#endif /* __PLAT_S3C_SDHCI_H */
> >
> > It would be helpful to me if you could separate platform and driver
patches.
> > And if you want to add s3c_hsmmc_setname(), please send together co=
de
that
> > it is used.
> >
> >> diff --git a/drivers/mmc/host/sdhci-s3c.c
b/drivers/mmc/host/sdhci-s3c.c
> >> index 71ad416..3927793 100644
> >> --- a/drivers/mmc/host/sdhci-s3c.c
> >> +++ b/drivers/mmc/host/sdhci-s3c.c

(snip)

> >
> > How do you think about using quirk to separate S5PV310 case as
following?
> > I think this is more general method in here...And will be submitted=
 soon
> > after fixing something.
> What's the meaning of "general method"?
>=20
I'd like to ask you why there is quirk in sdmmc driver.

> and how/where do you set the host->quirks? when board or platform set
> the these quirks? who know it uses nonstandard quirk?

How about following?

static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
=2E..
+	if (pdev->id_entry->driver_data =3D=3D TYPE_S5PV310)
+		host->quirks |=3D SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER;
=2E..

> In case s5pc210 don't have standard host controller. it's more clear
> to use own functions instead of quirks.
>=20
Why do we add another callback function?

> >
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-=
s3c.c
> > index 71ad416..1ac2f36 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c

(snip)

> > @@ -221,6 +257,11 @@ static unsigned int sdhci_s3c_get_min_clock(st=
ruct
> > sdhci_host *host)
> > =A0 =A0 =A0 =A0unsigned int delta, min =3D UINT_MAX;
> > =A0 =A0 =A0 =A0int src;
> >
> > + =A0 =A0 =A0 /* There is only one clock source(sclk) if there is n=
o clock
divider
> > + =A0 =A0 =A0 =A0* in the host controller */
> > + =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bu=
s[2], 400000);
> what's the clk_bus[2]?
>=20
Should be clk_bus[ourhost->cur_clk]

(snip)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

