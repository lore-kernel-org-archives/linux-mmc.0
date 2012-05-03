From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/29] mmc: tmio: add regulator support
Date: Thu, 3 May 2012 16:56:55 +0100
Message-ID: <20120503155655.GQ3955@opensource.wolfsonmicro.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-14-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8HhMLSHvAouSipEr"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40654 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755817Ab2ECP46 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:56:58 -0400
Content-Disposition: inline
In-Reply-To: <1336057558-11031-14-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


--8HhMLSHvAouSipEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 05:05:42PM +0200, Guennadi Liakhovetski wrote:

> +static void tmio_mmc_set_power(struct tmio_mmc_host *host, struct mmc_ios *ios)
> +{
> +	if (!(host->mmc->caps & MMC_CAP_POWER_OFF_CARD))
> +		return;
> +
> +	if (host->vdd)
> +		/* Errors ignored... */
> +		mmc_regulator_set_ocr(host->mmc, host->vdd,
> +				      ios->power_mode ? ios->vdd : 0);
> +	else if (host->set_pwr)
> +		host->set_pwr(host->pdev, ios->power_mode != MMC_POWER_OFF);
> +}

This looks pretty much identical to the previous code, should it be
being factored out into the core?  Or put the regulator bit in the core
and provide an option to override with manual callbacks if that's
required.

--8HhMLSHvAouSipEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoqq4AAoJEBus8iNuMP3dthoP/0dm86ckicqVhEHC3ySqexkQ
Ny8IhX/ptWTqdy5cLyE+jh0x8RcPmf2Gp6Yp+vRRLwSEFnT8Y0RMAVgmuDLg2oFp
u6xQ1i92q15mZZGRfqh9LTny7IPJueZOi0RcUGfCXWRKuYMHalXcFxLf/3K84hWi
j6kOXBOeMsofOD1zousnKFuGwEnz7jZRU7ipXbEUKQetRRHzadY54gisbF5z8HTM
TJEC0uWtRaf3O6M3kwdP1LLmTC6/japokppoL8ZhvcYR0TDjnHfz1ugj9gfObwR6
GnoSEZCitxLfNVhZO1KS2/5x2Vq/Sd1leJuZL8mPnOvs4nXdwRoMlwCCzTWT6fNA
hhcQbFVq5e3tWFA2giFe8D4fefz/SXH7dgwzeZxygmftIxZs+m6N5SRGJT+Sr7Hw
SL7X5oXa3gxQUqZHjoj8mxTS7tm5rU/9ibu/ANnztQJj8DScggmaOjpo2K6VgmTL
T1Q51FN/V3WNP3mHDwAgU6R4WfakdcwrnGwLLPRXFrSiPp7+kb4PFKUU+v1DX0xH
8nCMSJGnqU523SZrYiRTUZYlBPQDqf5J6D7ej0PEH0xJZnqK8diCl65TCfFx0rrn
fNQ8ER6R8jCujg5T3EzsDgezb9Su3ubrYja12CmmGWjgyODpc6higzLmohku+Xm6
xTS3M32h3KSD0rN0lAYW
=JHNy
-----END PGP SIGNATURE-----

--8HhMLSHvAouSipEr--
