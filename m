From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci_f_sdh30: add ACPI support
Date: Mon, 8 Jan 2018 11:18:04 +0200
Message-ID: <7bf350dc-4e2a-52f0-408f-36c5c7ca689d@intel.com>
References: <20171227181420.6230-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10044 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756030AbeAHJSh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jan 2018 04:18:37 -0500
In-Reply-To: <20171227181420.6230-1-ard.biesheuvel@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On 27/12/17 20:14, Ard Biesheuvel wrote:
> The Fujitsu SDH30 SDHCI controller may be described as a SCX0002 ACPI
> device on ACPI platforms incorporating the Socionext SynQuacer SoC.
> 
> Given that mmc_of_parse() has already been made ACPI/DT agnostic,
> making the SDH30 driver ACPI capable is actually rather simple:
> all we need to do is make the call to sdhci_get_of_property() [which
> does not set any properties we care about] and the clock handling
> dependent on whether we are dealing with a DT device, and exposing
> the ACPI id via the platform_driver struct and the module metadata.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 53 +++++++++++++-------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 04ca0d33a521..102321a9ea34 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -10,6 +10,7 @@
>   * the Free Software Foundation, version 2 of the License.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> @@ -146,7 +147,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, host);
>  
> -	sdhci_get_of_property(pdev);
>  	host->hw_name = "f_sdh30";
>  	host->ops = &sdhci_f_sdh30_ops;
>  	host->irq = irq;
> @@ -158,25 +158,29 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
> -	if (IS_ERR(priv->clk_iface)) {
> -		ret = PTR_ERR(priv->clk_iface);
> -		goto err;
> -	}
> +	if (dev_of_node(dev)) {
> +		sdhci_get_of_property(pdev);
>  
> -	ret = clk_prepare_enable(priv->clk_iface);
> -	if (ret)
> -		goto err;
> +		priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
> +		if (IS_ERR(priv->clk_iface)) {
> +			ret = PTR_ERR(priv->clk_iface);
> +			goto err;
> +		}
>  
> -	priv->clk = devm_clk_get(&pdev->dev, "core");
> -	if (IS_ERR(priv->clk)) {
> -		ret = PTR_ERR(priv->clk);
> -		goto err_clk;
> -	}
> +		ret = clk_prepare_enable(priv->clk_iface);
> +		if (ret)
> +			goto err;
>  
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret)
> -		goto err_clk;
> +		priv->clk = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(priv->clk)) {
> +			ret = PTR_ERR(priv->clk);
> +			goto err_clk;
> +		}
> +
> +		ret = clk_prepare_enable(priv->clk);
> +		if (ret)
> +			goto err_clk;
> +	}
>  
>  	/* init vendor specific regs */
>  	ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
> @@ -217,8 +221,10 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
>  			  0xffffffff);
>  
> -	clk_disable_unprepare(priv->clk_iface);
> -	clk_disable_unprepare(priv->clk);
> +	if (dev_of_node(priv->dev)) {

You check dev_of_node(priv->dev) here but not in the error path of
sdhci_f_sdh30_probe().  I guess passing NULL to clk_disable_unprepare() is
OK anyway, so is the check needed at all?

> +		clk_disable_unprepare(priv->clk_iface);
> +		clk_disable_unprepare(priv->clk);
> +	}
>  
>  	sdhci_free_host(host);
>  	platform_set_drvdata(pdev, NULL);
> @@ -232,10 +238,19 @@ static const struct of_device_id f_sdh30_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id f_sdh30_acpi_ids[] = {
> +	{ "SCX0002" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, f_sdh30_acpi_ids);
> +#endif
> +
>  static struct platform_driver sdhci_f_sdh30_driver = {
>  	.driver = {
>  		.name = "f_sdh30",
>  		.of_match_table = f_sdh30_dt_ids,

Perhaps you should tidy up the Kconfig too e.g.

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index cc4fd07735a7..55aee47df96c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -320,8 +320,7 @@ config MMC_SDHCI_BCM_KONA

 config MMC_SDHCI_F_SDH30
        tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
        depends on MMC_SDHCI_PLTFM
-       depends on OF
+       depends on OF || ACPI
        help
          This selects the Secure Digital Host Controller Interface (SDHCI)
          Needed by some Fujitsu SoC for MMC / SD / SDIO support.

Then consider using of_match_ptr() and #ifdef CONFIG_OF around
f_sdh30_acpi_ids so it all looks nice and symmetrical.

> +		.acpi_match_table = ACPI_PTR(f_sdh30_acpi_ids),
>  		.pm	= &sdhci_pltfm_pmops,
>  	},
>  	.probe	= sdhci_f_sdh30_probe,
> 

