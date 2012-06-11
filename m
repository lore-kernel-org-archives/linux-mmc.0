From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Mon, 11 Jun 2012 22:23:33 +0800
Message-ID: <20120611142332.GR11439@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
 <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
 <CAPDyKFrrxyk-JpLFge5+0xbYjJ=-24avWn8Optfg88-i006-Ng@mail.gmail.com>
 <1925406B-D680-40BB-890A-78447EEB4583@marvell.com>
 <4FC33362.4010806@intel.com>
 <20120528144317.GF4032@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1206111321120.29799@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brdEIFGMNIjz5YJG"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:42379 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab2FKOX7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 10:23:59 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206111321120.29799@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>


--brdEIFGMNIjz5YJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2012 at 02:39:29PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 28 May 2012, Mark Brown wrote:

> > Even if the supply is always on you can easily provide an always on
> > regulator.  From the point of view of the consumer if there are two
> > physical supplies needed it's much clearer and easier to just code that
> > and deal with the fact that we might have no control over them
> > externally, there's nothing device specific about that process.

> Mark, I'm not sure I understand your above comment correctly. The=20
> function, that I add in this patch doesn't do much now, that we removed=
=20

> IIUC, to satisfy Philip's requirement for a second regulator it would=20
> suffice to just issue one more devm_regulator_get() and let the caller=20
> deal with any errors. Is this what you're suggesting or are you against=
=20
> adding the second regulator? We could of course also add it later, but=20
> that would change the function prototype (unless we add regulator pointer=
s=20
> to struct mmc_host itself). Whith existing users such changes are a bit=
=20
> messy...

Yes, that's what I'm suggesting.  I guess you could wrap the two
regulators up in a small struct without it being too invasive?

--brdEIFGMNIjz5YJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1f8qAAoJEBus8iNuMP3dxWAP/iyMK6ILDgN19X+8/CtiKS12
7mh4+iSqzicrR15lt4cl3595JKOv0OC6EyqCY0pQ/l4EfbTvUqVoc3eJmjhA901a
Z+5P7oqWQoysqnqR/AaLC/oZvQBh1L10zhiVVEw7JMmIbUMGmHIuzac2nZ0CkpCT
64HmPsolNH/Ha3YMrh9GXc+XwKgN/OxSUaNZqnzACf2yVOYYEyoHAPF+W94oFALO
Nk1e48zkuIil6pQHXnStgp8ndnWEV7BdOPzzyE2mQNH2ooGmKTmaO6a4B8cDhU6f
Tg+pYMiQF4I0cIk3QAy7/uqhekkO3BTBKSh240WHniTs/MmWKAKB/e++oZWFJVYM
QIrpC2bD9+CsqG3ZZhvzDef6w5onO3YJPfEUEZ/tom0kSg9vbIT8tDq5ZpY4A71u
xP6ZBojS6Avt81UZSgNiiJTDBtH02Lmt9MrDNF8Rlt09c5hBpiaiNCqYxSOyR3NY
Hksu0fznnZq0KCSFzHW3R+peUc4XueN7O4wgBeIHS4o6HXckAe6e9vSQHq0a5Uws
xl6ruO2+t5+wE394C+kwJTzhDkLQYmrh4e9A2GBeXlApNVva2BnQoFAWG9WxEUVF
ua3HIyR4EvVClSCwin+CzmmRuJcS3GKA5cBEU/h4IDaTkEwpQyPmBut9zrU91q73
qi6c4LqA8NvEP6Ut8I0+
=OhtF
-----END PGP SIGNATURE-----

--brdEIFGMNIjz5YJG--
