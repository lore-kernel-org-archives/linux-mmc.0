From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for pre divider
 initial value
Date: Tue, 11 Aug 2015 08:11:36 +0000
Message-ID: <1439280697.3120.98.camel@transmode.se>
References: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:56978 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079AbbHKILm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Aug 2015 04:11:42 -0400
In-Reply-To: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
Content-Language: en-US
Content-ID: <1AFE9721A189294B9A1D30E3186A692A@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "yangbo.lu@freescale.com" <yangbo.lu@freescale.com>

On Tue, 2015-08-11 at 10:53 +0800, Yangbo Lu wrote:
> For eSDHC(version < 2.3), the pre divider only could divide base clock
> by 2 at least. Add workaround for this to avoid unexpected issue.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
Thanks a lot, here is my:

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 797be75..653f335 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -208,6 +208,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if (clock == 0)
>  		return;
>  
> +	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
> +	temp = esdhc_readw(host, SDHCI_HOST_VERSION);
> +	temp = (temp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +	if (temp < VENDOR_V_23)
> +		pre_div = 2;
> +
>  	/* Workaround to reduce the clock frequency for p1010 esdhc */
>  	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>  		if (clock > 20000000)
