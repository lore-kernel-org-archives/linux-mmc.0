From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [RESEND PATCH 4/4] mmc_spi.c: add support for the regulator
 framework
Date: Thu, 21 Apr 2011 14:49:15 +0200
Message-ID: <20110421144915.93d36d12.ospite@studenti.unina.it>
References: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
	<1303388873-15467-1-git-send-email-ospite@studenti.unina.it>
	<1303388873-15467-5-git-send-email-ospite@studenti.unina.it>
	<20110421124041.GF11788@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__21_Apr_2011_14_49_15_+0200_u1.tIvpOqCWzBfiB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:57225 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab1DUMtS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Apr 2011 08:49:18 -0400
In-Reply-To: <20110421124041.GF11788@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

--Signature=_Thu__21_Apr_2011_14_49_15_+0200_u1.tIvpOqCWzBfiB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Apr 2011 13:40:41 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Apr 21, 2011 at 02:27:53PM +0200, Antonio Ospite wrote:
>=20
> > +#ifdef CONFIG_REGULATOR
> > +	host->vcc =3D regulator_get(mmc_dev(host->mmc), "vmmc");
> > +
> > +	if (IS_ERR(host->vcc)) {
> > +		host->vcc =3D NULL;
> > +	} else {
> > +		host->mmc->ocr_avail =3D mmc_regulator_get_ocrmask(host->vcc);
> > +		if (host->pdata && host->pdata->ocr_mask)
> > +			dev_warn(mmc_dev(host->mmc),
> > +				"ocr_mask/setpower will not be used\n");
> >  	}
> > +#endif
>=20
> Why is this code conditional?  The regulator API will stub itself out
> (by returning a null pointer, which plays well with your use of null) if
> it's disabled.  I'm also not seeing any corresponding code to release
> the regulator.
>

Actually I saw this done conditionally in pxamci.c and thought it was
really needed. About the call to regulator_put() if was there but got
lost when squashing the commits into the final patch and I was still
reading that part in my mind even if it was not there anymore.
The importance of reviewers with fresh eyes.

I'll resubmit this forth patch with the needed changes.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__21_Apr_2011_14_49_15_+0200_u1.tIvpOqCWzBfiB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2wJ8sACgkQ5xr2akVTsAFAhgCgjbTV3mpj0wyrnJZ0qcw+Enb8
/PoAoIK7hya+RqpNmEJxTiYEzrPPZmrP
=X/La
-----END PGP SIGNATURE-----

--Signature=_Thu__21_Apr_2011_14_49_15_+0200_u1.tIvpOqCWzBfiB--
