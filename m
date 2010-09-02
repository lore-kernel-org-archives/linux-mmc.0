From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Thu, 02 Sep 2010 20:00:48 +0900
Message-ID: <005401cb4a8e$1c65dbc0$55319340$%kim@samsung.com>
References: <4C7CDA39.1020907@samsung.com>
 <005101cb4a88$7283d080$578b7180$%kim@samsung.com>
 <AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:25129 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab0IBLAh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 07:00:37 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L84006PA9904C20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 20:00:36 +0900 (KST)
Received: from kgenekim ([12.23.103.96])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L84005F298ZWL@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 20:00:36 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, 'Marek Szyprowski' <m.szyprowski@samsung.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Ben Dooks' <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

Kukjin Kim wrote:
>=20
> Kyungmin Park wrote:
> >
> > On Thu, Sep 2, 2010 at 7:20 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > > Jaehoon Chung wrote:
> > >>
> > >> This is sdhci-s3c patch for c210.
> > >> c210 didn't use divider of host controller.
> > >>
> > >> Host Controller need other clock setting methods.
> > >>
> > >> So I add the callback functions for s5pc210.
> > >> also I set 400KHz for initial clock.
> > >>
> > >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > >> =A0Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>    ^^^
> Unnecessary whitespace
>=20
> If your patch includes arch/arm stuff, please add Linux-arm-kernel
maillinglist.
> (Cc'ed that)
>=20
> > >>
> > >> ---
> > >> =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 19 ++++++++
> > >> =A0drivers/mmc/host/sdhci-s3c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 68
> > >> ++++++++++++++++++++++++++++
> > >> =A02 files changed, 87 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h
b/arch/arm/plat-
> > >> samsung/include/plat/sdhci.h
> > >> index 30844c2..7c75ee3 100644
> > >> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> > >> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h

(snip)

> > >> diff --git a/drivers/mmc/host/sdhci-s3c.c
b/drivers/mmc/host/sdhci-s3c.c
> > >> index 71ad416..3927793 100644
> > >> --- a/drivers/mmc/host/sdhci-s3c.c
> > >> +++ b/drivers/mmc/host/sdhci-s3c.c
>=20
> (snip)
>=20
> > >
> > > How do you think about using quirk to separate S5PV310 case as
following?
> > > I think this is more general method in here...And will be submitt=
ed
soon
> > > after fixing something.

mm...I will think about your comments again. Then let's discuss about t=
his
issue.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> > What's the meaning of "general method"?
> >
> I'd like to ask you why there is quirk in sdmmc driver.
>=20
> > and how/where do you set the host->quirks? when board or platform s=
et
> > the these quirks? who know it uses nonstandard quirk?
>=20
> How about following?
>=20
> static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> ...
> +	if (pdev->id_entry->driver_data =3D=3D TYPE_S5PV310)
> +		host->quirks |=3D SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER;
> ...
>=20
> > In case s5pc210 don't have standard host controller. it's more clea=
r
> > to use own functions instead of quirks.
> >
> Why do we add another callback function?
>=20
> > >
> > > From: Hyuk Lee <hyuk1.lee@samsung.com>
> > >
> > > diff --git a/drivers/mmc/host/sdhci-s3c.c
b/drivers/mmc/host/sdhci-s3c.c
> > > index 71ad416..1ac2f36 100644
> > > --- a/drivers/mmc/host/sdhci-s3c.c
> > > +++ b/drivers/mmc/host/sdhci-s3c.c
>=20
> (snip)
>=20
> > > @@ -221,6 +257,11 @@ static unsigned int
sdhci_s3c_get_min_clock(struct
> > > sdhci_host *host)
> > > =A0 =A0 =A0 =A0unsigned int delta, min =3D UINT_MAX;
> > > =A0 =A0 =A0 =A0int src;
> > >
> > > + =A0 =A0 =A0 /* There is only one clock source(sclk) if there is=
 no clock
divider
> > > + =A0 =A0 =A0 =A0* in the host controller */
> > > + =A0 =A0 =A0 if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_=
bus[2], 400000);
> > what's the clk_bus[2]?
> >
> Should be clk_bus[ourhost->cur_clk]
>=20
> (snip)
>=20

