From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a
Date: Tue, 25 Apr 2017 12:44:25 +0300
Message-ID: <a9567581-4b9e-584c-ab14-6955cce1b700@intel.com>
References: <1492671509-22044-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21982 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1428947AbdDYJuJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Apr 2017 05:50:09 -0400
In-Reply-To: <1492671509-22044-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 20/04/17 09:58, Yangbo Lu wrote:
> The ls1046a datasheet specified that the max SD clock frequency
> for eSDHC SDR104/HS200 was 167MHz, and the ls1012a datasheet
> specified it's 125MHz for ls1012a. So this patch is to add the
> limitation.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 49ac197..57966ef 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -456,6 +456,20 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if (esdhc->vendor_ver < VENDOR_V_23)
>  		pre_div = 2;
>  
> +	/*
> +	 * Limit SD clock to 167MHz for ls1046a according to its datasheet
> +	 */
> +	if (clock > 167000000 &&
> +	    of_find_compatible_node(NULL, NULL, "fsl,ls1046a-esdhc"))
> +		clock = 167000000;
> +
> +	/*
> +	 * Limit SD clock to 125MHz for ls1012a according to its datasheet
> +	 */
> +	if (clock > 125000000 &&
> +	    of_find_compatible_node(NULL, NULL, "fsl,ls1012a-esdhc"))
> +		clock = 125000000;
> +
>  	/* Workaround to reduce the clock frequency for p1010 esdhc */
>  	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>  		if (clock > 20000000)
> 

