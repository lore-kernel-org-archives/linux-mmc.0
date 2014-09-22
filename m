From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 00/12] clk: sunxi: Improve MMC clocks support
Date: Mon, 22 Sep 2014 13:31:33 +0200
Message-ID: <20140922113133.GF15315@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47974 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751070AbaIVLfF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Sep 2014 07:35:05 -0400
Content-Disposition: inline
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mike,

On Thu, Sep 11, 2014 at 10:18:14PM +0200, Maxime Ripard wrote:
> Hi everyone,
>=20
> Here is an attempt at improving the MMC clock support in the Allwinner
> SoCs.
>=20
> Until now, the MMC clocks were having a custom phase function that was
> directly setting an obscure value in the right register, because we
> were not really having any idea of what these values were.
>=20
> Now that we have more informations, we can introduce a common function
> call to get and set the phase of a particular clock, and use this in
> both our provider and our client.

It would be great that we have that custom phase API out of the kernel
for 3.18, and you were one of the greatest supporters to that idea,
could we please have your view on this?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIAiVAAoJEBx+YmzsjxAgp4EP/1V4DXIzHgy4otoDIGcNZnas
vsWJP50CkQuSyuI4JWah19tj/yX9U7P4taTMKJr49kMJYjsVn9/FpXu9Ur1zmaCn
xDV4BqjQQl9lf/1L4hS7+DyxV7sYyMYRN8fELG9iedr33Auf4BO04wGg7p0jHvUu
9wSirogE4owGCRP4EfFF0GA7kLhRi4wU1Wk/31bgVUO0/5miCdipva03DrHkk+o6
EXF5P6P9K+uaHtONwwKhHyjwQfLpQObeCUHQIo1x15T09ap4SpaEFWKpe3XI/2/V
LaA8bPJt7qB0Hd0KhVa6EUMziJmbq6lNBnuk+n2US7d/Fx10mObzUuskaI0DydHn
y2Ex3jb6X1XyF5riEZm5hunzjEWFIvAPr0HVH92ahSWuSs5S3M3VRVvtn0Off8ku
RI+t0B1XKF9/amYtQxII+5q0B0eepi+CQHr5W1Orw2D6Q7qwe80R1gdF3/MUzQUr
MR4GTyxTosIgR48pKQUdQ+J5qzLaDxeKQSlEfDRo/wgYyQ6xJeHS8zOVy67fz5SL
TSNGjFMVVT92+SJW8Iu1y2JOEOCRq1XojS9G4nf5DtXnfXykhb2gMZK3k15P3oHQ
4DsSM6+ZBgU/G2A7vR6hawlfEO3oN+kFIEOORnqXXBZ4tOU5CoRYOBcbtRf8HGIX
nzkLm7+neZ9VcgDYFkoy
=qfpr
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
