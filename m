From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Wed, 18 May 2011 19:23:20 +0200
Message-ID: <20110518192320.9dd69cb5.ospite@studenti.unina.it>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
	<1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
	<20110511130852.GB12469@opensource.wolfsonmicro.com>
	<20110511225337.094839a2.ospite@studenti.unina.it>
	<20110511205703.GA24486@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__18_May_2011_19_23_20_+0200_dTQ=7Gv38V.xphyG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:55491 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791Ab1ERRXb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 May 2011 13:23:31 -0400
In-Reply-To: <20110511205703.GA24486@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

--Signature=_Wed__18_May_2011_19_23_20_+0200_dTQ=7Gv38V.xphyG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 11 May 2011 22:57:04 +0200
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, May 11, 2011 at 10:53:37PM +0200, Antonio Ospite wrote:
>=20
> > OK, avoiding some duplication will be good, I agree.
>=20
> > I am resending a v4 with the equivalent code:
> >=20
> > 	if (host->vcc) {
> > 		int ret;
> >=20
> > 		if (power_mode =3D=3D MMC_POWER_OFF)
> > 			vdd =3D 0;
> >=20
>=20
> This isn't really what I meant - what I meant was that all this logic
> looks like it's generic to multiple drivers.  We either set a regulator
> or call a pdata callback to set power, both of which are completely
> external to the controller.
>

So you mean something like the following:

mmc_regulator_set_power(...)
{
	if (host->vcc) {
		...
	}

	if (host->pdata && host->pdata->setpower)
		host->pdata->setpower(mmc_dev(host->mmc), vdd);
}

I like  the idea, the only concern I have is that the mmc host drivers=20
can call 'vcc' and 'pdata' and 'setpower' with arbitrary names, what is=20
the kernel practice in cases like this where we want to use some common=20
code accessing driver-specific structures? I can think to three=20
alternatives right now:

  1. Consider only code currently in mainline (names are consistently=20
     vcc, pdata and setpower) and use a _macro_ based on that, assuming=20
     than future patches are going to copy the var names anyways.

  2. Add a proper function with all the needed parameters to abstract
     the actual var names, this would be something like:
     mmc_regulator_set_power(mmc, power_mode, vdd, vcc, pdata)
     and yet checking for pdata->setpower can be tricky as 'setpower'=20
     is an arbitrary name.

  3. Move stuff from driver structures to subsystem structures, which I=20
     don't think is needed in this case.

  4. (The hidden lazy one) make the code equal across all the drivers
     so new drivers copying it will be consistent, but still leave it=20
     duplicate.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__18_May_2011_19_23_20_+0200_dTQ=7Gv38V.xphyG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3UAIgACgkQ5xr2akVTsAGF/gCdE7NOA9H5YJyXiX+K8p1eKLOm
8SsAn26KNQda6n5x93ZbueeP4wggzIH6
=yK2I
-----END PGP SIGNATURE-----

--Signature=_Wed__18_May_2011_19_23_20_+0200_dTQ=7Gv38V.xphyG--
