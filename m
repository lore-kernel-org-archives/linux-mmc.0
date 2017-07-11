From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: use functions and OFFSETS from
 sdhci.h
Date: Tue, 11 Jul 2017 08:34:43 +0800
Message-ID: <34227296-abfe-9191-3682-5d166ef12938@rock-chips.com>
References: <1499431410-11404-1-git-send-email-jeff.dagenais@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59048 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdGKAeh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jul 2017 20:34:37 -0400
In-Reply-To: <1499431410-11404-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, michal.simek@xilinx.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org

Hi,

On 2017/7/7 20:43, Jean-Francois Dagenais wrote:
> This increases consistency of the code across the sdhci family.
> 

You should rebase your patch on the next of Ulf's mmc tree.

sdhci_arasan_get_timeout_clock was removed.

> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index cdee35a..da9b824 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -33,7 +33,6 @@
>   #include "sdhci-pltfm.h"
>   #include <linux/of.h>
>   
> -#define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
>   #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
>   
>   #define VENDOR_ENHANCED_STROBE		BIT(0)
> @@ -179,7 +178,7 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>   	unsigned long freq;
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   
> -	div = readl(host->ioaddr + SDHCI_ARASAN_CLK_CTRL_OFFSET);
> +	div = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
>   	div = (div & CLK_CTRL_TIMEOUT_MASK) >> CLK_CTRL_TIMEOUT_SHIFT;
>   
>   	freq = clk_get_rate(pltfm_host->clk);
> @@ -451,13 +450,13 @@ static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>   	u32 vendor;
>   	struct sdhci_host *host = mmc_priv(mmc);
>   
> -	vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +	vendor = sdhci_readl(host, SDHCI_ARASAN_VENDOR_REGISTER);
>   	if (ios->enhanced_strobe)
>   		vendor |= VENDOR_ENHANCED_STROBE;
>   	else
>   		vendor &= ~VENDOR_ENHANCED_STROBE;
>   
> -	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +	sdhci_writel(host, vendor, SDHCI_ARASAN_VENDOR_REGISTER);
>   }
>   
>   static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
> 

