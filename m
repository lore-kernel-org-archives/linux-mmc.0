From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [RESEND PATCH 4/4] mmc_spi.c: add support for the regulator
 framework
Date: Tue, 26 Apr 2011 18:21:27 -0300
Message-ID: <1303852887.2133.50.camel@laptop>
References: <1300733202-27316-1-git-send-email-ospite@studenti.unina.it>
	 <1303388873-15467-1-git-send-email-ospite@studenti.unina.it>
	 <1303388873-15467-5-git-send-email-ospite@studenti.unina.it>
	 <20110421124041.GF11788@opensource.wolfsonmicro.com>
	 <20110421144915.93d36d12.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DWzRx7bb7TtNJcLJtWrB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53879 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405Ab1DZVVa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 17:21:30 -0400
Received: by gwaa18 with SMTP id a18so392288gwa.19
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 14:21:29 -0700 (PDT)
In-Reply-To: <20110421144915.93d36d12.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net


--=-DWzRx7bb7TtNJcLJtWrB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qui, 2011-04-21 =C3=A0s 14:49 +0200, Antonio Ospite escreveu:
> On Thu, 21 Apr 2011 13:40:41 +0100
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>=20
> > On Thu, Apr 21, 2011 at 02:27:53PM +0200, Antonio Ospite wrote:
> >=20
> > > +#ifdef CONFIG_REGULATOR
> > > +	host->vcc =3D regulator_get(mmc_dev(host->mmc), "vmmc");
> > > +
> > > +	if (IS_ERR(host->vcc)) {
> > > +		host->vcc =3D NULL;
> > > +	} else {
> > > +		host->mmc->ocr_avail =3D mmc_regulator_get_ocrmask(host->vcc);
> > > +		if (host->pdata && host->pdata->ocr_mask)
> > > +			dev_warn(mmc_dev(host->mmc),
> > > +				"ocr_mask/setpower will not be used\n");
> > >  	}
> > > +#endif
> >=20
> > Why is this code conditional?  The regulator API will stub itself out
> > (by returning a null pointer, which plays well with your use of null) i=
f
> > it's disabled.  I'm also not seeing any corresponding code to release
> > the regulator.
> >
>=20
> Actually I saw this done conditionally in pxamci.c and thought it was
> really needed. About the call to regulator_put() if was there but got
> lost when squashing the commits into the final patch and I was still
> reading that part in my mind even if it was not there anymore.
> The importance of reviewers with fresh eyes.
>=20
> I'll resubmit this forth patch with the needed changes.

Hi,

The #ifdefs on pxamci were needed because at the time it was written
IS_ERR(regulator_get()) would return _false_ if CONFIG_REGULATOR is not
defined, breaking compatibility with the older ocr_mask/setpower.

I don't know if the regulator api changed it's old behaviour, see
http://www.mail-archive.com/openezx-devel@lists.openezx.org/msg01954.html


--=20
Daniel Ribeiro

--=-DWzRx7bb7TtNJcLJtWrB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk23N1cACgkQw3OYl0G0liT9CwCdE6T9TqLGPzcnZKuEqrzov9l0
HakAoIiAsx1JYhCdl6CYQNDGGEBoO7ps
=aSll
-----END PGP SIGNATURE-----

--=-DWzRx7bb7TtNJcLJtWrB--

