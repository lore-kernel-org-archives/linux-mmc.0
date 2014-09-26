From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCH v3 11/12] mmc: sunxi: Convert MMC driver to the standard clock phase API
Date: Fri, 26 Sep 2014 22:47:40 +0200
Message-ID: <16423025.s6ZiXuohCJ@dizzy-6.o2s.ch>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com> <3992138.y6J8TjIuMq@pagira.o2s.ch> <20140926150204.GT15315@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7437499.kAG72mjR6x"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kolab.o2s.ch ([77.109.136.180]:38051 "EHLO kolab.o2s.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545AbaIZUsq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Sep 2014 16:48:46 -0400
In-Reply-To: <20140926150204.GT15315@lukather>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org


--nextPart7437499.kAG72mjR6x
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi
Great! Since I didn't see any mistakes from my side it shouldn't be a p=
roblem.
Because someone has borrowed my UART2USB(FT232)-cable I unfortunately c=
an't
test the code for now.
If you can verfiy that all the adaptions are working properly on A10/A2=
0 and
all the others you my assume my:
=09Acked-by: David Lanzend=F6rfer <david.lanzendoerfer@o2s.ch>

chears and all the best
david

> > > [...]
> > How did you calculate the actual phase values from the original
> > parameters?
>
> Like shown in the clock driver. 0 is always a 180 deg phase shift, an=
d
> any other value is the number of the parent clock cycle to outphase
> the clock of.
>=20
> the clock out phase is calculating using:
>=20
> phase =3D 360 * interval / period.
>=20
> with period =3D 1 / (parent_freq / divider)
> and interval =3D reg / parent_freq
>=20
> which makes
>=20
> phase =3D 360 * (reg / parent_freq) * (parent_freq / divider)
>=20
> If we simplify by removing the parent_freq, we end up with
>=20
> phase =3D 360 * reg / divider, which makes it rather trivial to
> calculate.
>=20
> Maxime

=2D-=20
David Lanzend=F6rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
--nextPart7437499.kAG72mjR6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlQl0OwACgkQAeZw77btGjoO0gCeNCNBoamkTSH/41FIDXDH34dN
ysAAnR6JmNgXGWWfl6ql4PFEaEw8w9k0
=T99B
-----END PGP SIGNATURE-----

--nextPart7437499.kAG72mjR6x--

