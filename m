From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: use the generic config for omap2plus
 devices
Date: Thu, 11 Jul 2013 16:09:21 +0300
Message-ID: <20130711130921.GD30970@arwen.pp.htv.fi>
References: <1372422894-23729-1-git-send-email-a-bindra@ti.com>
 <1373472384-13067-1-git-send-email-a-bindra@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52325 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab3GKNJm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Jul 2013 09:09:42 -0400
Content-Disposition: inline
In-Reply-To: <1373472384-13067-1-git-send-email-a-bindra@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: a-bindra@ti.com
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>

--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2013 at 09:36:24PM +0530, a-bindra@ti.com wrote:
> From: Amarinder Bindra <a-bindra@ti.com>
>=20
> OMAP's hs_mmc driver is used for MMC controller operation on many
> omap2plus SoCs (OMAP2430, OMAP3, 4, 5 and AM335x).
>=20
> Considering that the device tree entries are already present for these,
> allow the driver to be built using the config ARCH_OMAP2PLUS rather
> than individually adding a config for each SoC to enable the
> support.
>=20
> Use COMPILE_TEST to enable the build for other platforms.
>=20
> Signed-off-by: Amarinder Bindra <a-bindra@ti.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Nishanth Menon <nm@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3q6BAAoJEIaOsuA1yqREbsMQALFlW4vBKkyu8scdFGRj2uB8
RKrWiCmFWMn0vkb6UIbFK1e8TM3TpflZx0U1cHv+2+IRVmzntHEoKQakmz68hp5l
WE6XMLGbaDVksztdfhmq1rSEpI3n+F0e/awXGOJuNrfd2nGTaKjrprg5EQkAQtHm
29UAOAPzJKpbRUwuJq39+ZPkgSPu8UF2oyPTOUie12BGczHH5vw92e1XucUZlg9h
p5dL0KMVdlAu4eIRCjf29ASGbs+ZcXagNnfaLiTlxFBvP7k0gzN5a5grjhzWeOdu
a0/uasKHh+iDVSLLIqhP7opK7X8CMWSoE1RNXvEeHl25rE6uHJy5P7kGXuro8aTN
4VO/QenSdC5MlUKkwvx1eWv/2YOuaTL3nk+KMr/wXpfo0z9VcVPV4ckMQ/tgq/qP
1jACLAQ9Gh4qcueZZ1KXUlYwipiLxmPVoAGb35QpxTfZax0DDMZCawmZ7Kk2zTzL
LVCen5swI89Kwo8jHJwX0sx8DZiHbpRK99drNl7S1qnHCUP1EaBhnK1cAeBKhNra
aZeee/4BY7/nsUOaRUmOF2XyPN9KQZGenYvT+VHmNhKZo6gW2bY1hoxEdtlWggPQ
tGx9YSs+AfufJAntByDMJzFQHqkKAD8h9uxywNxTXYQDRGsKvHjsUCCgDHsYQfOx
oYIqla8ZINCzR4U+F2zp
=7ox6
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
