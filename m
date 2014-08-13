From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH] mmc: sdhci: fix the wrong type of curr
Date: Wed, 13 Aug 2014 02:18:22 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A911B1F8F8@shsmsx102.ccr.corp.intel.com>
References: <20140801060012.GA2568@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20372 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488AbaHMCSn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 22:18:43 -0400
In-Reply-To: <20140801060012.GA2568@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Hello,

Any feedback on this fix?

Thanks
Chuanxiao

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> Sent: Friday, August 01, 2014 2:00 PM
> To: linux-mmc@vger.kernel.org; cjb@laptop.org; ulf.hansson@linaro.org
> Subject: [PATCH] mmc: sdhci: fix the wrong type of curr
> 
> curr should use signed type since it will contain the returned value which is
> possible to be a negative value. Using u32 will make the returned value to be
> true even there is a negative result.
> Change to use int instead of u32
> 
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 47055f3..c026ec8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3078,7 +3078,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	 */
>  	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
>  	if (!max_current_caps && host->vmmc) {
> -		u32 curr = regulator_get_current_limit(host->vmmc);
> +		int curr = regulator_get_current_limit(host->vmmc);
>  		if (curr > 0) {
> 
>  			/* convert to SDHCI_MAX_CURRENT format */
> --
> 1.7.10.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
