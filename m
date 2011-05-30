From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Mon, 30 May 2011 12:57:57 +0200
Message-ID: <20110530125757.483d6f4c.ospite@studenti.unina.it>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
	<1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
	<20110511130852.GB12469@opensource.wolfsonmicro.com>
	<20110511225337.094839a2.ospite@studenti.unina.it>
	<20110511205703.GA24486@opensource.wolfsonmicro.com>
	<20110518192320.9dd69cb5.ospite@studenti.unina.it>
	<20110518194211.GA5077@opensource.wolfsonmicro.com>
	<20110523171023.4df5af10.ospite@studenti.unina.it>
	<20110530110749.332df87a.ospite@studenti.unina.it>
	<20110530101447.GA5782@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__30_May_2011_12_57_57_+0200_Au04Rh7S3iRYiwrN"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:59728 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889Ab1E3K6K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 May 2011 06:58:10 -0400
In-Reply-To: <20110530101447.GA5782@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

--Signature=_Mon__30_May_2011_12_57_57_+0200_Au04Rh7S3iRYiwrN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 30 May 2011 18:14:48 +0800
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, May 30, 2011 at 11:07:49AM +0200, Antonio Ospite wrote:
> > On Mon, 23 May 2011 17:10:23 +0200
>=20
> > > +#define STRUCT_FIELD(s, f) ((s) && (s)->f ? (s)->f : NULL )
>=20
> > Any opinion on this macro? See its use below. It is meant to deal with
> > driver specific struct fields, which can have arbitrary names, I though
> > that using some syntactic sugar to deal with those as arguments when
> > calling the function was not that horrible.
>=20
> > If that looks acceptable to you too I will submit the
> > mmc_regulator_set_power () patch, otherwise I would ask to consider the
> > simple patch to mmc_spi.c for now.
>=20
> Would it not be simpler just to provide a standard generic struct that
> people can embed into their pdata?
>=20

I thought to something like:

struct mmc_driver_ops {
	int (*setpower)(struct device *, unsigned int);
};

struct pxamci_platform_data {
	[...]
	struct mmc_driver_ops *ops;
};

static inline int mmc_regulator_set_power(struct mmc_host *mmc,
				 unsigned char	power_mode,
				 struct regulator *supply,
				 unsigned short vdd_bit,
				 struct device *device,
				 struct mmc_driver_ops ops)
{
	[...]
		if (ops->setpower)
			ops->setpower(device, vdd_bit);
	[...]
}

static inline int pxamci_set_power(struct pxamci_host *host,
				    unsigned char power_mode,
				    unsigned int vdd)
{
	[...]
	ret =3D mmc_regulator_set_power(host->mmc, power_mode, host->vcc,
				      vdd, mmc_dev(host->mmc),
				      host->pdata->ops);
	[...]
}

It is cleaner and more uniform indeed, but it does not solve the problem
I am seeing, the issue is still there when pdata is NULL, we are at the
same point as before (the current code checks for (pdata &&
pdata->field)), and we cannot pass pdata directly as a function argument
(can we?) as it is driver specific as well.

I would be glad to discover than I am still missing something :)

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__30_May_2011_12_57_57_+0200_Au04Rh7S3iRYiwrN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3jeDUACgkQ5xr2akVTsAHeMQCfSyp8l0e81oOObQWqxqn5mdBa
8/MAn2twDhQO4qFGIiS742ord9MTdFxs
=tEro
-----END PGP SIGNATURE-----

--Signature=_Mon__30_May_2011_12_57_57_+0200_Au04Rh7S3iRYiwrN--
