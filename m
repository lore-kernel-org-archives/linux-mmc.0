From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
 platforms
Date: Fri, 21 Jan 2011 20:32:10 +0100
Message-ID: <20110121193210.GU14956@pengutronix.de>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
 <20110121153351.GR14956@pengutronix.de>
 <4D39B042.5050004@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59580 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab1AUTcS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 14:32:18 -0500
Content-Disposition: inline
In-Reply-To: <4D39B042.5050004@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

Hello Fabio,

On Fri, Jan 21, 2011 at 02:11:46PM -0200, Fabio Estevam wrote:
> On 1/21/2011 1:33 PM, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> >> Currently MMC_MXC driver can be selected by all i.MX devices.
> >>
> >> Restrict its use only for the appropriate processors.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >>  drivers/mmc/host/Kconfig |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index d618e86..a3a9ec1 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -288,7 +288,7 @@ config MMC_MSM
> >> =20
> >>  config MMC_MXC
> >>  	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
> >> -	depends on ARCH_MXC
> >> +	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
> > What about
> >=20
> > 	depends IMX_HAVE_PLATFORM_MXC_MMC
>=20
> I would prefer to let the architectures explicitly in Kconfig.
>=20
> If someone selects IMX_HAVE_PLATFORM_MXC_MMC by mistake on a MX51
> board, it will be possible to select the MXC_MMC driver in the kernel
> for MX51, which is incorrect.
it's not optimal, but nothing happens unless this someone registers a
corresponding device, too.

> Using the approach of explicitly marking the architectures that
> support MXC_MMC would avoid such problems as well.
> >=20
> > ?  Then if i.MX29 has the same IP you don't need to touch this agai=
n.
>=20
> Not likely to happen.=20
I wouldn't bet ...

Note I don't argue, if you still prefer the explicit list it's OK for
me.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
