From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
Date: Tue, 04 Jun 2013 13:06:39 +0900
Message-ID: <51AD67CF.60300@samsung.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030059.03783.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <201306030059.03783.heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

On 06/03/2013 07:59 AM, Heiko St=FCbner wrote:
> Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_mm=
c
> controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> always be set.
>=20
> There also seem to be no other modifications (additional register etc=
)
> present, so to keep the footprint low, add this small variant to the
> pltfm driver.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |   48 +++++++++++++++++++++++++++--=
---------
>  1 files changed, 34 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mm=
c-pltfm.c
> index 0048da8..7d041b5 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -24,6 +24,16 @@
> =20
>  #include "dw_mmc.h"
> =20
> +
> +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32=
 *cmdr)
How about using "dw_mci_pltfm_prepare_command()"?
Maybe HOLD_REG could be used at other SoC.
> +{
> +	*cmdr |=3D SDMMC_CMD_USE_HOLD_REG;
> +}
> +
> +static const struct dw_mci_drv_data rockchip_drv_data =3D {
> +	.prepare_command	=3D dw_mci_rockchip_prepare_command,
> +};
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>  				const struct dw_mci_drv_data *drv_data)
>  {
> @@ -63,20 +73,6 @@ int dw_mci_pltfm_register(struct platform_device *=
pdev,
>  }
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
> =20
> -static int dw_mci_pltfm_probe(struct platform_device *pdev)
> -{
> -	return dw_mci_pltfm_register(pdev, NULL);
> -}
> -
> -int dw_mci_pltfm_remove(struct platform_device *pdev)
> -{
> -	struct dw_mci *host =3D platform_get_drvdata(pdev);
> -
> -	dw_mci_remove(host);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
> -
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * TODO: we should probably disable the clock to the card in the sus=
pend path.
> @@ -114,10 +110,34 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> =20
>  static const struct of_device_id dw_mci_pltfm_match[] =3D {
>  	{ .compatible =3D "snps,dw-mshc", },
> +	{ .compatible =3D "rockchip,cortex-a9-dw-mshc",
> +		.data =3D &rockchip_drv_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> =20
> +static int dw_mci_pltfm_probe(struct platform_device *pdev)
> +{
> +	const struct dw_mci_drv_data *drv_data =3D NULL;
> +	const struct of_device_id *match;
> +
> +	if (pdev->dev.of_node) {
> +		match =3D of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> +		drv_data =3D match->data;
> +	}
> +
> +	return dw_mci_pltfm_register(pdev, drv_data);
> +}
> +
> +int dw_mci_pltfm_remove(struct platform_device *pdev)
> +{
> +	struct dw_mci *host =3D platform_get_drvdata(pdev);
> +
> +	dw_mci_remove(host);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
> +
>  static struct platform_driver dw_mci_pltfm_driver =3D {
>  	.probe		=3D dw_mci_pltfm_probe,
>  	.remove		=3D dw_mci_pltfm_remove,
>=20
