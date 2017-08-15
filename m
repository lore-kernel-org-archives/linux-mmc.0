From: "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-of-esdhc: support ESDHC_CAPABILITIES_1
 accessing
Date: Tue, 15 Aug 2017 02:36:41 +0000
Message-ID: <DB6PR0401MB25361FDA0E9CF008A6D4E0E2F88D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1502763423-371-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:12843
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752960AbdHOCgp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 22:36:45 -0400
In-Reply-To: <1502763423-371-1-git-send-email-yangbo.lu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Y.b. Lu" <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

Oh... Sorry for missing 'v2' in title.


> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Tuesday, August 15, 2017 10:17 AM
> To: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Adrian Hunter
> Cc: Xiaobo Xie; Y.b. Lu
> Subject: [PATCH] mmc: sdhci-of-esdhc: support ESDHC_CAPABILITIES_1
> accessing
>=20
> eSDHC is not a standard SD host controller. SDHCI_CAPABILITIES_1 register
> address is 0x44 while it's 0x114 (ESDHC_CAPABILITIES_1) for eSDHC.
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> Changes for v2:
> 	- Removed duplicate perenthesis.
> 	- Added "Acked-by: Adrian Hunter".
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  3 +++
>  drivers/mmc/host/sdhci-of-esdhc.c | 23 +++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-
> esdhc.h index e7893f2..dfa58f8 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -54,6 +54,9 @@
>  #define ESDHC_CLOCK_HCKEN		0x00000002
>  #define ESDHC_CLOCK_IPGEN		0x00000001
>=20
> +/* Host Controller Capabilities Register 2 */
> +#define ESDHC_CAPABILITIES_1		0x114
> +
>  /* Tuning Block Control Register */
>  #define ESDHC_TBCTL			0x120
>  #define ESDHC_TB_EN			0x00000004
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index 44b016b..d96a057 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -86,6 +86,17 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  		return ret;
>  	}
>=20
> +	/*
> +	 * DTS properties of mmc host are used to enable each speed mode
> +	 * according to soc and board capability. So clean up
> +	 * SDR50/SDR104/DDR50 support bits here.
> +	 */
> +	if (spec_reg =3D=3D SDHCI_CAPABILITIES_1) {
> +		ret =3D value & ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
> +				SDHCI_SUPPORT_DDR50);
> +		return ret;
> +	}
> +
>  	ret =3D value;
>  	return ret;
>  }
> @@ -249,7 +260,11 @@ static u32 esdhc_be_readl(struct sdhci_host *host,
> int reg)
>  	u32 ret;
>  	u32 value;
>=20
> -	value =3D ioread32be(host->ioaddr + reg);
> +	if (reg =3D=3D SDHCI_CAPABILITIES_1)
> +		value =3D ioread32be(host->ioaddr + ESDHC_CAPABILITIES_1);
> +	else
> +		value =3D ioread32be(host->ioaddr + reg);
> +
>  	ret =3D esdhc_readl_fixup(host, reg, value);
>=20
>  	return ret;
> @@ -260,7 +275,11 @@ static u32 esdhc_le_readl(struct sdhci_host *host,
> int reg)
>  	u32 ret;
>  	u32 value;
>=20
> -	value =3D ioread32(host->ioaddr + reg);
> +	if (reg =3D=3D SDHCI_CAPABILITIES_1)
> +		value =3D ioread32(host->ioaddr + ESDHC_CAPABILITIES_1);
> +	else
> +		value =3D ioread32(host->ioaddr + reg);
> +
>  	ret =3D esdhc_readl_fixup(host, reg, value);
>=20
>  	return ret;
> --
> 2.1.0.27.g96db324

