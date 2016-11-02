From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH] sdhci-esdhc-imx: fix bus-width for 1-bit operation.
Date: Wed, 2 Nov 2016 04:27:36 +0000
Message-ID: <AM4PR0401MB232475B15D7D9ED6B78A5E5E90A00@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1478015905-31262-1-git-send-email-leogveiga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0087.outbound.protection.outlook.com ([104.47.2.87]:28305
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753137AbcKBQBf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 12:01:35 -0400
In-Reply-To: <1478015905-31262-1-git-send-email-leogveiga@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Leonardo G. Veiga" <leogveiga@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "A.S. Dong" <aisheng.dong@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, "raul.munoz@toradex.com" <raul.munoz@toradex.com>, "leonardo.veiga@toradex.com" <leonardo.veiga@toradex.com>

+Aisheng.

Best Regards
Haibo Chen

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Leonardo G. Veiga
> Sent: Tuesday, November 01, 2016 11:58 PM
> To: ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> stefan@agner.ch; raul.munoz@toradex.com; leonardo.veiga@toradex.com
> Subject: [PATCH] sdhci-esdhc-imx: fix bus-width for 1-bit operation.
>=20
> From: Leonardo Graboski Veiga <leonardo.veiga@toradex.com>
>=20
> The 1-bit operation mode, enabled by seeting the 'bus-width' property of =
the
> device tree 'esdhc' node to <1>, not work while using SD card.
>=20
> The behavior is only noticed when only the data pin 0 is connected to the
> hardware. A series of kernel errors are printed to the console, all of th=
em
> returning the following error message followed by some explanation:
> mmcblk0: error -84 transferring data
>=20
> If four data lines are connected, it ignores the device-tree property and=
 works
> in 4-bit mode of operation without errors. The hardware used for testing =
does
> not support 8-bit mode.
>=20
> Check the 'bus-width' property and if set to <1>, enable the
> SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.
>=20
> Signed-off-by: Leonardo Graboski Veiga <leonardo.veiga@toradex.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index c9fbc4c3..88d7d22 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1003,6 +1003,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device
> *pdev,
>  		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
>  	}
>=20
> +	if (!of_property_read_u32(np, "bus-width", &boarddata-
> >max_bus_width)
> +		&& boarddata->max_bus_width =3D=3D 1)
> +		host->quirks |=3D SDHCI_QUIRK_FORCE_1_BIT_DATA;
> +
>  	/* call to generic mmc_of_parse to support additional capabilities */
>  	ret =3D mmc_of_parse(host->mmc);
>  	if (ret)
> --
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
