From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
 platforms
Date: Fri, 21 Jan 2011 16:33:51 +0100
Message-ID: <20110121153351.GR14956@pengutronix.de>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50008 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab1AUPdz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 10:33:55 -0500
Content-Disposition: inline
In-Reply-To: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

Hallo,

On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> Currently MMC_MXC driver can be selected by all i.MX devices.
>=20
> Restrict its use only for the appropriate processors.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index d618e86..a3a9ec1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -288,7 +288,7 @@ config MMC_MSM
> =20
>  config MMC_MXC
>  	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
> -	depends on ARCH_MXC
> +	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
What about

	depends IMX_HAVE_PLATFORM_MXC_MMC

?  Then if i.MX29 has the same IP you don't need to touch this again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
