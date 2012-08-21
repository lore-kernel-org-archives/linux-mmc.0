From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/10] Assorted MMC / OMAP HSMMC patches
Date: Tue, 21 Aug 2012 13:43:31 +0300
Message-ID: <20120821104330.GS10347@arwen.pp.htv.fi>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJ74fq0Y6SrIeKCM"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:35497 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756509Ab2HUKr3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Aug 2012 06:47:29 -0400
Received: by lbbgf7 with SMTP id gf7so4786582lbb.22
        for <linux-mmc@vger.kernel.org>; Tue, 21 Aug 2012 03:47:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, vishp@ti.com


--aJ74fq0Y6SrIeKCM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 18, 2012 at 12:22:20AM +0530, Venkatraman S wrote:
> Essentially, a lot of cleanups leading up to adding a new
> feature for OMAP HSMMC. The idea is to convert to the use
> of software timer instead of IP timer for timekeeping, due
> to the limitations of the counting range of the IP timer.
>=20
> Also added myself as OMAP HSMMC maintainer.
>=20
> Patch 9/10 is in draft state and needs more testing.
>=20
> These patches are also available at
>   git://github.com/svenkatr/linux.git my/mmc/3.6/hrtimer_updates

other than the small comments I had to patch 9, this series looks very
good:

Acked-by: Felipe Balbi <balbi@ti.com>

>=20
> Venkatraman S (10):
>   mmc: core: Add TRANsfer state to non-HPI state
>   mmc: debugfs: Print ext_csd in ascending order
>   mmc: omap: remove unused variables and includes
>   mmc: omap: fix mmc_omap_report_irq to use dev_dbg macros
>   mmc: omap_hsmmc: remove unused vars and includes
>   mmc: omap_hsmmc: remove access to SYSCONFIG register
>   mmc: omap_hsmmc: consolidate flush posted writes for HSMMC IRQs
>   mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ
>   mmc: omap_hsmmc: convert from IP timer to hrtimer
>   mmc: omap_hsmmc: Move to Maintained state in MAINTAINERS
>=20
>  MAINTAINERS                   |   4 +-
>  drivers/mmc/core/core.c       |   3 +-
>  drivers/mmc/core/debugfs.c    |   2 +-
>  drivers/mmc/host/omap.c       |  39 ++++----
>  drivers/mmc/host/omap_hsmmc.c | 212 ++++++++++++++++--------------------=
------
>  5 files changed, 103 insertions(+), 157 deletions(-)
>=20
> --=20
> 1.7.11.1.25.g0e18bef
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--aJ74fq0Y6SrIeKCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM2ZSAAoJEIaOsuA1yqRECLUQAIrOOZnksxoELte8GhKS5VMl
VxjD2Ahz99t5UxxmicxiSfkdU3XowYTROFVoTw1tMbrqsKRU1aP2wXK+FITv9nkH
zp1XxAHYPbf+Keo9wdMXDGQ31ga3oxjBc5EerLfBsfONfHo09ks6lm/dfScyX5Q9
iim5AuxjGSokt6O6QcDurQrHK2vIJinlTPjbNOfBVtGX5IjOD7pjtlGS34hGBheP
4A1LIUPwJB6Sx7fWVlkB+otrakuk/a5n7Pxl+p6ELdtGmAvVgfj4cXWoDlKHIaqQ
40FI+Gvk76x8v2mBVBM+xTp7nMqR/aYQbZV/FzbAMx8AbLteAIMeGPIPf008UIZI
OPL2Vc4YsntTIhr/oH1XZhBJI7ii4IjRPJsh0pdL6GISnDii4LzOa7xH3F1v3Bz+
Zj3wCDUUpjwmOUSoCLRYBa1ZrkLRvGZeWdFWX4Lri/cl8B7HNClA/dwhOVdw09fS
fZGi2oc1ha/OaAPFxE5kmlcbx3WWbqToyHvo13y+ihs7JeRZPk+EkStJIPiXglgY
hSqzZQrzw9eIKeXXrUS0eOO6vbChDmm8VUQxTHZ9XfKxBVFuNZPbb6Ynq5AHL0w2
FD4QPRN33u1i2Xux96ZyPIRc6NiW3LkSvGBiv6hoa62D8XAkkwt0/avciILiNYCa
bSZRV97Bwgjdut9RAHTi
=qg4J
-----END PGP SIGNATURE-----

--aJ74fq0Y6SrIeKCM--
