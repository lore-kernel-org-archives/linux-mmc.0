From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/9] mmc: omap_hsmmc: use devm_request_mem_region
Date: Fri, 21 Mar 2014 11:30:27 -0500
Message-ID: <20140321163027.GN12310@saruman.home>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
 <1395418658-2375-1-git-send-email-balajitk@ti.com>
 <1395418658-2375-5-git-send-email-balajitk@ti.com>
 <20140321161844.GK12310@saruman.home>
 <532C6888.5090904@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51655 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbaCUQcT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Mar 2014 12:32:19 -0400
Content-Disposition: inline
In-Reply-To: <532C6888.5090904@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: balbi@ti.com, linux-mmc@vger.kernel.org, chris@printf.net, linux-omap@vger.kernel.org

--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 09:57:52PM +0530, Balaji T K wrote:
> On Friday 21 March 2014 09:48 PM, Felipe Balbi wrote:
> >On Fri, Mar 21, 2014 at 09:47:33PM +0530, Balaji T K wrote:
> >>With devm_request_mem_region conversion release_mem_region can be
> >>removed in clean up path
> >>
> >>Signed-off-by: Balaji T K <balajitk@ti.com>
> >>---
> >>  drivers/mmc/host/omap_hsmmc.c |   11 ++---------
> >>  1 files changed, 2 insertions(+), 9 deletions(-)
> >>
> >>diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
> >>index 8e35a6e..9952673 100644
> >>--- a/drivers/mmc/host/omap_hsmmc.c
> >>+++ b/drivers/mmc/host/omap_hsmmc.c
> >>@@ -1881,7 +1881,8 @@ static int omap_hsmmc_probe(struct platform_devic=
e *pdev)
> >>  	if (res =3D=3D NULL || irq < 0)
> >>  		return -ENXIO;
> >>
> >>-	res =3D request_mem_region(res->start, resource_size(res), pdev->name=
);
> >>+	res =3D devm_request_mem_region(&pdev->dev, res->start,
> >>+					resource_size(res), pdev->name);
> >
> >while at that, why don't you switch over to devm_ioremap_resource()
> >already ?
>=20
> I can't do that because of 0x100 reg_offset on OMAP4+ and am335x+

split the resource into two parts, one is OMAP-specific and the other is
the generic SDHCI start.

--=20
balbi

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTLGkjAAoJEIaOsuA1yqRExRYP/RW4w96jtI+8xfXsDd14FpnK
4wByNcJdHtOkEbj+o5J6dXI4HqrDZp+6YKME2r9h48MchHxlnQ9fr+ffvINyvseW
G7a2neNMzYCm/uIA2gaDVQOA/xZ8fmCH2BCaXchfs9OfMy8uQ53yIt/1MIONxV5e
uTuG+UoUzFD/wR5HNufs+QxwgXjjb5t42WltaiXm6gxO6Y839exygoSIoI2RNoJt
dkK5HkcO8EI42d2ELxHFd5nrEI8dX8E8FPu13ox26PstJqy2nO6ZPRrE3MGINeJk
K1OGqRLvdJcR8wZN+YYAJo69iGEq/fxWsqE6AirUgQ8rVXX46V0icq2NfD/Vl154
XQD/MvTUgvtvCevM36G6e92CZ7Q3amdtyonEPpKc2Guo5PIZ6AMwa/eoj8ileMLl
Mzf0ZcnMNFoP9Yj4sT7RbFtDoR1Wgpu62s1U7iGMSNSkgHIzwfqqe2m6NIK3DAQ6
ixlSv/qgBYnnZnuSsq5wnDSylXYdbDCvYwkjBrC5YqiBIesC5qGV9HHEj3t+6/Vv
USyRruaknjDT0BKWFEMbDh/mMtxnsAGIUGa5VHpGBHBqMXOG4Bkw9mWJmOx76HkT
Dg+HGVrQkxlnumlM40GEKn0+CeTj9pgb1iDJ7kX+Lb0TutkmRe1n00022cnohXBl
4mceLKxMMY9+Fbos1xxH
=ZB/o
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--
