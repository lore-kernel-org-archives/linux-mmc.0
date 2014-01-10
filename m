From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 1/7] mmc: omap_hsmmc: use devm_regulator API
Date: Fri, 10 Jan 2014 09:58:02 -0600
Message-ID: <20140110155802.GF6665@saruman.home>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389279062-32291-2-git-send-email-balajitk@ti.com>
 <20140109151844.GB2417@saruman.home>
 <52D017E8.7000308@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39928 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbaAJP7P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jan 2014 10:59:15 -0500
Content-Disposition: inline
In-Reply-To: <52D017E8.7000308@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com, mark.rutland@arm.com

--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Fri, Jan 10, 2014 at 09:25:20PM +0530, Balaji T K wrote:
> On Thursday 09 January 2014 08:48 PM, Felipe Balbi wrote:
> >Hi,
> >
> >On Thu, Jan 09, 2014 at 08:20:56PM +0530, Balaji T K wrote:
> >>Use devm_regulator API, while at it use
> >>devm_regulator_get_optional for optional vmmc_aux supply
> >>
> >>Signed-off-by: Balaji T K <balajitk@ti.com>
> >>Acked-by: Tony Lindgren <tony@atomide.com>
> >>---
> >>  drivers/mmc/host/omap_hsmmc.c |    6 ++----
> >>  1 files changed, 2 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
> >>index dbd32ad..1eb4350 100644
> >>--- a/drivers/mmc/host/omap_hsmmc.c
> >>+++ b/drivers/mmc/host/omap_hsmmc.c
> >>@@ -316,7 +316,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_hos=
t *host)
> >>  	struct regulator *reg;
> >>  	int ocr_value =3D 0;
> >>
> >>-	reg =3D regulator_get(host->dev, "vmmc");
> >>+	reg =3D devm_regulator_get(host->dev, "vmmc");
> >>  	if (IS_ERR(reg)) {
> >>  		dev_err(host->dev, "vmmc regulator missing\n");
> >>  		return PTR_ERR(reg);
> >>@@ -336,7 +336,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_hos=
t *host)
> >>  		}
> >>
> >>  		/* Allow an aux regulator */
> >>-		reg =3D regulator_get(host->dev, "vmmc_aux");
> >>+		reg =3D devm_regulator_get_optional(host->dev, "vmmc_aux");
> >>  		host->vcc_aux =3D IS_ERR(reg) ? NULL : reg;
> >>
> >>  		/* For eMMC do not power off when not in sleep state */
> >>@@ -366,8 +366,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_hos=
t *host)
> >>
> >>  static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
> >
> >since this function does nothing now, you could pretty much remove it
> >and move set_power assignment to ->remove() directly. No strong feelings
> >though.
> >
> Hi Felipe,
>=20
> omap_hsmmc_reg_put is used in probe error handling path in addition to .r=
emove(),
> so I would keep it for now to balance omap_hsmmc_reg_get.

right, but it does nothing but setting set_power to NULL ;-)

--=20
balbi

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIbBAEBAgAGBQJS0BiKAAoJEIaOsuA1yqREqXgP91XDLMGCRn0oYrxyDaIqF4Du
duubMXZ/fZRdSYqNJNtg0FPd7uKM3M4EJiUt9z0QJI55wLq/oNgInbBhVWvnNSie
9T9T2rEl/SzFwYyLzW8maHO0A+RIzUzmkHtnwqsu9CjWJAbIDfplrTvMuwSvyQq9
cpbpUrdzy/L0FuxQsXaelF2KhMkU0KGnKK/JOVwD3532hX8ALTaMGO+b0VGsCPPR
x1nM/ey766HUE6u6pOj9NiXQdcIgwUs3P9zXj7LzpT09mXlefkzy15RphRSjL2fO
NyDS+irsBigEUYO6UduP0ziNr8H5kcHEdQCPtPXz6K5ig3DPVHOppcjwt4h2LRD0
MIsWDsF/OalyWnkUR5r+na5tOcP5GT5pgLe9OWeGxO8a6/JhwFA7pFxwtBfDkUHZ
g7uQ4ToOUsX94gi5bmcBlyIozuBckBTg0lyJdXcrl13OVMScK46zUOodj4ikvFWI
rGK66hTxlRASmCRWV49H4saGxfmz2sVppQvznIZp+TIPH58p6vvHqGOQfJMlSTPq
ApeEaiiGJz8JtPdeygt9TFpYzLKFu9a0i1tgyi6yNpSQYfqmfn6Nlr9RhuB59FBJ
/iZLFi5yrmAJPn7LVwOzXoIY5lLRa9COG5Ndo1TlnabozOgw+JQ4zywD5sobGSr3
woY1ygcahoBacXtc3sU=
=y67j
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
