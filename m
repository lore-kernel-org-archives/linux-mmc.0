From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH mmc/next] mmc: sh_mobile_sdhi:  remove support for sh7372
Date: Thu, 24 Nov 2016 15:42:07 +0100
Message-ID: <20161124144207.GA4271@katana>
References: <1479984534-25468-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479984534-25468-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 11:48:54AM +0100, Simon Horman wrote:
> Remove documentation of support for the SH7372 (SH-Mobile AP4) from the M=
MC
> driver. The driver itself appears to have no SH7372 specific code.
>=20
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> removes this SoC from the kernel in v4.1.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Yes, the compatible entry was removed with ab22f516715086 ("mmc:
sh_mobile_sdhi: remove obsolete support for sh7372").

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNvw/AAoJEBQN5MwUoCm2OwAP/RtD5L3EiCNltbEy4ZGep0ek
i/TYeJo5d2PV7RIy8xt90iCBsNa5Rho+Ywxq1l8gTAa+rrFtTAcjIDfCqLY+dKoa
cnL20Al6nc6qyHwCSytRSXHT2ewUmpSG1PmFSnuIHpsZEx3eSmoMoIXwOWMmtTUT
Hm73zmpV/sjAAMw45h1b503TE4BuEdU/j8MXDMoNsH9emfVgABezxXceZQMD5wfV
4eQOdDiGN83Kze6Xy3rf4e4iHQ3i2oN/WSCP5cgXqHbY3BzafwTExjwFc024Akvw
c6SMKpiqvtTTr4niICfa9A3rbf6vDoXrejziipKliYKCLuoJf5Riy/WDpMjodwkD
sUsNe32MRwF8+SNKhAWF/geSXXhOWFSX0VSY+rHD9eHDiKCa4NmIZfkWXIIwgeWW
4c4gWNPs2MXE0PnT0UYUBOSPCsMaHOVgb/kZ5avg7OlnJ3AioySWqjSmD0j5OvOm
ZLCMZOaK7op9+rttBgZwhc9Yx/Urx0RUlGlCJ3S4klJDYSuJcfFehBDE7Tm+tO9u
niPRHmm25EmVC/Fr3sxZM/Lvy8c6ps0Mo3794dBqYmH2M6HlZU2tf77VA8cp2N7T
8rQN9PgjQrWgGKNaRyMbYBCpHD7+g9sw2Zj/ZAfa2xskmTfOyI32ObHO9S1dKk8Z
oA8rwNmGuGpV9rOk2ihT
=V5zO
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
