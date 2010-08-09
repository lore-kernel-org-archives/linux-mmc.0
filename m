From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Mon, 9 Aug 2010 11:10:42 +0100
Message-ID: <20100809101042.GA8293@console-pimps.org>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
 <AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
 <AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:46997 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755836Ab0HIKKp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 06:10:45 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

On Thu, Aug 05, 2010 at 03:09:14PM +0800, zhangfei gao wrote:
> >>
> >> =A0 =A0 =A0 =A01. support 8 bit data transfer width
> > 8 bit buswidth patch is already merged to mm tree.
> >
> > http://marc.info/?l=3Dlinux-mmc&m=3D127783663526810&w=3D3
> >
> > Thank you,
> > Kyungmin Park
> >
>=20
> Thanks Kyungmin, updated without 8 bit support.
>=20
> From 2b717444443acdac90c5f31522a1515a2000749a Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 6 Aug 2010 07:10:01 +0800
> Subject: [PATCH] sdhc: support 10-bit divided clock Mode
>=20
>=20
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 +++--
>  drivers/mmc/host/sdhci.h |    4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..212dc9e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1002,7 +1002,8 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	}
>  	div >>=3D 1;
>=20
> -	clk =3D div << SDHCI_DIVIDER_SHIFT;
> +	clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> +	clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SHIFT) <<
> SDHCI_DIVIDER_SHIFT_HI;
>  	clk |=3D SDHCI_CLOCK_INT_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>=20

This patch is missing a change to the way we calculate 'div'. While you=
r
patch is correct, I think it would be better to fit some more things
into it.

This is the current code for calculating the clock divider,


	for (div =3D 1;div < 256;div *=3D 2) {
		if ((host->max_clk / div) <=3D clock)
			break;
	}
	div >>=3D 1;

	clk =3D div << SDHCI_DIVIDER_SHIFT;


even with your patch applied 'div' will never be greater 256 and we
won't be executing your changes. So I think this patch also needs to
bump the upper limit of 'div' to 2046.

We should probably introduce some safety at this point and check that
the divider value is legal for the version of the host controller, to
stop people shooting themselves in the foot if they mess up their clock
settings. I was thinking of something like,

	if (host->version >=3D SDHCI_SPEC_300)
		max_div =3D 2046;
	else
		max_div =3D 256;

	for (div =3D 1;div < max_div;div *=3D 2) {
		if ((host->max_clk / div) <=3D clock)
			break;
	}

What do you think?
