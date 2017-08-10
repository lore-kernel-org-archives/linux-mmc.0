From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: renesas_sdhi: use extra flag for CBSY usage
Date: Thu, 10 Aug 2017 10:46:58 +0200
Message-ID: <20170810084658.GC2175@katana>
References: <20170809190041.1052-1-wsa+renesas@sang-engineering.com>
 <20170810075850.GD16647@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170810075850.GD16647@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Chris Brandt <chris.brandt@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 09:58:50AM +0200, Simon Horman wrote:
> On Wed, Aug 09, 2017 at 09:00:41PM +0200, Wolfram Sang wrote:
> > There is one SDHI instance on Gen2 which does not have the CBSY bit.
> > So, turn CBSY usage into an extra flag and set it accordingly. This has
> > the additional advantage that we can also set it for other incarnations
> > later.
>=20
> What is the run-time effect, if any, of this change?

The run-time effect is that a few cycles are saved because CBSY signals
ready a bit earlier than SCLKDIVEN. Though, the more important aspect is
that docs explicitly say to wait for CBSY. That's why this change was
requested although I don't think it will matter much in practice.

> > Chris: according to the specs I have, we can enable it for RZ as well. =
I'll
> > send a patch for that in a minute. If you could test this on top of thi=
s one,
> > that would be much appreciated! Thanks.
>=20
> I take it from the above you did a pass of the available documentation to
> see which SoCs support this feature. If so, thanks!

I don't have docs for R-Car Gen1 SDHI. But given that even Gen2 has one
SDHI instance without CBSY and Gen1 is older, my educated guess is that
it does not have CBSY.


--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmMHYIACgkQFA3kzBSg
KbZKCg/8CNr/CkrksMUU/DDHU3L4vgpcRLpHXnVHFmoJzb1rS01p75CSYLGq6TwS
R9sDTPHbvxfQoK/C01JC2WfKiKygtCRbS9/1vro6KgaNKNcj8cGN91f7KoKvJ8w8
+7K1DCiCrZSvJ+d2H+6NEPIhrpVqCdLuHgKvh3vySRyGeIHVni3wFT7ZrDmvzvVp
7OG7Qg8q8TjL6MkQefjzJvZhBAbhXGvYLkdEXjg+63jlQ48JEdfZmObJRsATOQ5S
cJlvd5sLYtA13s3eqth960Amkynt0n+McwSJeqZA3F3A1LgB0kMWli/WLTe5ReWE
pTPSGZX33KORbrJ8hQ/0vc98s0kPm0IfQLFHT7v/dGLDZIvRhr6m0izE+On8tq1/
SSgyy38p0MykwL5/CH2phy2PDyKdHHPNn1NQUyB/e6/dfHZJx1W0imBhjcB0Z3pm
etsvocRE/i0QdVQ+X01UkNE5+syM86X6zGLWcnAEc7bYxGT8SDbGZPPtT0UG4WcM
CwbMJ1+Gf3wZfrgo1uKg5s6FUSLZr+SiNA2vTVmjc7+6LqZrVsjq5JQOSHsybpPH
ohhFgHxWJZYcfuiMh66Vybusmrx2RUujOUh+yqwvSVMZBn188oT2H5tJcNyCxf7k
P3t8f9+KnMSG7oJb8aG4z+XgPJJwd5jEI3TAB6GVe40wrC6azPg=
=GhaQ
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
