From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: use io functions from sdhci.h
Date: Mon, 17 Jul 2017 08:33:49 +0200
Message-ID: <60af517b-4a86-9150-901f-7e640bb517d9@xilinx.com>
References: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:4416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751253AbdGQGeA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 17 Jul 2017 02:34:00 -0400
In-Reply-To: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, adrian.hunter@intel.com, michal.simek@xilinx.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

On 17.7.2017 03:23, Jean-Francois Dagenais wrote:
> This increases consistency of the code across the sdhci family.
> 
> v2: rebased onto ulfh/mmc/next and tweaked headline accordingly.

Information about patch version shouldn't be the part of commit message
but they should be placed below ---.

Thanks,
Michal


> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
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

