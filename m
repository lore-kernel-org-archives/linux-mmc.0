From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCH v5 2/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Fri, 4 Mar 2016 11:14:33 +0200
Message-ID: <56D951F9.6060602@intel.com>
References: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
 <1455848420-2293-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48008 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758790AbcCDJSM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2016 04:18:12 -0500
In-Reply-To: <1455848420-2293-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On 19/02/16 04:20, Shawn Lin wrote:
> This patch adds Generic PHY access for sdhci-of-arasan. Driver
> can get PHY handler from dt-binding, and power-on/init the PHY.
> Currently, it's just mandatory for arasan,sdhci-5.1.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sorry for the slow reply.  Was on vacation and am still catching up.

First, the patch does not apply cleanly so you will have to re-base I am afraid.

> 
> Serise-changes: 5
> - remove rpm support from this serise
> - fix some err case for handling phy
> 
> Serise-changes: 4
> - remove suspend/resume_phy
> - add err handle label for system PM callback
> - fix comments of struct sdhci_arasan_data and system PM
>   callback suggested by Michal
> 
> Serise-changes: 3
> - remove phy_init/exit for suspend/resume
> - adjust phy_int/power_on seq to make code more reasonable
> - simplify suspend/resume_phy
> 
> Serise-changes: 2
> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
> 
> ---
> 
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 66 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 5d9fdb3..cc40b1d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/phy/phy.h>
>  #include "sdhci-pltfm.h"
>  
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> @@ -32,9 +33,11 @@
>  /**
>   * struct sdhci_arasan_data
>   * @clk_ahb:	Pointer to the AHB clock
> + * @phy: Pointer to the generic phy
>   */
>  struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
> +	struct phy	*phy;
>  };
>  
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
> @@ -72,7 +75,7 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
>   * @dev:	Address of the device structure
> - * Returns 0 on success and error value on error
> + * Return: 0 on success and error value on error

Really should be a separate patch for the comment fixes.

>   *
>   * Put the device in a low power state.
>   */
> @@ -88,6 +91,14 @@ static int sdhci_arasan_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		ret = phy_power_off(sdhci_arasan->phy);
> +		if (ret) {
> +			dev_err(dev, "Cannot power off phy.\n");

I would expect you ought to call sdhci_resume_host() here.

> +			return ret;
> +		}
> +	}
> +
>  	clk_disable(pltfm_host->clk);
>  	clk_disable(sdhci_arasan->clk_ahb);
>  
> @@ -97,7 +108,7 @@ static int sdhci_arasan_suspend(struct device *dev)
>  /**
>   * sdhci_arasan_resume - Resume method for the driver
>   * @dev:	Address of the device structure
> - * Returns 0 on success and error value on error
> + * Return: 0 on success and error value on error
>   *
>   * Resume operation after suspend
>   */
> @@ -118,11 +129,24 @@ static int sdhci_arasan_resume(struct device *dev)
>  	ret = clk_enable(pltfm_host->clk);
>  	if (ret) {
>  		dev_err(dev, "Cannot enable SD clock.\n");
> -		clk_disable(sdhci_arasan->clk_ahb);
> -		return ret;
> +		goto err_clk_en;
> +	}
> +
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		ret = phy_power_on(sdhci_arasan->phy);
> +		if (ret) {
> +			dev_err(dev, "Cannot power on phy.\n");
> +			goto err_phy_power;
> +		}
>  	}
>  
>  	return sdhci_resume_host(host);
> +
> +err_phy_power:
> +	clk_disable(pltfm_host->clk);
> +err_clk_en:
> +	clk_disable(sdhci_arasan->clk_ahb);

I don't know that disabling clocks is necessarily the right thing to do if
the resume fails.  You might want to consider what happens if the system
tries to use the device when it is in that state.  It's been a long time
since I did any ARM work but aren't you risking bus errors.  Might just as
well not bother and save a few lines of code.

> +	return ret;
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
>  
> @@ -183,6 +207,30 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto clk_disable_all;
>  	}
>  
> +	sdhci_arasan->phy = ERR_PTR(-ENODEV);
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "arasan,sdhci-5.1")) {
> +		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
> +						 "phy_arasan");
> +		if (IS_ERR(sdhci_arasan->phy)) {
> +			ret = PTR_ERR(sdhci_arasan->phy);
> +			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
> +			goto clk_disable_all;
> +		}
> +
> +		ret = phy_init(sdhci_arasan->phy);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "phy_init err.\n");
> +			goto clk_disable_all;
> +		}
> +
> +		ret = phy_power_on(sdhci_arasan->phy);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "phy_power_on err.\n");
> +			goto err_phy_power;
> +		}
> +	}
> +
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto err_pltfm_free;
> @@ -190,7 +238,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_pltfm_free:
> +	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_power_off(sdhci_arasan->phy);
>  	sdhci_pltfm_free(pdev);
> +err_phy_power:
> +	if (!IS_ERR(sdhci_arasan->phy))

Looks like you are using sdhci_arasan after it has been free'd by
sdhci_pltfm_free().

Also there seem to be cases where sdhci_arasan_probe() can exit after
sdhci_pltfm_init() without calling sdhci_pltfm_free().

> +		phy_exit(sdhci_arasan->phy);
>  clk_disable_all:
>  	clk_disable_unprepare(clk_xin);
>  clk_dis_ahb:
> @@ -205,6 +258,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
>  
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		phy_power_off(sdhci_arasan->phy);
> +		phy_exit(sdhci_arasan->phy);
> +	}
> +

When you re-base, take care to keep this chunk above sdhci_pltfm_unregister().

>  	clk_disable_unprepare(sdhci_arasan->clk_ahb);
>  
>  	return sdhci_pltfm_unregister(pdev);
> 

