From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Mon, 23 May 2011 17:10:23 +0200
Message-ID: <20110523171023.4df5af10.ospite@studenti.unina.it>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
	<1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
	<20110511130852.GB12469@opensource.wolfsonmicro.com>
	<20110511225337.094839a2.ospite@studenti.unina.it>
	<20110511205703.GA24486@opensource.wolfsonmicro.com>
	<20110518192320.9dd69cb5.ospite@studenti.unina.it>
	<20110518194211.GA5077@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__23_May_2011_17_10_23_+0200_AK/kWK4jt/MY+bYl"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:39857 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab1EWPKi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 May 2011 11:10:38 -0400
In-Reply-To: <20110518194211.GA5077@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

--Signature=_Mon__23_May_2011_17_10_23_+0200_AK/kWK4jt/MY+bYl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 18 May 2011 12:42:12 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, May 18, 2011 at 07:23:20PM +0200, Antonio Ospite wrote:
>=20
[...]
> >   2. Add a proper function with all the needed parameters to abstract
> >      the actual var names, this would be something like:
> >      mmc_regulator_set_power(mmc, power_mode, vdd, vcc, pdata)
> >      and yet checking for pdata->setpower can be tricky as 'setpower'=20
> >      is an arbitrary name.
>=20
> This would be good.

A WIP patch, I don't have a lot of time to spend on this, I tried to
handle the driver specific 'setpower' callback with a macro, let me
know if you have a better idea:

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..dbbe535 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -298,6 +298,32 @@ static inline int mmc_regulator_set_ocr(struct mmc_hos=
t *mmc,
 }
 #endif
=20
+#define STRUCT_FIELD(s, f) ((s) && (s)->f ? (s)->f : NULL )
+
+static inline int mmc_regulator_set_power(struct mmc_host *mmc,
+				 unsigned char	power_mode,
+				 struct regulator *supply,
+				 unsigned short vdd_bit,
+				 struct device *device,
+				 void (*setpower_cb)(struct device *, unsigned int))
+{
+	if (supply) {
+		int ret;
+
+		if (power_mode =3D=3D MMC_POWER_OFF)
+			vdd_bit =3D 0;
+
+		ret =3D mmc_regulator_set_ocr(mmc, supply, vdd_bit);
+		if (ret)
+			return ret;
+	} else {
+		if (setpower_cb)
+			setpower_cb(device, vdd_bit);
+	}
+
+	return 0;
+}
+
 int mmc_card_awake(struct mmc_host *host);
 int mmc_card_sleep(struct mmc_host *host);
 int mmc_card_can_sleep(struct mmc_host *host);
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 2e8db20..c9a229f 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1231,21 +1231,18 @@ static inline int mmc_spi_setpower(struct mmc_spi_h=
ost *host,
 					unsigned char power_mode,
 					unsigned int vdd)
 {
+	int ret;
+
 	if (!mmc_spi_canpower(host))
 		return -ENOSYS;
=20
-	if (host->vcc) {
-		int ret;
=20
-		if (power_mode =3D=3D MMC_POWER_OFF)
-			vdd =3D 0;
+	ret =3D mmc_regulator_set_power(host->mmc, power_mode, host->vcc, vdd,
+				      &host->spi->dev,
+				      STRUCT_FIELD(host->pdata, setpower));
+	if (ret)
+		return ret;
=20
-		ret =3D mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-		if (ret)
-			return ret;
-	} else {
-		host->pdata->setpower(&host->spi->dev, vdd);
-	}
=20
 	if (power_mode =3D=3D MMC_POWER_UP)
 		msleep(host->powerup_msecs);
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index fbdb21e..f5d9529 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -103,29 +103,20 @@ static inline int pxamci_set_power(struct pxamci_host=
 *host,
 				    unsigned int vdd)
 {
 	int on;
+	int ret;
=20
-	if (host->vcc) {
-		int ret;
+	ret =3D mmc_regulator_set_power(host->mmc, power_mode, host->vcc, vdd,
+				      mmc_dev(host->mmc),
+				      STRUCT_FIELD(host->pdata, setpower));
+	if (ret)
+		return ret;
=20
-		if (power_mode =3D=3D MMC_POWER_UP) {
-			ret =3D mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-			if (ret)
-				return ret;
-		} else if (power_mode =3D=3D MMC_POWER_OFF) {
-			ret =3D mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
-			if (ret)
-				return ret;
-		}
-	}
 	if (!host->vcc && host->pdata &&
 	    gpio_is_valid(host->pdata->gpio_power)) {
 		on =3D ((1 << vdd) & host->pdata->ocr_mask);
 		gpio_set_value(host->pdata->gpio_power,
 			       !!on ^ host->pdata->gpio_power_invert);
 	}
-	if (!host->vcc && host->pdata && host->pdata->setpower)
-		host->pdata->setpower(mmc_dev(host->mmc), vdd);
-
 	return 0;
 }
=20


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__23_May_2011_17_10_23_+0200_AK/kWK4jt/MY+bYl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3aeN8ACgkQ5xr2akVTsAEihACgqtXgC5lyBP5yEEJKNl5QuqJ3
aW0An2dqpxPCCXZ0NSyrPpof/t4c90ic
=bS6a
-----END PGP SIGNATURE-----

--Signature=_Mon__23_May_2011_17_10_23_+0200_AK/kWK4jt/MY+bYl--
