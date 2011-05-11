From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Wed, 11 May 2011 22:53:37 +0200
Message-ID: <20110511225337.094839a2.ospite@studenti.unina.it>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
	<1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
	<20110511130852.GB12469@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__11_May_2011_22_53_37_+0200_K.2=OBS.ZA83MALg"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:32969 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755772Ab1EKUxm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 16:53:42 -0400
In-Reply-To: <20110511130852.GB12469@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

--Signature=_Wed__11_May_2011_22_53_37_+0200_K.2=OBS.ZA83MALg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 11 May 2011 15:08:53 +0200
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

[...]
> > +	switch (power_mode) {
> > +	case MMC_POWER_OFF:
> > +		if (host->vcc) {
> > +			int ret =3D mmc_regulator_set_ocr(host->mmc,
> > +							host->vcc, 0);
> > +			if (ret)
> > +				return ret;
> > +		} else {
> > +			host->pdata->setpower(&host->spi->dev, vdd);
> > +		}
> > +		break;
> > +
> > +	case MMC_POWER_UP:
> > +		if (host->vcc) {
> > +			int ret =3D mmc_regulator_set_ocr(host->mmc,
> > +							host->vcc, vdd);
> > +			if (ret)
> > +				return ret;
> > +		} else {
> >  			host->pdata->setpower(&host->spi->dev, vdd);
> > -			if (power_mode =3D=3D MMC_POWER_UP)
> > -				msleep(host->powerup_msecs);
> >  		}
> > +		msleep(host->powerup_msecs);
> > +		break;
>=20
> This stuff all looks like it should be factored out.
>=20

OK, avoiding some duplication will be good, I agree.

I am resending a v4 with the equivalent code:

	if (host->vcc) {
		int ret;

		if (power_mode =3D=3D MMC_POWER_OFF)
			vdd =3D 0;

		ret =3D mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
		if (ret)
			return ret;
	} else {
		host->pdata->setpower(&host->spi->dev, vdd);
	}

	if (power_mode =3D=3D MMC_POWER_UP)
		msleep(host->powerup_msecs);


Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__11_May_2011_22_53_37_+0200_K.2=OBS.ZA83MALg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3K91EACgkQ5xr2akVTsAHR2QCfYVM0diWYql6mFtoCOawnnnPa
O1sAoKOw1UQnu7XtbhhOneVhVTNaK+ku
=9a0/
-----END PGP SIGNATURE-----

--Signature=_Wed__11_May_2011_22_53_37_+0200_K.2=OBS.ZA83MALg--
