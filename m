From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC v2 2/2] sdhci: Prevent SD from doing high-speed timing when
 broken-highspeed property is set
Date: Mon, 17 Oct 2016 09:56:19 +0300
Message-ID: <58380ee1-15d0-9eb6-fe89-f1bb9ec24af2@intel.com>
References: <1476297656-7019-1-git-send-email-zach.brown@ni.com>
 <1476297656-7019-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29356 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbcJQHBU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 17 Oct 2016 03:01:20 -0400
In-Reply-To: <1476297656-7019-3-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>, ulf.hansson@linaro.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10/16 21:40, Zach Brown wrote:
> When the broken-highspeed property is set the sdhci driver will not
> go into highspeed mode even if the controller and card appear to
> otherwise support highspeed mode.
> 
> This is useful in cases where the controller and card support highspeed,
> but the board configuration or some other issue make highspeed
> impossible. For example, we send the SDIO lines through a fpga so we
> need the data to change on the falling edge of the clock or there will
> be issues with hold time.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>

Assuming the DT property is accepted:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4805566..17e6c50 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -22,6 +22,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>  
>  #include <linux/leds.h>
>  
> @@ -3274,7 +3275,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
>  		mmc->caps &= ~MMC_CAP_CMD23;
>  
> -	if (host->caps & SDHCI_CAN_DO_HISPD)
> +	if ((host->caps & SDHCI_CAN_DO_HISPD) &&
> +	    !(of_property_read_bool(mmc_dev(mmc)->of_node, "broken-highspeed")))
>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> 

