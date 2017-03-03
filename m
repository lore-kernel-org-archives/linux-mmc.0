From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/2] mmc: tegra: Support module reset
Date: Fri, 3 Mar 2017 09:36:02 +0200
Message-ID: <e8780361-5c61-2c6f-c62b-974e04f859ac@intel.com>
References: <20170223162342.15911-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2186 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbdCCHzs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 02:55:48 -0500
In-Reply-To: <20170223162342.15911-1-thierry.reding@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On 23/02/17 18:23, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The device tree binding for the SDHCI controller found on Tegra SoCs
> specifies that a reset control can be provided by the device tree. No
> code was ever added to support the module reset, which can cause the
> driver to try and access registers from a module that's in reset. On
> most Tegra SoC generations doing so would cause a hang.
> 
> Note that it's unlikely to see this happen because on most platforms
> these resets will have been deasserted by the bootloader. However the
> portability can be improved by making sure the driver deasserts the
> reset before accessing any registers.
> 
> Since resets are synchronous on Tegra SoCs, the platform driver needs
> to implement a custom ->remove() callback now to make sure the clock
> is disabled after the reset is asserted.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Apart from a nitpick below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - assert reset in ->probe() error path
> - remove unneeded PCI specific quirk
> 
>  drivers/mmc/host/sdhci-tegra.c | 43 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 20b6ff5b4af1..9ae5895678e8 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
> @@ -65,6 +66,8 @@ struct sdhci_tegra {
>  	struct gpio_desc *power_gpio;
>  	bool ddr_signaling;
>  	bool pad_calib_required;
> +
> +	struct reset_control *rst;
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -489,6 +492,25 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	clk_prepare_enable(clk);
>  	pltfm_host->clk = clk;
>  
> +	tegra_host->rst = devm_reset_control_get(&pdev->dev, "sdhci");
> +	if (IS_ERR(tegra_host->rst)) {
> +		rc = PTR_ERR(tegra_host->rst);
> +		dev_err(&pdev->dev, "failed to get reset control: %d\n", rc);
> +		goto err_rst_get;
> +	}
> +
> +	rc = reset_control_assert(tegra_host->rst);
> +	if (rc)
> +		goto err_rst_get;
> +
> +	usleep_range(2000, 4000);
> +
> +	rc = reset_control_deassert(tegra_host->rst);
> +	if (rc)
> +		goto err_rst_get;
> +
> +	usleep_range(2000, 4000);
> +
>  	rc = sdhci_add_host(host);
>  	if (rc)
>  		goto err_add_host;
> @@ -496,6 +518,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_add_host:
> +	reset_control_assert(tegra_host->rst);
> +err_rst_get:
>  	clk_disable_unprepare(pltfm_host->clk);
>  err_clk_get:
>  err_power_req:
> @@ -504,6 +528,23 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> +static int sdhci_tegra_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *platform = sdhci_priv(host);
> +	struct sdhci_tegra *tegra = sdhci_pltfm_priv(platform);

In other functions these are named 'pltfm_host' and 'tegra_host'.  Maybe
change them to be consistent.

> +
> +	sdhci_remove_host(host, 0);
> +
> +	reset_control_assert(tegra->rst);
> +	usleep_range(2000, 4000);
> +	clk_disable_unprepare(platform->clk);
> +
> +	sdhci_pltfm_free(pdev);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver sdhci_tegra_driver = {
>  	.driver		= {
>  		.name	= "sdhci-tegra",
> @@ -511,7 +552,7 @@ static struct platform_driver sdhci_tegra_driver = {
>  		.pm	= &sdhci_pltfm_pmops,
>  	},
>  	.probe		= sdhci_tegra_probe,
> -	.remove		= sdhci_pltfm_unregister,
> +	.remove		= sdhci_tegra_remove,
>  };
>  
>  module_platform_driver(sdhci_tegra_driver);
> 

