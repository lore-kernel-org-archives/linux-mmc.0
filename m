From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Mon, 14 Sep 2015 08:07:51 -0700
Message-ID: <20150914150751.GI19678@xsjsorenbubuntu>
References: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0065.outbound.protection.outlook.com ([157.56.111.65]:3104
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751127AbbINPID (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 11:08:03 -0400
Content-Disposition: inline
In-Reply-To: <1442212161-23234-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

Hi Shawn,

overall, it looks good to me. I have some questions though.

On Mon, 2015-09-14 at 02:29PM +0800, Shawn Lin wrote:
> This patch adds Generic PHY access for sdhci-of-arasan. Driver
> can get PHY handler from dt-binding, and power-on/init the PHY.
> Also we add pm ops for PHY here if CONFIG_PM_SLEEP is enabled.
> Currently, it's just mandatory for arasan,sdhci-5.1.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
> Serise-changes: 2
> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
>=20
> ---
>=20
> Changes in v2: None
>=20
>  drivers/mmc/host/sdhci-of-arasan.c | 97 ++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 97 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sd=
hci-of-arasan.c
> index 75379cb..2c13ef8 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -21,6 +21,7 @@
> =20
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/phy/phy.h>
>  #include "sdhci-pltfm.h"
> =20
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> @@ -35,6 +36,7 @@
>   */
>  struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
> +	struct phy	*phy;
>  };
> =20
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host=
 *host)
> @@ -70,6 +72,62 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata =
=3D {
> =20
>  #ifdef CONFIG_PM_SLEEP
>  /**
> +  * sdhci_arasan_suspend_phy - Suspend phy method for the driver
> +  * @phy:        Handler of phy structure
> +  * Returns 0 on success and error value on error
> +  *
> +  * Put the phy in a deactive state.
> +  */
> +static int sdhci_arasan_suspend_phy(struct phy *phy)
> +{
> +	int ret;
> +
> +	ret =3D phy_exit(phy);
> +	if (ret < 0)
> +		goto err_phy_exit;
> +
> +	ret =3D phy_power_off(phy);
> +	if (ret < 0)
> +		goto err_phy_pwr_off;
> +
> +	return 0;
> +
> +err_phy_pwr_off:
> +	phy_power_on(phy);
> +err_phy_exit:
> +	phy_init(phy);

Just to confirm, are these actions in the error path correct? E.g.
if the power_off() call fails, is it safe to call power_on()? Isn't
the phy still powered on? (this would apply to other error paths too)

> +	return ret;
> +}
> +
> +/**
> +  * sdhci_arasan_resume_phy - Resume phy method for the driver
> +  * @phy:        Handler of phy structure
> +  * Returns 0 on success and error value on error
> +  *
> +  * Put the phy in a active state.
> +  */
> +static int sdhci_arasan_resume_phy(struct phy *phy)
> +{
> +	int ret;
> +
> +	ret =3D phy_power_on(phy);
> +	if (ret < 0)
> +		goto err_phy_pwr_on;
> +
> +	ret =3D phy_init(phy);
> +	if (ret < 0)
> +		goto err_phy_init;
> +
> +	return 0;
> +
> +err_phy_init:
> +	phy_exit(phy);
> +err_phy_pwr_on:
> +	phy_power_off(phy);
> +	return ret;
> +}
> +
> +/**
>   * sdhci_arasan_suspend - Suspend method for the driver
>   * @dev:	Address of the device structure
>   * Returns 0 on success and error value on error
> @@ -91,6 +149,12 @@ static int sdhci_arasan_suspend(struct device *de=
v)
>  	clk_disable(pltfm_host->clk);
>  	clk_disable(sdhci_arasan->clk_ahb);
> =20
> +	if (sdhci_arasan->phy) {
> +		ret =3D sdhci_arasan_suspend_phy(sdhci_arasan->phy);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -122,6 +186,12 @@ static int sdhci_arasan_resume(struct device *de=
v)
>  		return ret;
>  	}
> =20
> +	if (sdhci_arasan->phy) {
> +		ret =3D sdhci_arasan_resume_phy(sdhci_arasan->phy);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return sdhci_resume_host(host);
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
> @@ -166,6 +236,33 @@ static int sdhci_arasan_probe(struct platform_de=
vice *pdev)
>  		goto clk_dis_ahb;
>  	}
> =20
> +	sdhci_arasan->phy =3D NULL;
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "arasan,sdhci-5.1")) {
> +		sdhci_arasan->phy =3D devm_phy_get(&pdev->dev,
> +						 "phy_arasan");
> +		if (IS_ERR(sdhci_arasan->phy)) {
> +			ret =3D -ENODEV;
> +			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
> +			goto clk_dis_ahb;
> +		}
> +
> +		ret =3D phy_power_on(sdhci_arasan->phy);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "phy_power_on err.\n");
> +			phy_power_off(sdhci_arasan->phy);
> +			goto clk_dis_ahb;
> +		}
> +
> +		ret =3D phy_init(sdhci_arasan->phy);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "phy_init err.\n");
> +			phy_exit(sdhci_arasan->phy);
> +			phy_power_off(sdhci_arasan->phy);
> +			goto clk_dis_ahb;
> +		}
> +	}

I assume you looked at options for having the error paths in a
consolidated location? I guess this may be the nicest solution since al=
l
of this is in this conditional block?

=46eel free to add my
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>

	S=C3=B6ren
