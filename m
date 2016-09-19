From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 5/6] arm64: dts: r8a7795: salvator: enable on-board
 eMMC
Date: Mon, 19 Sep 2016 22:29:04 +0200
Message-ID: <20160919202904.GB1425@katana>
References: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
 <20160919124921.8172-6-wsa+renesas@sang-engineering.com>
 <3abe65a3-0047-f39d-2639-b39b98081c42@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37716 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbcISU3J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 16:29:09 -0400
Content-Disposition: inline
In-Reply-To: <3abe65a3-0047-f39d-2639-b39b98081c42@cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >+	sdhi2_pins: sd2 {
> >+		groups =3D "sdhi2_data8", "sdhi2_ctrl";
> >+		function =3D "sdhi2";
> >+		power-source =3D <3300>;
> >+	};
> >+
> >+	sdhi2_pins_uhs: sd2 {
> >+		groups =3D "sdhi2_data8", "sdhi2_ctrl";
> >+		function =3D "sdhi2";
> >+		power-source =3D <1800>;
> >+	};
> >+
>=20
>    I'm afraid you're just overriding the props in the first "sd2" node wi=
th
> this...

Oops, thanks, will fix!


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4EqPAAoJEBQN5MwUoCm2GyoQAKE64jgxAFnw1ZMkHpR0a8u1
gonoTlxBBAsP0LM4pvasMRy/MAtSKiXCUQ275RF6DBhoD8LQkoMSNpxtfZXyDePd
zXtfb71Pbvg7NTXK5J7xEZYg10D51a9xiHHQyDh9/Kwl0CD6lnPHTB+7BBEQxlhy
9HwhXVIegNOwwhXmR0J3EQlUVcOsWaw9uBWnQB9ffSlJhHSrVHAnDGaLxFdENncT
wz8H+GBB0JK3loy5lWSU3p5VzplNPPfNyQWKsdSdnr1KeTJqTQYRDw96sWG/L6TZ
WwXg8hhmE2hNe1DJJ45bPnKWfa01OeiMZyRgiv1fi3h4yeqN+cf5+KIC12QFq+1B
nT5+BHFvAYBUWB2CRGmaq5hr3knmKhBac/68tXjLAhIBxqJXEqt4jwlDfiCnxwaX
aTHmed8fWl9eH8lPT8pRNXguX22juPm7LG2O1VZTkg5c5GSHz4J8UvqhS7c6A9Zp
LijrBHjGhW8nn5fknEMRv6ezOrrt6Wq1eFOqDwBVasIm5ESt1ZmVj2whbutqK2YB
RG2CX2aEZTZmkV+DtSf+mFivgEZXJcl1fgewdpUwIR2Ep5r3zp2l4/W9ImRE2rj9
wGBY5SO0AyD2xH0T8qE50Fu6W/gllXs78qTtl2c+2MKFI/wokF2sK7iTh7PHdSWU
4C67lXyvPv4TYPNh2Nrd
=AKY2
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
