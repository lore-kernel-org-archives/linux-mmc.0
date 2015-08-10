From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: add workaround for pre divider
 initial value
Date: Mon, 10 Aug 2015 11:16:17 +0000
Message-ID: <1439205377.3120.72.camel@transmode.se>
References: <1438916192-48284-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:55339 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933273AbbHJLQW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 07:16:22 -0400
In-Reply-To: <1438916192-48284-1-git-send-email-yangbo.lu@freescale.com>
Content-Language: en-US
Content-ID: <B80DE551BDBF6145A66B9F8405E0C23B@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "yangbo.lu@freescale.com" <yangbo.lu@freescale.com>

On Fri, 2015-08-07 at 10:56 +0800, Yangbo Lu wrote:
> For eSDHC(version < 2.3), the pre divider only could divide base clock
> by 2 at least. Add workaround for this to avoid unexpected issue.

This works for me, I get my 50 MHz bus :)

I would rather se you used the proper register than that SDHCI_SLOT_INT_STATUS hack.
I replaced:
  temp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
with 
  temp = esdhc_readw(host, SDHCI_HOST_VERSION);
which yields the same working result for me.

With that change:

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 797be75..46edf2c 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -208,6 +208,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  	if (clock == 0)
>  		return;
>  
> +	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
> +	temp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +	temp = (temp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +	if (temp < VENDOR_V_23)
> +		pre_div = 2;
> +
>  	/* Workaround to reduce the clock frequency for p1010 esdhc */
>  	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>  		if (clock > 20000000)
