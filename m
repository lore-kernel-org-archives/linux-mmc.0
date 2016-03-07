From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 2/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Mon, 7 Mar 2016 14:07:01 +0200
Message-ID: <56DD6EE5.2090801@intel.com>
References: <1457144633-30615-1-git-send-email-shawn.lin@rock-chips.com>
 <1457144676-30697-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16745 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbcCGMKs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Mar 2016 07:10:48 -0500
In-Reply-To: <1457144676-30697-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On 05/03/16 04:24, Shawn Lin wrote:
> This patch adds Generic PHY access for sdhci-of-arasan. Driver
> can get PHY handler from dt-binding, and power-on/init the PHY.
> Currently, it's just mandatory for arasan,sdhci-5.1.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Serise-changes: 6
> - rebase on Ulf's next
> - fix some preexisting problems of err handling suggested
>   by Adrian
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
>   simplify suspend/resume_phy
> 
> Serise-changes: 2
> - Keep phy as a mandatory requirement for arasan,sdhci-5.1
> 


It looks good, but, sorry to be a pain, the fixes to the error handling
really have to be separate patches.  I would make a separate patch for
removing clk_disable(sdhci_arasan->clk_ahb) from sdhci_arasan_resume() and
another for the error handling fixes in sdhci_arasan_probe().

By the way, those "Serise-changes" should not be in the commit msg.

> ---
> 
> Changes in v6: None
> Changes in v2: None
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 71 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 1e4b5e0..2e482b1 100644
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
> @@ -88,6 +91,15 @@ static int sdhci_arasan_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		ret = phy_power_off(sdhci_arasan->phy);
> +		if (ret) {
> +			dev_err(dev, "Cannot power off phy.\n");
> +			sdhci_resume_host(host);
> +			return ret;
> +		}
> +	}
> +
>  	clk_disable(pltfm_host->clk);
>  	clk_disable(sdhci_arasan->clk_ahb);
>  
> @@ -118,10 +130,17 @@ static int sdhci_arasan_resume(struct device *dev)
>  	ret = clk_enable(pltfm_host->clk);
>  	if (ret) {
>  		dev_err(dev, "Cannot enable SD clock.\n");
> -		clk_disable(sdhci_arasan->clk_ahb);
>  		return ret;
>  	}
>  
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		ret = phy_power_on(sdhci_arasan->phy);
> +		if (ret) {
> +			dev_err(dev, "Cannot power on phy.\n");
> +			return ret;
> +		}
> +	}
> +
>  	return sdhci_resume_host(host);
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
> @@ -148,19 +167,21 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
>  	if (IS_ERR(sdhci_arasan->clk_ahb)) {
>  		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
> -		return PTR_ERR(sdhci_arasan->clk_ahb);
> +		ret = PTR_ERR(sdhci_arasan->clk_ahb);
> +		goto err_pltfm_free;
>  	}
>  
>  	clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
>  	if (IS_ERR(clk_xin)) {
>  		dev_err(&pdev->dev, "clk_xin clock not found.\n");
> -		return PTR_ERR(clk_xin);
> +		ret = PTR_ERR(clk_xin);
> +		goto err_pltfm_free;
>  	}
>  
>  	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
> -		return ret;
> +		goto err_pltfm_free;
>  	}
>  
>  	ret = clk_prepare_enable(clk_xin);
> @@ -178,19 +199,48 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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
> -		goto err_pltfm_free;
> +		goto err_add_host;
>  
>  	return 0;
>  
> -err_pltfm_free:
> -	sdhci_pltfm_free(pdev);
> +err_add_host:
> +	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_power_off(sdhci_arasan->phy);
> +err_phy_power:
> +	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_exit(sdhci_arasan->phy);
>  clk_disable_all:
>  	clk_disable_unprepare(clk_xin);
>  clk_dis_ahb:
>  	clk_disable_unprepare(sdhci_arasan->clk_ahb);
> -
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
>  	return ret;
>  }
>  
> @@ -202,6 +252,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>  	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
>  
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		phy_power_off(sdhci_arasan->phy);
> +		phy_exit(sdhci_arasan->phy);
> +	}
> +
>  	ret = sdhci_pltfm_unregister(pdev);
>  
>  	clk_disable_unprepare(clk_ahb);
> 

