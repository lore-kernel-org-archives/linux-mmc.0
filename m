From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 4/7] mmc: dw_mmc-pltfm: add Rockchip variant
Date: Wed, 12 Jun 2013 10:22:00 +0900
Message-ID: <000a01ce670b$3cf651c0$b6e2f540$%jun@samsung.com>
References: <201306111328.52679.heiko@sntech.de>
 <201306111330.56901.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:65276 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab3FLBWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 21:22:02 -0400
In-reply-to: <201306111330.56901.heiko@sntech.de>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <rob.herring@calxeda.com>, 'Linus Walleij' <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, 'Russell King' <linux@arm.linux.org.uk>, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>, 'Andy Shevchenko' <andy.shevchenko@gmail.com>

Looks good to me.
But this patch has a dependency on '[PATCH 2/2] mmc: dw_mmc: Add suppor=
t DW SD/MMC driver on SOCFPGA'
After that, it can be applied.(SDMMC_CMD_USE_HOLD_REG should be moved i=
n dw_mmc.h)

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

On 06/11/13 2013 8:31 PM Heiko St=C3=BCbner wrote:
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
>  drivers/mmc/host/dw_mmc-pltfm.c |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mm=
c-pltfm.c
> index 9b05381..cbbbcf3 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -24,6 +24,15 @@
>=20
>  #include "dw_mmc.h"
>=20
> +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32=
 *cmdr)
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
> @@ -100,13 +109,23 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>=20
>  static const struct of_device_id dw_mci_pltfm_match[] =3D {
>  	{ .compatible =3D "snps,dw-mshc", },
> +	{ .compatible =3D "rockchip,cortex-a9-dw-mshc",
> +		.data =3D &rockchip_drv_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
>=20
>  static int dw_mci_pltfm_probe(struct platform_device *pdev)
>  {
> -	return dw_mci_pltfm_register(pdev, NULL);
> +	const struct dw_mci_drv_data *drv_data =3D NULL;
> +	const struct of_device_id *match;
> +
> +	if (pdev->dev.of_node) {
> +		match =3D of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> +		drv_data =3D match->data;
> +	}
> +
> +	return dw_mci_pltfm_register(pdev, drv_data);
>  }
>=20
>  int dw_mci_pltfm_remove(struct platform_device *pdev)
> --
> 1.7.2.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

