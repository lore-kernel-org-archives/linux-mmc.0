From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: arasan: Add polling card detect
Date: Tue, 25 Apr 2017 13:31:08 +0300
Message-ID: <c41df518-ea54-7326-fe12-5d37433f7f68@intel.com>
References: <1492667088-20866-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1492667088-20866-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54302 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1176483AbdDYKgw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Apr 2017 06:36:52 -0400
In-Reply-To: <1492667088-20866-2-git-send-email-shubhrajyoti.datta@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com

On 20/04/17 08:44, Shubhrajyoti Datta wrote:
> Add MMC_CAP_NEEDS_POLL flag for card detect if
> no gpio is passed otherwise use gpio as card detect.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 812e75a..7e02190 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -728,6 +730,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_add_host;
>  
> +	if (mmc_card_is_removable(host->mmc) &&
> +	    mmc_gpio_get_cd(host->mmc) < 0) {
> +		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
> +	}
> +
>  	pm_runtime_put(&pdev->dev);
>  	return 0;
>  
> 

