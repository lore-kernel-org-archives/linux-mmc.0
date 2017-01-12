From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-of-esdhc: remove default broken-cd for ARM
Date: Thu, 12 Jan 2017 01:32:59 +0000
Message-ID: <DB6PR0401MB2536796A9CFABEC672358FACF8790@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1482745244-24114-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-he1eur01on0089.outbound.protection.outlook.com ([104.47.0.89]:2912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755099AbdALBdD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Jan 2017 20:33:03 -0500
In-Reply-To: <1482745244-24114-1-git-send-email-yangbo.lu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi Adrian and Uffe,

Any comments on this patch?
Thanks :)


Best regards,
Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Monday, December 26, 2016 5:41 PM
> To: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Adrian Hunter
> Cc: Y.B. Lu
> Subject: [PATCH] mmc: sdhci-of-esdhc: remove default broken-cd for ARM
>=20
> Initially all QorIQ platforms were PowerPC architecture and they didn't
> support card detection except several platforms. The driver added the
> quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION as default and this made broken-
> cd property in dts node didn't work. Now QorIQ platform turns to ARM
> architecture and most of them could support card detection. However it's
> a large number of dts trees that need to be fixed with broken-cd if we
> remove the default SDHCI_QUIRK_BROKEN_CARD_DETECTION in driver. And the
> users don't want to see this. So this patch is to remove this default
> quirk just for ARM and keep it for PowerPC.(Note, QorIQ PowerPC platform
> only has big-endian eSDHC while QorIQ ARM platform has big-endian or
> little-endian eSDHC) This makes broken-cd property work again for ARM.
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index 9a6eb44..364f6b8 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -569,16 +569,19 @@ static const struct sdhci_ops sdhci_esdhc_le_ops =
=3D
> {  };
>=20
>  static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata =3D {
> -	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> -		| SDHCI_QUIRK_NO_CARD_NO_RESET
> -		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks =3D ESDHC_DEFAULT_QUIRKS |
> +#ifdef CONFIG_PPC
> +		  SDHCI_QUIRK_BROKEN_CARD_DETECTION | #endif
> +		  SDHCI_QUIRK_NO_CARD_NO_RESET |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops =3D &sdhci_esdhc_be_ops,
>  };
>=20
>  static const struct sdhci_pltfm_data sdhci_esdhc_le_pdata =3D {
> -	.quirks =3D ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> -		| SDHCI_QUIRK_NO_CARD_NO_RESET
> -		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks =3D ESDHC_DEFAULT_QUIRKS |
> +		  SDHCI_QUIRK_NO_CARD_NO_RESET |
> +		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops =3D &sdhci_esdhc_le_ops,
>  };
>=20
> @@ -643,8 +646,7 @@ static int sdhci_esdhc_probe(struct platform_device
> *pdev)
>  	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
>  	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
>  	    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,t1040-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
> +	    of_device_is_compatible(np, "fsl,t1040-esdhc"))
>  		host->quirks &=3D ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>=20
>  	if (of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
> --
> 2.1.0.27.g96db324

