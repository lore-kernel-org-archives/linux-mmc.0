From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] mmc: esdhc i.MX: Fix version register read
Date: Tue, 25 Sep 2012 14:41:53 +0800
Message-ID: <20120925064151.GF27291@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50352 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab2IYGlm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 02:41:42 -0400
Received: by padhz1 with SMTP id hz1so1431204pad.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Sep 2012 23:41:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348471345-30785-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Mon, Sep 24, 2012 at 09:22:24AM +0200, Sascha Hauer wrote:
> The i.MX ESDHC controller version register is a mess:
> 
> - i.MX25 has a v1 controller which identifies itself as v2
> - i.MX6Q has a v3 controller which identifies itself as v4
> - i.MX35,51,53 have v2 controllers which identify themselves correctly
> 
> Additionally on i.MX the register is located at offset 0xfc instead of
> 0xfe. The i.MX6 had a quirk around it which converted v4 into v3. Instead

Ah, I added the quirk for i.MX6 without noticing that other SoCs have
the similar problem.

> of reading the real version register, all other SoCs used to return
> the value from 0xfe which contains 0x0 for all SoCs, so all controllers
> except i.MX6q were identified as version v1.
> 
> This patch fixes this by returning the version based on the devtype
> data leaving the useless version register untouched.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index e23f813..4fe7312 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -237,15 +237,20 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
>  
>  static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +
>  	if (unlikely(reg == SDHCI_HOST_VERSION)) {
> -		u16 val = readw(host->ioaddr + (reg ^ 2));
> -		/*
> -		 * uSDHC supports SDHCI v3.0, but it's encoded as value
> -		 * 0x3 in host controller version register, which violates
> -		 * SDHCI_SPEC_300 definition.  Work it around here.
> -		 */
> -		if ((val & SDHCI_SPEC_VER_MASK) == 3)
> -			return --val;
> +		switch (imx_data->devtype) {
> +		case IMX25_ESDHC:
> +			return SDHCI_SPEC_100;
> +		case IMX35_ESDHC:
> +		case IMX51_ESDHC:
> +		case IMX53_ESDHC:
> +			return SDHCI_SPEC_200;
> +		case IMX6Q_USDHC:
> +			return SDHCI_SPEC_300;
> +		}
>  	}
>  
>  	return readw(host->ioaddr + reg);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
