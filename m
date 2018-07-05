From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
Date: Thu, 5 Jul 2018 02:52:23 +0000
Message-ID: <AM0PR04MB42119E8C29A48E9CDA0F116F80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628081331.13051-2-stefan@agner.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Bough Chen <haibo.chen@nxp.com>, "michael@amarulasolutions.com" <michael@amarulasolutions.com>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Thursday, June 28, 2018 4:13 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> michael@amarulasolutions.com; rmk+kernel@armlinux.org.uk; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
>=20
> The field support_vsel is currently only used in the device tree case. Ge=
t rid
> of it. No change in behavior.
>=20

I'm not sure if it's quite necessary to remove it as it's used to bypass
100Mhz above pad settings look up which is meaningless if user claims
no 1-8 v support.

If you remove it, probably you still need better check the quirk for
Pad state look up.

Regards
Dong Aisheng

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
>  include/linux/platform_data/mmc-esdhc-imx.h | 2 --
>  2 files changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index 6f444731754d..20a420b765b3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct
> platform_device *pdev,
>  			     &boarddata->tuning_start_tap);
>=20
>  	if (of_find_property(np, "no-1-8-v", NULL))
> -		boarddata->support_vsel =3D false;
> -	else
> -		boarddata->support_vsel =3D true;
> +		host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
>=20
>  	if (of_property_read_u32(np, "fsl,delay-line", &boarddata-
> >delay_line))
>  		boarddata->delay_line =3D 0;
>=20
>  	mmc_of_parse_voltage(np, &host->ocr_mask);
>=20
> -	/* sdr50 and sdr104 need work on 1.8v signal voltage */
> -	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
> -	    !IS_ERR(imx_data->pins_default)) {
> +	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default))
> {
>  		imx_data->pins_100mhz =3D pinctrl_lookup_state(imx_data-
> >pinctrl,
>=20
> 	ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz =3D pinctrl_lookup_state(imx_data-
> >pinctrl,
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h
> b/include/linux/platform_data/mmc-esdhc-imx.h
> index 7daa78a2f342..640dec8b5b0c 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -34,7 +34,6 @@ enum cd_types {
>   * @cd_gpio:	gpio for card_detect interrupt
>   * @wp_type:	type of write_protect method (see wp_types enum above)
>   * @cd_type:	type of card_detect method (see cd_types enum above)
> - * @support_vsel:  indicate it supports 1.8v switching
>   */
>=20
>  struct esdhc_platform_data {
> @@ -43,7 +42,6 @@ struct esdhc_platform_data {
>  	enum wp_types wp_type;
>  	enum cd_types cd_type;
>  	int max_bus_width;
> -	bool support_vsel;
>  	unsigned int delay_line;
>  	unsigned int tuning_step;       /* The delay cell steps in tuning
> procedure */
>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning
> procedure */
> --
> 2.18.0
