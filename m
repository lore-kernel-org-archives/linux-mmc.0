From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH] sdhci: arasan: Add runtime PM support
Date: Tue, 25 Sep 2018 05:18:03 +0000
Message-ID: <DM6PR02MB52271FEA75D6AF49A345FC9BC1160@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <MNARANI@xilinx.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, Michal Simek <michals@xilinx.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Ping!

> -----Original Message-----
> From: Manish Narani [mailto:manish.narani@xilinx.com]
> Sent: Tuesday, September 18, 2018 8:34 PM
> To: adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>;
> ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> kernel@vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH] sdhci: arasan: Add runtime PM support
>=20
> Add runtime PM support in Arasan SDHCI driver.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 80
> +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-=
of-
> arasan.c
> index a40bcc2..370ada5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> @@ -30,6 +31,7 @@
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
>=20
> +#define SDHCI_ARASAN_AUTOSUSPEND_DELAY	2000 /* ms */
>  #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
>  #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
>  #define VENDOR_ENHANCED_STROBE		BIT(0)
> @@ -363,6 +365,70 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_cqe_pdata =3D {
>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>=20
> +#ifdef CONFIG_PM
> +static int sdhci_arasan_runtime_suspend(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D
> sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (sdhci_arasan->has_cqe) {
> +		ret =3D cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return 0;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan =3D
> sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret =3D clk_enable(sdhci_arasan->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable AHB clock.\n");
> +		return ret;
> +	}
> +
> +	ret =3D clk_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SD clock.\n");
> +		return ret;
> +	}
> +
> +	ret =3D sdhci_runtime_resume_host(host);
> +	if (ret)
> +		goto out;
> +
> +	if (sdhci_arasan->has_cqe)
> +		return cqhci_resume(host->mmc);
> +
> +	return 0;
> +out:
> +	clk_disable(pltfm_host->clk);
> +	clk_disable(sdhci_arasan->clk_ahb);
> +
> +	return ret;
> +}
> +#endif /* ! CONFIG_PM */
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver @@ -455,8 +521,1=
0
> @@ static int sdhci_arasan_resume(struct device *dev)  }  #endif /* !
> CONFIG_PM_SLEEP */
>=20
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops,
> sdhci_arasan_suspend,
> -			 sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend,
> sdhci_arasan_resume)
> +	SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +			   sdhci_arasan_runtime_resume, NULL) };
>=20
>  static const struct of_device_id sdhci_arasan_of_match[] =3D {
>  	/* SoC-specific compatible strings w/ soc_ctl_map */ @@ -821,6
> +889,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_add_host;
>=20
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +
> SDHCI_ARASAN_AUTOSUSPEND_DELAY);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_forbid(&pdev->dev);
> +
>  	return 0;
>=20
>  err_add_host:
> --
> 2.1.1
