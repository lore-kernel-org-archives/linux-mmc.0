From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: disable SD clock for clock value 0
Date: Thu, 21 Sep 2017 11:25:46 +0300
Message-ID: <3a6b2d76-3a59-a52e-7ca8-27c39ae1f6e8@intel.com>
References: <20170921054238.46666-1-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbdIUIcg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Sep 2017 04:32:36 -0400
In-Reply-To: <20170921054238.46666-1-yangbo.lu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On 21/09/17 08:42, Yangbo Lu wrote:
> SD clock should be disabled for clock value 0. It's not
> right to just return. This may cause failure of signal
> voltage switching.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Minor comment below, nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d96a057a7db8..b21008729aeb 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -36,6 +36,8 @@ struct sdhci_esdhc {
>  	unsigned int peripheral_clock;
>  };
>  
> +static void esdhc_clock_enable(struct sdhci_host *host, bool enable);

We usually move functions rather than forward declare them.

> +
>  /**
>   * esdhc_read*_fixup - Fixup the value read from incompatible eSDHC register
>   *		       to make it compatible with SD spec.
> @@ -469,8 +471,10 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	host->mmc->actual_clock = 0;
>  
> -	if (clock == 0)
> +	if (clock == 0) {
> +		esdhc_clock_enable(host, false);
>  		return;
> +	}
>  
>  	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
>  	if (esdhc->vendor_ver < VENDOR_V_23)
> 

