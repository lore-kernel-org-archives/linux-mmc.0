From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Update driver to support without
 regulators
Date: Tue, 21 Jul 2015 15:14:15 -0500
Message-ID: <20150721201415.GO25385@saruman.tx.rr.com>
References: <1436902186-6542-1-git-send-email-fcooper@ti.com>
 <20150721195749.GM25385@saruman.tx.rr.com>
 <55AEA769.9080300@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c2gYorpyS4gG0T74"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34863 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbGUUOR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jul 2015 16:14:17 -0400
Content-Disposition: inline
In-Reply-To: <55AEA769.9080300@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rogerq@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>

--c2gYorpyS4gG0T74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2015 at 03:11:21PM -0500, Franklin S Cooper Jr. wrote:
>=20
>=20
> On 07/21/2015 02:57 PM, Felipe Balbi wrote:
> > On Tue, Jul 14, 2015 at 02:29:46PM -0500, Franklin S Cooper Jr wrote:
> >> From: Roger Quadros <rogerq@ti.com>
> >>
> >> Update driver to support without regulators.
> >>
> >> Without this patch boards that do not enable regulator config options =
will
> >> fail to boot with a kernel panic.
> >>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> >> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> >> ---
> >>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  2 ++
> >>  drivers/mmc/host/omap_hsmmc.c                           | 14 ++++++++=
++----
> >>  2 files changed, 12 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b=
/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> >> index 76bf087..2408e87 100644
> >> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> >> @@ -22,6 +22,8 @@ ti,dual-volt: boolean, supports dual voltage cards
> >>  ti,non-removable: non-removable slot (like eMMC)
> >>  ti,needs-special-reset: Requires a special softreset sequence
> >>  ti,needs-special-hs-handling: HSMMC IP needs special setting for hand=
ling High Speed
> >> +voltage-ranges: Specify the voltage range supported if regulator fram=
ework
> >> +isn't enabled.
> >>  dmas: List of DMA specifiers with the controller specific format
> >>  as described in the generic DMA client binding. A tx and rx
> >>  specifier is required.
> >> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsm=
mc.c
> >> index b2b411d..16c870f 100644
> >> --- a/drivers/mmc/host/omap_hsmmc.c
> >> +++ b/drivers/mmc/host/omap_hsmmc.c
> >> @@ -1551,10 +1551,13 @@ static void omap_hsmmc_set_ios(struct mmc_host=
 *mmc, struct mmc_ios *ios)
> >>  	if (ios->power_mode !=3D host->power_mode) {
> >>  		switch (ios->power_mode) {
> >>  		case MMC_POWER_OFF:
> >> -			mmc_pdata(host)->set_power(host->dev, 0, 0);
> >> +			if (host->use_reg)
> >> +				mmc_pdata(host)->set_power(host->dev, 0, 0);
> > looks like this driver should just be use regulator_get_optional(), then
> > ->set_power() would still work, no ?
> Wouldn't there still be a dependency on the regulator framework to get
> that to work?

I didn't look at the code, but I'd expect us to have a sensible stub on
!REGULATOR builds

--=20
balbi

--c2gYorpyS4gG0T74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrqgXAAoJEIaOsuA1yqREswgP/iuoDxTPlOsmI9z78TPEgFf9
mPyXev2WUe10Gq9TTdX3Bwdm/CIj4s25dUjqdQsuQ1VSKixjt6th1lMlZ9oHyxj1
2Z35jeBrHx6o35pCpUlUkcsAPwuQKUja1aLvcYkwDlH4+s7OsE3i+TiPHQJUgoGd
s20dtH6WiSCTx/B7Y8gIO3CBLSPPXWPwLV/C2VkkbHB2+hJXkvjkb6+6V3LZcVVi
T00RhZtvWd58dpi0bLBYOCrQGTOBShdIQFRu4km5wTagiwQgtdvClzuSiJH+5W5L
ebEKPidgM80Gj7raYURKquPYuG1Q2Tbm5Z6UOvIWQlNhoXnw4XxKlpM09W5fV918
gG+tFl6JYXY11YsKZlnPDRaYiunItSRWHef15yfH7gCgOZIpCKqWiR3wziyKFJeY
0n0PgPLtidNfr8MvX0JDJ4/CS4D5Zfd4BO7jCeAMc9W0WeiHT/UK3VrfBSTRU8fF
CtHUSGA3JksTcXfYRbdUAMMbo30Q9jZxVQP/kmC1SKwkAwQUArUg1AG6tvvza9+M
8+BRS1K8/2PKRdOe3oMP2hcxdzRfmKm1bAOYeGI3RmDuiBpAcOt3zBV193dnSVfV
uhsRLXYiGFr4BIb1qu+5zrvhx6/KdSqFBLCnXT4bOvYcW0UDsbiClXcfvkGek2zz
WdD0zOwBqFTP7gUy/QdT
=+o/0
-----END PGP SIGNATURE-----

--c2gYorpyS4gG0T74--
