From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
Date: Thu, 12 Jul 2018 08:45:25 +0000
Message-ID: <AM0PR04MB4211E2E422D988E6F4775FA280590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180712080725.14250-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712080725.14250-1-stefan@agner.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Bough Chen <haibo.chen@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Thursday, July 12, 2018 4:07 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
> changing frequency
>=20
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency is =
set to 0.
> However, it could be that the stack asks for a frequency change while clo=
cks
> are on. In that case the function clears the divider registers (by cleari=
ng
> ESDHC_CLOCK_MASK) while the clock is enabled! This causes a short period
> of time where the clock is undivided (on a i.MX 6DL a clock of 196MHz has
> been measured).
>=20
> For older IP variants the driver disables clock by clearing some bits in
> ESDHC_SYSTEM_CONTROL.
>=20
> Make sure to disable card clock before changing frequency for uSDHC IP
> variants too.

Looks ok to me.
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
> esdhc-imx.c
> index 85fd5a8b0b6d..acacd8481473 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct
> sdhci_host *host,
>  	int div =3D 1;
>  	u32 temp, val;
>=20
> +	if (esdhc_is_usdhc(imx_data)) {
> +		val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +			host->ioaddr + ESDHC_VENDOR_SPEC);
> +	}
> +
>  	if (clock =3D=3D 0) {
>  		host->mmc->actual_clock =3D 0;
> -
> -		if (esdhc_is_usdhc(imx_data)) {
> -			val =3D readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -			writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -					host->ioaddr +
> ESDHC_VENDOR_SPEC);
> -		}
>  		return;
>  	}
>=20
> --
> 2.18.0
