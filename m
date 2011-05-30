From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Mon, 30 May 2011 11:07:49 +0200
Message-ID: <20110530110749.332df87a.ospite@studenti.unina.it>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
	<1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
	<20110511130852.GB12469@opensource.wolfsonmicro.com>
	<20110511225337.094839a2.ospite@studenti.unina.it>
	<20110511205703.GA24486@opensource.wolfsonmicro.com>
	<20110518192320.9dd69cb5.ospite@studenti.unina.it>
	<20110518194211.GA5077@opensource.wolfsonmicro.com>
	<20110523171023.4df5af10.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__30_May_2011_11_07_49_+0200_XhKx_bxwFIQzCoJk"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:33851 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab1E3JIK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 May 2011 05:08:10 -0400
In-Reply-To: <20110523171023.4df5af10.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

--Signature=_Mon__30_May_2011_11_07_49_+0200_XhKx_bxwFIQzCoJk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 23 May 2011 17:10:23 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> On Wed, 18 May 2011 12:42:12 -0700
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>=20
> > On Wed, May 18, 2011 at 07:23:20PM +0200, Antonio Ospite wrote:
> >=20
> [...]
> > >   2. Add a proper function with all the needed parameters to abstract
> > >      the actual var names, this would be something like:
> > >      mmc_regulator_set_power(mmc, power_mode, vdd, vcc, pdata)
> > >      and yet checking for pdata->setpower can be tricky as 'setpower'=
=20
> > >      is an arbitrary name.
> >=20
> > This would be good.
>=20
> A WIP patch, I don't have a lot of time to spend on this, I tried to
> handle the driver specific 'setpower' callback with a macro, let me
> know if you have a better idea:
>=20
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index bcb793e..dbbe535 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -298,6 +298,32 @@ static inline int mmc_regulator_set_ocr(struct mmc_h=
ost *mmc,
>  }
>  #endif
> =20
> +#define STRUCT_FIELD(s, f) ((s) && (s)->f ? (s)->f : NULL )
> +

Any opinion on this macro? See its use below. It is meant to deal with
driver specific struct fields, which can have arbitrary names, I though
that using some syntactic sugar to deal with those as arguments when
calling the function was not that horrible.

If that looks acceptable to you too I will submit the
mmc_regulator_set_power () patch, otherwise I would ask to consider the
simple patch to mmc_spi.c for now.

[...]
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 2e8db20..c9a229f 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1231,21 +1231,18 @@ static inline int mmc_spi_setpower(struct mmc_spi=
_host *host,
>  					unsigned char power_mode,
>  					unsigned int vdd)
>  {
> +	int ret;
> +
>  	if (!mmc_spi_canpower(host))
>  		return -ENOSYS;
> =20
> -	if (host->vcc) {
> -		int ret;
> =20
> -		if (power_mode =3D=3D MMC_POWER_OFF)
> -			vdd =3D 0;
> +	ret =3D mmc_regulator_set_power(host->mmc, power_mode, host->vcc, vdd,
> +				      &host->spi->dev,
> +				      STRUCT_FIELD(host->pdata, setpower));
                                      ^^^^^^^^^^^^^
> +	if (ret)
> +		return ret;
> =20
> -		ret =3D mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
> -		if (ret)
> -			return ret;
> -	} else {
> -		host->pdata->setpower(&host->spi->dev, vdd);
> -	}
> =20
>  	if (power_mode =3D=3D MMC_POWER_UP)
>  		msleep(host->powerup_msecs);

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__30_May_2011_11_07_49_+0200_XhKx_bxwFIQzCoJk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3jXmUACgkQ5xr2akVTsAFHcwCgrOr96rlmSZuR2rHZux9TftfP
/9wAoImG3yocfpvH+lF7K8pZF//SwrC8
=Ac6b
-----END PGP SIGNATURE-----

--Signature=_Mon__30_May_2011_11_07_49_+0200_XhKx_bxwFIQzCoJk--
