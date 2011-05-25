From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Wed, 25 May 2011 08:46:19 +0200
Message-ID: <20110525064619.GI9774@pengutronix.de>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
 <20110524194054.GC25727@pengutronix.de>
 <20110525060637.GA30583@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47439 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1EYGq0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 02:46:26 -0400
Content-Disposition: inline
In-Reply-To: <20110525060637.GA30583@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Anton Vorontsov <avorontsov@ru.mvista.com>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

Hello Shawn,

> > > +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> > > +#define cpu_is_mx25()	(0)
> > > +#define cpu_is_mx35()	(0)
> > > +#define cpu_is_mx51()	(0)
> > > +#define cpu_is_imx()	(0)
> > > +#else
> > > +#define cpu_is_imx()	(1)
> > > +#endif
> >=20
> > ... e.g. that looks a bit frightening.
> >=20
> Agree.
>=20
> The use of cpu_is_mx..() in the driver itself seems a churn to me
> even without this consolidation patch.  Is it possible for us to
> eliminate them by using pdata, and eventually device tree?  When we
> are there, I might want to revisit the consolidation again.
An alternative that allows letting the logic in the driver and still
getting rid of the cpu_is_ stuff is using platform ids. See
drivers/spi/spi_imx.c for an example. Instead of an index into an array
(as it's for the imx-spi driver) driver_data can hold flags, too, which
should be enough most of the time.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
