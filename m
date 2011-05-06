From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2 4/4] mmc_spi.c: add support for the regulator
 framework
Date: Fri, 6 May 2011 16:30:15 +0200
Message-ID: <20110506163015.1bfae0af.ospite@studenti.unina.it>
References: <20110421124041.GF11788@opensource.wolfsonmicro.com>
	<1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__6_May_2011_16_30_15_+0200_m/.GQcdMZmwBihMP"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:38788 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab1EFOaT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 10:30:19 -0400
In-Reply-To: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

--Signature=_Fri__6_May_2011_16_30_15_+0200_m/.GQcdMZmwBihMP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Apr 2011 14:43:11 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:

> Add support for powering up SD cards driven by regulators.
> This makes the mmc_spi driver work also with the Motorola A910 phone.
>=20
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> ---
>=20
> Changes since v1:
>   - Remove the ifdef CONFIG_REGULATOR as regulator_get() degenerates to=20
>     a stub as well when the regulator framework is disabled.
>   - Release the regulator in mmc_spi_remove()
>

Ping.

> Thanks,
>    Antonio
>=20
>  drivers/mmc/host/mmc_spi.c |   63 +++++++++++++++++++++++++++++++++++---=
-----
>  1 files changed, 51 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 0f3672d..62b3b02 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -31,6 +31,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/crc7.h>
>  #include <linux/crc-itu-t.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/scatterlist.h>
> =20
>  #include <linux/mmc/host.h>
> @@ -150,11 +151,13 @@ struct mmc_spi_host {
>  	 */
>  	void			*ones;
>  	dma_addr_t		ones_dma;
> +
> +	struct regulator	*vcc;
>  };
> =20
>  static inline int mmc_spi_canpower(struct mmc_spi_host *host)
>  {
> -	return host->pdata && host->pdata->setpower;
> +	return (host->pdata && host->pdata->setpower) || host->vcc;
>  }
> =20
>  /***********************************************************************=
*****/
> @@ -1225,17 +1228,35 @@ static inline int mmc_spi_setpower(struct mmc_spi=
_host *host,
>  					unsigned char power_mode,
>  					unsigned int vdd)
>  {
> +	if (!mmc_spi_canpower(host))
> +		return -ENOSYS;
> +
>  	/* switch power on/off if possible, accounting for
>  	 * max 250msec powerup time if needed.
>  	 */
> -	if (mmc_spi_canpower(host)) {
> -		switch (power_mode) {
> -		case MMC_POWER_OFF:
> -		case MMC_POWER_UP:
> +	switch (power_mode) {
> +	case MMC_POWER_OFF:
> +		if (host->vcc) {
> +			int ret =3D mmc_regulator_set_ocr(host->mmc,
> +							host->vcc, 0);
> +			if (ret)
> +				return ret;
> +		} else {
> +			host->pdata->setpower(&host->spi->dev, vdd);
> +		}
> +		break;
> +
> +	case MMC_POWER_UP:
> +		if (host->vcc) {
> +			int ret =3D mmc_regulator_set_ocr(host->mmc,
> +							host->vcc, vdd);
> +			if (ret)
> +				return ret;
> +		} else {
>  			host->pdata->setpower(&host->spi->dev, vdd);
> -			if (power_mode =3D=3D MMC_POWER_UP)
> -				msleep(host->powerup_msecs);
>  		}
> +		msleep(host->powerup_msecs);
> +		break;
>  	}
> =20
>  	return 0;
> @@ -1420,12 +1441,27 @@ static int mmc_spi_probe(struct spi_device *spi)
>  	 * and power switching gpios.
>  	 */
>  	host->pdata =3D mmc_spi_get_pdata(spi);
> -	if (host->pdata)
> -		mmc->ocr_avail =3D host->pdata->ocr_mask;
> -	if (!mmc->ocr_avail) {
> -		dev_warn(&spi->dev, "ASSUMING 3.2-3.4 V slot power\n");
> -		mmc->ocr_avail =3D MMC_VDD_32_33|MMC_VDD_33_34;
> +
> +	host->vcc =3D regulator_get(mmc_dev(host->mmc), "vmmc");
> +	if (IS_ERR(host->vcc)) {
> +		host->vcc =3D NULL;
> +	} else {
> +		host->mmc->ocr_avail =3D mmc_regulator_get_ocrmask(host->vcc);
> +		if (host->pdata && host->pdata->ocr_mask)
> +			dev_warn(mmc_dev(host->mmc),
> +				"ocr_mask/setpower will not be used\n");
>  	}
> +
> +	if (host->vcc =3D=3D NULL) {
> +		/* fall-back to platform data */
> +		if (host->pdata)
> +			mmc->ocr_avail =3D host->pdata->ocr_mask;
> +		if (!mmc->ocr_avail) {
> +			dev_warn(&spi->dev, "ASSUMING 3.2-3.4 V slot power\n");
> +			mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> +		}
> +	}
> +
>  	if (mmc_spi_canpower(host)) {
>  		host->powerup_msecs =3D host->pdata->powerup_msecs;
>  		if (!host->powerup_msecs || host->powerup_msecs > 250)
> @@ -1523,6 +1559,9 @@ static int __devexit mmc_spi_remove(struct spi_devi=
ce *spi)
>  		if (host->pdata && host->pdata->exit)
>  			host->pdata->exit(&spi->dev, mmc);
> =20
> +		if (host->vcc)
> +			regulator_put(host->vcc);
> +
>  		mmc_remove_host(mmc);
> =20
>  		if (host->dma_dev) {
> --=20
> 1.7.4.4
>=20
>=20


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__6_May_2011_16_30_15_+0200_m/.GQcdMZmwBihMP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3EBfcACgkQ5xr2akVTsAFo8QCgshxkQldNeOsugOdIFsHtd0UJ
a2UAoIq40tl++ag+srFWnnTOObq5gIFj
=4sG+
-----END PGP SIGNATURE-----

--Signature=_Fri__6_May_2011_16_30_15_+0200_m/.GQcdMZmwBihMP--
