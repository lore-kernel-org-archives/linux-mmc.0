From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Wed, 25 May 2011 17:36:02 +0800
Message-ID: <20110525093601.GA2070@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
 <20110524194054.GC25727@pengutronix.de>
 <20110525060637.GA30583@S2100-06.ap.freescale.net>
 <20110525064619.GI9774@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:21912
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350Ab1EYJci convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 May 2011 05:32:38 -0400
Content-Disposition: inline
In-Reply-To: <20110525064619.GI9774@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

Hi Uwe,

On Wed, May 25, 2011 at 08:46:19AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Shawn,
>=20
> > > > +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> > > > +#define cpu_is_mx25()	(0)
> > > > +#define cpu_is_mx35()	(0)
> > > > +#define cpu_is_mx51()	(0)
> > > > +#define cpu_is_imx()	(0)
> > > > +#else
> > > > +#define cpu_is_imx()	(1)
> > > > +#endif
> > >=20
> > > ... e.g. that looks a bit frightening.
> > >=20
> > Agree.
> >=20
> > The use of cpu_is_mx..() in the driver itself seems a churn to me
> > even without this consolidation patch.  Is it possible for us to
> > eliminate them by using pdata, and eventually device tree?  When we
> > are there, I might want to revisit the consolidation again.
> An alternative that allows letting the logic in the driver and still
> getting rid of the cpu_is_ stuff is using platform ids. See
> drivers/spi/spi_imx.c for an example. Instead of an index into an arr=
ay
> (as it's for the imx-spi driver) driver_data can hold flags, too, whi=
ch
> should be enough most of the time.
>=20
Yeah, this is definitely a solution I can try later.  But for now, I
would drop the esdhc consolidation patch.

--=20
Regards,
Shawn

