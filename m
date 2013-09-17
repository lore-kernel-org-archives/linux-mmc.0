From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] mmc: core: Fixup ocr mask setup to prevent spec
 violation
Date: Tue, 17 Sep 2013 12:00:19 +0100
Message-ID: <20130917110019.GQ21013@sirena.org.uk>
References: <1379341068-27097-1-git-send-email-ulf.hansson@linaro.org>
 <Pine.LNX.4.64.1309162253320.17217@axis700.grange>
 <CAPDyKFrvPkwAVfi8gv0hG3DKeiJm+_AqODhERX=O0ZxB-gcHiw@mail.gmail.com>
 <Pine.LNX.4.64.1309171008190.20367@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60502 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab3IQLAX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 07:00:23 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1309171008190.20367@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prasanna NAVARATNA <prasanna.navaratna@gmail.com>


--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 10:16:06AM +0200, Guennadi Liakhovetski wrote:

*Please* remember to trim context when replying.

> On Tue, 17 Sep 2013, Ulf Hansson wrote:
>=20
> > In one of my cases I am also using a regulator, but from a board
> > configuration point of view I know I am the only user on this
> > regulator, thus I can be sure I can switch it off when I want.

> So, do I understand correctly, that if we get a regulator exclusively and=
=20
> it is capable of changing status (REGULATOR_CHANGE_STATUS) and it is not=
=20
> always on, then we can assume, that every call to regulator_enable() /=20
> regulator_disable() with a suitable use count _will_ switch power off or=
=20
> on? Maybe then we could adjust mmc_regulator_get_supply() accordingly -=
=20
> first try to get the regulator exclusively, if it fails, try shared. If=
=20
> succeeded and the conditions are satisfied - set the new PWR_CYCLE flag.

This use case is what regulator_get_exclusive() was added for.  The
method you are suggesting there is not a good one, though - if the
supply is shared it will cause the first MMC controller to get the
regulator and the others to fail.  However I think we should probably
fix this by having code in the regulator core which checks if multiple
consumers are mapped and refuses to allow get_exclusive() in that case.

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSODZAAAoJELSic+t+oim9eyMP/jzNMvQY1XTOb4n5xEn7jXdb
LFkIGuF+adUS++6dpHXfvB9hTvB8aS+f6+YIPs6FwHoR7LIFRl+WrfKQAub6b6tj
yMekbdCQc6YfF4DRJ3fQkjiq2Dy0/vo8+Zv+01M2cvg7CHRh6MAbka5cuyfZjKxx
f8ArPxWt4xbRXdUd5DppPD/kelutYtlGKgLTm4mr6oOqomXSUWcxUkr/aKx6ymrA
5Oy7Z7kWI2SvoiDdxCNPeYbdU1BKuLKZEoluXHdaZFDNJ/3y14ciSkHw95xCebW5
I4pdFrOcg4nDunQfVIW0diZebKqUbLXB7SrqlIld2ibhRnL1J/MZtD45/ndzwxrT
9huPRa2HqnI6Nx8Lf7IiIY6D1himTm02OlidSvLMbKR02acN4h1di9P9NIduncru
X3NneQ5QWDirb2+ZgZ+XE7zVP5/8y3Zo2t16ayVYe8NRczGGGBeuNXf7XndApONg
jHKNXABbxZmV0aEErJ0L3zGLhvGN0pg2phAf/1HbKck2jHwyl1jyfblpdPFeekfX
q5Vl2Eq16bOLQux0e2YdO/IMB+hKaFmE/riyMq4BfYanBAnn3Cm6MkxCB8FxYrMk
hyYTs5lQAXKwbqKgr1I93uN8sF7mtiN7o9YDdN1wHmo2yqa0diRuO2e9pZcPpSmC
pFZLejM1p1i9iArCBgna
=mvuh
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--
