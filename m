From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Update driver to support without
 regulators
Date: Tue, 21 Jul 2015 14:57:49 -0500
Message-ID: <20150721195749.GM25385@saruman.tx.rr.com>
References: <1436902186-6542-1-git-send-email-fcooper@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60425 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbGUT5w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 15:57:52 -0400
Content-Disposition: inline
In-Reply-To: <1436902186-6542-1-git-send-email-fcooper@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rogerq@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>

--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2015 at 02:29:46PM -0500, Franklin S Cooper Jr wrote:
> From: Roger Quadros <rogerq@ti.com>
>=20
> Update driver to support without regulators.
>=20
> Without this patch boards that do not enable regulator config options will
> fail to boot with a kernel panic.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  2 ++
>  drivers/mmc/host/omap_hsmmc.c                           | 14 ++++++++++-=
---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Do=
cumentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 76bf087..2408e87 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -22,6 +22,8 @@ ti,dual-volt: boolean, supports dual voltage cards
>  ti,non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
>  ti,needs-special-hs-handling: HSMMC IP needs special setting for handlin=
g High Speed
> +voltage-ranges: Specify the voltage range supported if regulator framewo=
rk
> +isn't enabled.
>  dmas: List of DMA specifiers with the controller specific format
>  as described in the generic DMA client binding. A tx and rx
>  specifier is required.
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b2b411d..16c870f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1551,10 +1551,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *m=
mc, struct mmc_ios *ios)
>  	if (ios->power_mode !=3D host->power_mode) {
>  		switch (ios->power_mode) {
>  		case MMC_POWER_OFF:
> -			mmc_pdata(host)->set_power(host->dev, 0, 0);
> +			if (host->use_reg)
> +				mmc_pdata(host)->set_power(host->dev, 0, 0);

looks like this driver should just be use regulator_get_optional(), then
->set_power() would still work, no ?

--=20
balbi

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrqQ9AAoJEIaOsuA1yqREedQP/iLj9oygOqfgRgHxZJoMeqE6
xbjapfgwS+qHE/mylQd/IKF/qG0AhalKkeBGnr9KPRxyxZs6IF95K5hguTxx7bZg
t11tZkewsgv1Pk06Yluw40Gpxsg4tbGrHID2mYql0k/JzvbYDJlU1jHzfPjMtEy5
MQ7WuiCkbyg+XAJtInpw1TjD65oEdeRV3aQOY1C3utBkMNrzyvyaPjnnBsLtctH1
6fYocBWOQ18/bzrVnq+bLq5ekcnY30JuF+S+6Fx5YdmOGCtjb2wDfaXxpboL27Ig
M5l9NiktuVj5sY2kOiNPppkY5yhe3u8WcPzbxId51NkFWXath2vd1dFfdMT5+egK
Iide0sFiMvY9Yatvy6qK839WGK4hc9EVsIgpjV9I31idlvUKRCE6W81xcA+evt0A
tX0sSEcHkWxie34WwbHDCnlfW6OnL/FnsN6lVNS9se3ZIDuSAbtL3s6yLiDo0P9w
WLdGYQhRg4AnnksgiRocDkHyH9e71cY88L/vkhPDtCVi0nfLAqMaK866Xi4OorQT
wDkcLXVBz6dcx6n/0xPj+jeOPWLPVe+FTJ6f03r+qawFR0BwskKriZ9NJ1LUCDAs
AI6fnsxs/z2ERieLmXiwIJDOqoMdUtyIjuuNKnaZ2rlo4K176dw8/EI1Q6FROok+
nvpAHJPkkJkcbhorMAyR
=QDLo
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--
