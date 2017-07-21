From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: use io functions from sdhci.h
Date: Fri, 21 Jul 2017 16:35:17 +0300
Message-ID: <b1ce691e-c389-9ff6-fa36-4c1169623187@intel.com>
References: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48197 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdGUNlg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Jul 2017 09:41:36 -0400
In-Reply-To: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

On 17/07/17 04:23, Jean-Francois Dagenais wrote:
> This increases consistency of the code across the sdhci family.
> 
> v2: rebased onto ulfh/mmc/next and tweaked headline accordingly.

As mentioned elsewhere, v2 comment doesn't belong in commit message.

> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b13c0a7d50e4..528a5d24c0bc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -216,13 +216,13 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	u32 vendor;
>  	struct sdhci_host *host = mmc_priv(mmc);
>  
> -	vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +	vendor = sdhci_readl(host, SDHCI_ARASAN_VENDOR_REGISTER);
>  	if (ios->enhanced_strobe)
>  		vendor |= VENDOR_ENHANCED_STROBE;
>  	else
>  		vendor &= ~VENDOR_ENHANCED_STROBE;
>  
> -	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +	sdhci_writel(host, vendor, SDHCI_ARASAN_VENDOR_REGISTER);
>  }
>  
>  static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> 

