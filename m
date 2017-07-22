From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: use io functions from sdhci.h
Date: Sat, 22 Jul 2017 21:17:48 +0800
Message-ID: <2a5b8508-486a-8f02-8e6a-6259261bef01@rock-chips.com>
References: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:34763 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdGVNSX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jul 2017 09:18:23 -0400
In-Reply-To: <20170717012332.16505-1-jeff.dagenais@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, michal.simek@xilinx.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org

ÔÚ 2017/7/17 9:23, Jean-Francois Dagenais Ð´µÀ:
> This increases consistency of the code across the sdhci family.
>
> v2: rebased onto ulfh/mmc/next and tweaked headline accordingly.
>
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Apart from the msg above,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

And I included your patch for my other test for sdhci-of-arasan this
afternoon, so

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>



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


-- 
Best Regards
Shawn Lin

