From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Fri, 15 Apr 2016 22:28:03 +0200
Message-ID: <20160415202803.GA3105@katana>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
 <1459525479-20842-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
 <1460477978.32355.14.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460477978.32355.14.camel@codethink.co.uk>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >   1. The SDHI/MMC clocks now run much slower than before. Perhaps this =
is
> >      intentional, and a consequence of finding the best way to drive th=
e SD
> >      card at the target frequency?
>=20
> I don't think is generally a problem.  Probably even saves a little
> power.

If you insert an SD card, frequencies should be back to normal. This
happens on Lager at least.

>=20
> >   2. On r8a7740, the situation is worse: the HP ("High-speed Peripheral=
")
> >      clock is also scaled down from 99 MHz to 12.375 MHz.
> >      As the HP clock is the parent of lots of on-chip devices, this may=
 affect
> >      performance for all of them.
> >
> > On r8a73a4, r8a7791, and sh73a0, the SDHI clocks are children of the pl=
l1_div2
> > clocks, which are fixed.
> > On r8a7740, the SDHI and MMC clocks are children of the HP clock,
> > which is also scaled down, affecting all other siblings.
> [...]
>=20
> That seems like a bug in the clock driver.  If it doesn't have
> independent dividers for each clock client then it shouldn't allow any
> client to change the frequency.

I tend to agree.

However, I just found out that we don't check the result of
clk_set_rate(). Probably something like this is missing?


diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile=
_sdhi.c
index 5923ce7e0fccb3..e51d7b01d39a3b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -167,7 +167,7 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tm=
io_mmc_host *host,
 {
 	struct sh_mobile_sdhi *priv =3D host_to_priv(host);
 	unsigned int freq, best_freq, diff_min, diff;
-	int i;
+	int i, ret;
=20
 	diff_min =3D ~0;
 	best_freq =3D 0;
@@ -195,9 +195,9 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tm=
io_mmc_host *host,
 		}
 	}
=20
-	clk_set_rate(priv->clk, best_freq);
+	ret =3D clk_set_rate(priv->clk, best_freq);
=20
-	return best_freq;
+	return ret =3D=3D 0 ? best_freq : clk_get_rate(priv->clk);
 }
=20
 static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEU7TAAoJEBQN5MwUoCm2Vx8P/A0oYN7ZhfuNSkSEJUms/nhm
K90ImrZRnIjIVOkxsPUab7YVRedwHj3vSwrYf/baRlenwMg3WH9ghEJPHMY/vJfq
kiG5w8/WkGw+VHLUwoxYhzvxt58J0ISuSAuVLN0dT7Wi5M/3cwldkgpF2U28RXq8
hVx7CDSHFDlR9aryngbZ46z7kOJlNOAg/uk7EyJLnhaoaPizNzeZndtC+w9mWF3D
NxCBKqQ1AlpMr7yy+GkzkJ7TMnIWacBaCsV3UFeUT6nVy3zBm3bdsAa42x8114x/
PxwsE2U5QaIJQZYe/R3P3l+9MKOKesMm8J00ASPVFF0qX1o+8qLP/TQuck1HdQ4j
8HU+agN6p2cGbxSVEDiT8PC24fLHtnfzbdItjB0AmDW3NnII6TLc5Nu5tT7F1Emy
S/iVwrQV07aam5B4HLGcH21E+S+US1sQ+DSg816Pl2/2LzIFOYu1lvO5ut3r3Api
lUKXSHi0PxfL0NUgocbQU08cEqlzR00dkjI6WOLzYXkRHmlxZH8CN9PBu8mxwNfK
Cg8eVR75xYhzgVSwO4JenBZgF1rMgRea+OnkK5pQOwbjdcie32J4feSH2KRAdSe+
HKVxsGvqRi2wcP3tTwMxurht4vOZwSAHrSPH+vxLArqhM/JetSKWEWLUQEC2JrHW
gzKdwbNLAz+OqxBHf4KW
=VQjZ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
